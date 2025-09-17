import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:archive/archive.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';

class EpubReaderScreen extends StatefulWidget {
  final String filePath;
  final String bookTitle;
  final bool fromUrl;

  const EpubReaderScreen({
    super.key,
    required this.filePath,
    required this.bookTitle,
    this.fromUrl = false,
  });

  @override
  State<EpubReaderScreen> createState() => _EpubReaderScreenState();

  /// Static method to extract cover image from EPUB file
  static Future<String?> extractCoverImage(String filePath) async {
    try {
      final epubFile = File(filePath);
      if (!await epubFile.exists()) return null;

      final bytes = await epubFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      // Find the OPF file
      String? opfPath;
      for (final file in archive) {
        if (file.name.endsWith('.opf')) {
          opfPath = file.name;
          break;
        }
      }

      if (opfPath == null) return null;

      // Read the OPF file
      final opfFile = archive.firstWhere((file) => file.name == opfPath);
      final opfContent = utf8.decode(opfFile.content as List<int>);

      // Look for cover image in manifest
      final manifestMatch =
          RegExp(r'<manifest[^>]*>(.*?)</manifest>', dotAll: true)
              .firstMatch(opfContent);
      if (manifestMatch == null) return null;

      final manifestContent = manifestMatch.group(1)!;

      // Look for cover image item
      final coverMatch = RegExp(
              r'<item[^>]*id="([^"]*)"[^>]*href="([^"]*)"[^>]*properties="([^"]*)"[^>]*>')
          .allMatches(manifestContent);

      for (final match in coverMatch) {
        final id = match.group(1)!;
        final href = match.group(2)!;
        final properties = match.group(3) ?? '';

        // Check if this is a cover image
        if (properties.contains('cover-image') ||
            id.toLowerCase().contains('cover') ||
            href.toLowerCase().contains('cover')) {
          // Find the image file in the archive
          final imageFile = archive.firstWhere(
            (f) => f.name.endsWith(href),
            orElse: () => archive.first,
          );

          // Convert to base64 for display
          final imageBytes = imageFile.content as List<int>;
          return base64Encode(imageBytes);
        }
      }

      // If no cover image found with properties, try to find common cover image names
      final commonCoverNames = [
        'cover.jpg',
        'cover.png',
        'cover.jpeg',
        'cover.gif'
      ];
      for (final coverName in commonCoverNames) {
        final imageFile = archive.firstWhere(
          (f) => f.name.toLowerCase().endsWith(coverName),
          orElse: () => archive.first,
        );

        final imageBytes = imageFile.content as List<int>;
        return base64Encode(imageBytes);
      }

      return null;
    } catch (e) {
      debugPrint('Failed to extract cover image: $e');
      return null;
    }
  }
}

