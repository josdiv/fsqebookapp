import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/models/download_book_model.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/models/get_book_details_model.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/models/read_book_model.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/models/report_book_model.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/models/toggle_favourite_model.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/models/write_review_model.dart';

class BookDetailsModel extends Equatable {
  const BookDetailsModel({
    required this.favStatus,
    required this.purchasedStatus,
    required this.getBookDetailsModel,
    required this.reportBookModel,
    required this.toggleFavouriteModel,
    required this.readBookModel,
    required this.downloadBookModel,
    required this.writeReviewModel,
  });

  const BookDetailsModel.initial()
      : this(
          favStatus: false,
          purchasedStatus: false,
          getBookDetailsModel: const GetBookDetailsModel.initial(),
          reportBookModel: const ReportBookModel.initial(),
          toggleFavouriteModel: const ToggleFavouriteModel.initial(),
          readBookModel: const ReadBookModel.initial(),
          downloadBookModel: const DownloadBookModel.initial(),
          writeReviewModel: const WriteReviewModel.initial(),
        );

  final bool favStatus;
  final bool purchasedStatus;
  final GetBookDetailsModel getBookDetailsModel;
  final ReportBookModel reportBookModel;
  final ToggleFavouriteModel toggleFavouriteModel;
  final ReadBookModel readBookModel;
  final DownloadBookModel downloadBookModel;
  final WriteReviewModel writeReviewModel;

  BookDetailsModel copyWith({
    bool? favStatus,
    bool? purchasedStatus,
    GetBookDetailsModel? getBookDetailsModel,
    ReportBookModel? reportBookModel,
    ToggleFavouriteModel? toggleFavouriteModel,
    ReadBookModel? readBookModel,
    DownloadBookModel? downloadBookModel,
    WriteReviewModel? writeReviewModel,
  }) {
    return BookDetailsModel(
      favStatus: favStatus ?? this.favStatus,
      purchasedStatus: purchasedStatus ?? this.purchasedStatus,
      getBookDetailsModel: getBookDetailsModel ?? this.getBookDetailsModel,
      reportBookModel: reportBookModel ?? this.reportBookModel,
      toggleFavouriteModel: toggleFavouriteModel ?? this.toggleFavouriteModel,
      readBookModel: readBookModel ?? this.readBookModel,
      downloadBookModel: downloadBookModel ?? this.downloadBookModel,
      writeReviewModel: writeReviewModel ?? this.writeReviewModel,
    );
  }

  @override
  List<Object?> get props => [
        getBookDetailsModel,
        reportBookModel,
        toggleFavouriteModel,
        readBookModel,
        downloadBookModel,
        writeReviewModel,
        favStatus,
        purchasedStatus,
      ];
}