class _EpubReaderScreenState extends State<EpubReaderScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  String _htmlContent = '';
  String _bookTitle = '';
  List<Map<String, String>> _chapters = [];
  int _currentChapterIndex = 0;
  String? _coverImageData;
  bool _showCoverPage = true;

  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  Future<void> _loadBook() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Load the EPUB file
      final epubFile = File(widget.filePath);
      if (!await epubFile.exists()) {
        throw Exception('EPUB file not found: ${widget.filePath}');
      }

      final bytes = await epubFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      // Find the OPF file
      String? opfPath;
      for (final file in archive) {
        if (file.name.endsWith('.opf')) {
          opfPath = file.name;
          break;
        }
      }

      if (opfPath == null) {
        throw Exception('OPF file not found in EPUB');
      }

      // Read the OPF file
      final opfFile = archive.firstWhere((file) => file.name == opfPath);
      final opfContent = utf8.decode(opfFile.content as List<int>);

      // Extract book title
      _bookTitle = _extractTitle(opfContent);

      // Extract cover image
      _extractCoverImage(opfContent, archive);

      // Extract chapters
      _chapters = _extractChapters(opfContent, archive);

      // Load first chapter
      if (_chapters.isNotEmpty) {
        await _loadChapter(0);
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  String _extractTitle(String opfContent) {
    final titleMatch =
        RegExp(r'<dc:title[^>]*>(.*?)</dc:title>').firstMatch(opfContent);
    return titleMatch?.group(1) ?? widget.bookTitle;
  }

  void _extractCoverImage(String opfContent, Archive archive) {
    try {
      // Look for cover image in manifest
      final manifestMatch =
          RegExp(r'<manifest[^>]*>(.*?)</manifest>', dotAll: true)
              .firstMatch(opfContent);
      if (manifestMatch == null) return;

      final manifestContent = manifestMatch.group(1)!;

      // First, try to find cover image by properties (most reliable)
      final coverMatch = RegExp(
              r'<item[^>]*id="([^"]*)"[^>]*href="([^"]*)"[^>]*(?:properties="([^"]*)")?[^>]*>')
          .allMatches(manifestContent);

      for (final match in coverMatch) {
        final id = match.group(1)!;
        final href = match.group(2)!;
        final properties = match.group(3) ?? '';

        // Check if this is explicitly marked as a cover image
        if (properties.contains('cover-image') ||
            properties.contains('cover') ||
            id.toLowerCase().contains('cover-image') ||
            id.toLowerCase().contains('cover_page')) {
          // Find the image file in the archive
          final imageFile = archive.firstWhere(
            (f) => f.name.endsWith(href),
            orElse: () => archive.first,
          );

          // Convert to base64 for display
          final imageBytes = imageFile.content as List<int>;
          _coverImageData = base64Encode(imageBytes);
          return; // Found the cover, exit
        }
      }

      // If no explicit cover found, look for spine item that might be the cover
      final spineMatch = RegExp(r'<spine[^>]*>(.*?)</spine>', dotAll: true)
          .firstMatch(opfContent);
      if (spineMatch != null) {
        final spineContent = spineMatch.group(1)!;
        final itemRefs = RegExp(r'<itemref[^>]*idref="([^"]*)"[^>]*>')
            .allMatches(spineContent);

        for (final itemRef in itemRefs) {
          final idref = itemRef.group(1)!;

          // Find this item in manifest
          final itemMatch = RegExp(r'<item[^>]*id="' +
                  idref +
                  r'"[^>]*href="([^"]*)"[^>]*media-type="([^"]*)"[^>]*>')
              .firstMatch(manifestContent);
          if (itemMatch != null) {
            final href = itemMatch.group(1)!;
            final mediaType = itemMatch.group(2)!;

            // Check if this is an image and might be a cover
            if (mediaType.startsWith('image/') &&
                (href.toLowerCase().contains('cover') ||
                    href.toLowerCase().contains('front') ||
                    href.toLowerCase().contains('title'))) {
              final imageFile = archive.firstWhere(
                (f) => f.name.endsWith(href),
                orElse: () => archive.first,
              );

              final imageBytes = imageFile.content as List<int>;
              _coverImageData = base64Encode(imageBytes);
              return;
            }
          }
        }
      }

      // Last resort: look for common cover image names
      final commonCoverNames = [
        'cover.jpg',
        'cover.png',
        'cover.jpeg',
        'cover.gif',
        'front-cover.jpg',
        'front-cover.png',
        'title.jpg',
        'title.png',
        'book-cover.jpg',
        'book-cover.png'
      ];

      for (final coverName in commonCoverNames) {
        final imageFile = archive.firstWhere(
          (f) => f.name.toLowerCase().endsWith(coverName),
          orElse: () => archive.first,
        );

        final imageBytes = imageFile.content as List<int>;
        _coverImageData = base64Encode(imageBytes);
        break;
      }
    } catch (e) {
      // Cover image extraction failed, but don't stop the book loading
      debugPrint('Failed to extract cover image: $e');
    }
  }

  List<Map<String, String>> _extractChapters(
      String opfContent, Archive archive) {
    final List<Map<String, String>> chapters = [];

    // Extract manifest items
    final manifestMatch =
        RegExp(r'<manifest[^>]*>(.*?)</manifest>', dotAll: true)
            .firstMatch(opfContent);
    if (manifestMatch == null) return chapters;

    final manifestContent = manifestMatch.group(1)!;
    final itemMatches = RegExp(
            r'<item[^>]*id="([^"]*)"[^>]*href="([^"]*)"[^>]*media-type="application/xhtml\+xml"[^>]*>')
        .allMatches(manifestContent);

    for (final match in itemMatches) {
      final id = match.group(1)!;
      final href = match.group(2)!;

      // Find the file in the archive
      final file = archive.firstWhere(
        (f) => f.name.endsWith(href),
        orElse: () => archive.first,
      );

      final content = utf8.decode(file.content as List<int>);
      final title = _extractChapterTitle(content);
      chapters.add({
        'id': id,
        'href': href,
        'title': title,
        'content': content,
      });
    }

    return chapters;
  }

  String _extractChapterTitle(String htmlContent) {
    final titleMatch =
        RegExp(r'<title[^>]*>(.*?)</title>').firstMatch(htmlContent);
    if (titleMatch != null) {
      return titleMatch.group(1) ?? 'Chapter';
    }

    final h1Match = RegExp(r'<h1[^>]*>(.*?)</h1>').firstMatch(htmlContent);
    if (h1Match != null) {
      return h1Match.group(1) ?? 'Chapter';
    }

    return 'Chapter';
  }

  Future<void> _loadChapter(int chapterIndex) async {
    if (chapterIndex < 0 || chapterIndex >= _chapters.length) return;

    setState(() {
      _currentChapterIndex = chapterIndex;
      _htmlContent = _chapters[chapterIndex]['content'] ?? '';
    });
  }

  void _nextChapter() {
    if (_showCoverPage) {
      // Move from cover page to first chapter
      setState(() {
        _showCoverPage = false;
      });
      if (_chapters.isNotEmpty) {
        _loadChapter(0);
      }
    } else if (_currentChapterIndex < _chapters.length - 1) {
      _loadChapter(_currentChapterIndex + 1);
    }
  }

  void _previousChapter() {
    if (_showCoverPage) {
      // Already at cover page, can't go back
      return;
    } else if (_currentChapterIndex > 0) {
      _loadChapter(_currentChapterIndex - 1);
    } else {
      // Go back to cover page
      setState(() {
        _showCoverPage = true;
        _htmlContent = '';
      });
    }
  }

  Widget _buildCoverPage() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Cover image
            if (_coverImageData != null) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    base64Decode(_coverImageData!),
                    width: 250,
                    height: 350,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 250,
                        height: 350,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.book,
                          size: 80,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
            // Book title
            Text(
              _bookTitle.isNotEmpty ? _bookTitle : widget.bookTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.blueColor,
              ),
            ),
            const SizedBox(height: 16),
            // Tap to continue instruction
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.blueColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Tap "Next" to start reading',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.blueColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _bookTitle.isNotEmpty ? _bookTitle : widget.bookTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.blueColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_chapters.isNotEmpty)
            PopupMenuButton<int>(
              icon: const Icon(Icons.menu, color: Colors.white),
              onSelected: (chapterIndex) {
                _loadChapter(chapterIndex);
              },
              itemBuilder: (context) {
                return _chapters.asMap().entries.map((entry) {
                  final index = entry.key;
                  final chapter = entry.value;
                  return PopupMenuItem<int>(
                    value: index,
                    child: Text(
                      chapter['title'] ?? 'Chapter ${index + 1}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList();
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.blueColor),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading book...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading book',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          _loadBook();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _htmlContent.isEmpty && !_showCoverPage
                  ? const Center(
                      child: Text(
                        'No content available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        // Progress indicator
                        if (_chapters.isNotEmpty && !_showCoverPage)
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  'Chapter ${_currentChapterIndex + 1} of ${_chapters.length}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  _chapters[_currentChapterIndex]['title'] ??
                                      'Chapter ${_currentChapterIndex + 1}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // Content area
                        Expanded(
                          child: _showCoverPage
                              ? _buildCoverPage()
                              : SingleChildScrollView(
                                  padding: const EdgeInsets.all(16),
                                  child: Html(
                                    data: _htmlContent,
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize(16),
                                        lineHeight: LineHeight(1.6),
                                        color: Colors.black87,
                                        margin: Margins.zero,
                                        padding: HtmlPaddings.zero,
                                      ),
                                      "h1": Style(
                                        fontSize: FontSize(24),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blueColor,
                                        margin: Margins.only(bottom: 16),
                                      ),
                                      "h2": Style(
                                        fontSize: FontSize(20),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blueColor,
                                        margin: Margins.only(bottom: 12),
                                      ),
                                      "h3": Style(
                                        fontSize: FontSize(18),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blueColor,
                                        margin: Margins.only(bottom: 8),
                                      ),
                                      "p": Style(
                                        margin: Margins.only(bottom: 12),
                                      ),
                                    },
                                  ),
                                ),
                        ),
                        // Navigation controls
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border(
                              top: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed:
                                    _showCoverPage || _currentChapterIndex > 0
                                        ? _previousChapter
                                        : null,
                                icon: const Icon(Icons.arrow_back),
                                label: const Text('Previous'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blueColor,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: _showCoverPage ||
                                        _currentChapterIndex <
                                            _chapters.length - 1
                                    ? _nextChapter
                                    : null,
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Next'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blueColor,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
    );
  }
}
