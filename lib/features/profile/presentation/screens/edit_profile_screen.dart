import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/core/ui/widgets/default_button.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();
final nameController = TextEditingController();
final phoneController = TextEditingController();

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final event = context.read<ProfileCubit>();
    final model = event.state.model;
    final screenModel = model.screenModel;
    final profile = model.networkModel.profile;
    final name = profile.userName;
    final email = profile.userEmail;

    nameController.text = name;
    phoneController.text = profile.userPhone;

    event.profileScreenEvent(
      model.copyWith(
        screenModel: screenModel.copyWith(
          email: email,
          profilePic: profile.profileImage,
        ),
      ),
    );
  }

  void _showBottomSheet() {
    Future<String?> uploadImageToServer(XFile imageFile) async {
      try {
        // Step 1: Read the image file
        final imagePathFile = File(imageFile.path);
        final imageBytes = await imagePathFile.readAsBytes();

        // Step 2: Compress the image in a background thread
        final compressedBytes = await testComporessList(imageBytes);

        // Step 4: Write the compressed image to a temporary file
        final tempDir = Directory.systemTemp;
        final tempFile = File(path.join(tempDir.path, 'compressed_image.jpg'));
        await tempFile.writeAsBytes(compressedBytes);

        // final uri = Uri.parse(
        //     "$kBaseUrl/imagetourl.php?type=imagetourl&authid=$authId"); // Replace with your endpoint
        // final request = http.MultipartRequest('POST', uri);

        // Step 5: Prepare the HTTP multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            "$kBaseUrl/imagetourl.php?type=imagetourl&authid=$authId",
          ),
        );

        request.files.add(
          await http.MultipartFile.fromPath(
            'image', // field name expected by the server
            tempFile.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );

        // Add required headers
        request.headers.addAll({
          'Accept': '*/*',
          // 'Accept-Encoding': 'gzip, deflate, br',
          'User-Agent': 'PostmanRuntime/7.43.4',
          'Connection': 'keep-alive',
        });

        // Step 6: Send the request and handle the response
        final responseStream = await http.Client().send(request);
        final response = await http.Response.fromStream(responseStream);

        if (response.statusCode == 200) {
          final respStr = response.body;
          print(respStr);

          final data = jsonDecode(respStr);
          final url = data['url'] as String;
          return url; // or parse JSON here if needed
        } else {
          print("Upload failed with status: ${response.statusCode}");
          return null;
        }
      } catch (e) {
        print("Upload error: $e");
        return null;
      }
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        final event = context.read<ProfileCubit>();
        final model = event.state.model;
        final screenModel = model.screenModel;

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
          child: Column(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      // Do something with the selected image (e.g., update UI or upload)
                      final uploadedImageUrl = await uploadImageToServer(image);
                      event.profileScreenEvent(
                        model.copyWith(
                          screenModel: screenModel.copyWith(
                            profilePic: uploadedImageUrl,
                          ),
                        ),
                      );
                    }
                  },
                  child: Center(child: Text("Select Gallery")),
                ),
              ),
              Divider(height: 1),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      // Do something with the captured image
                      final uploadedImageUrl = await uploadImageToServer(image);
                      event.profileScreenEvent(
                        model.copyWith(
                          screenModel: screenModel.copyWith(
                            profilePic: uploadedImageUrl,
                          ),
                        ),
                      );
                    }
                  },
                  child: Center(child: Text("Camera")),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profilePic = state.model.screenModel.profilePic;

        return Center(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    profilePic,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: _showBottomSheet,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.camera_alt, size: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNameEmailText() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = state.model.networkModel.profile;
        final name = profile.userName;
        final email = profile.userEmail;

        return Column(
          children: [
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              email,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    bool obscureText = false,
    bool readOnly = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final model = state.model;
          final screenModel = model.screenModel;
          final event = context.read<ProfileCubit>();

          final profile = model.networkModel.profile;

          //Email Controller
          final email = profile.userEmail;
          final emailController = TextEditingController(text: email);

          return Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildTextField(
                  label: 'Name',
                  controller: nameController,
                  validator: screenModel.validateName,
                  onChanged: (e) => event.profileScreenEvent(
                    model.copyWith(
                      screenModel: screenModel.addName(e),
                    ),
                  ),
                ),
                _buildTextField(
                  label: 'Email',
                  readOnly: true,
                  controller: emailController,
                ),
                _buildTextField(
                  label: 'Password',
                  obscureText: true,
                  validator: screenModel.validatePassword,
                  onChanged: (e) => event.profileScreenEvent(
                    model.copyWith(
                      screenModel: screenModel.addPassword(e),
                    ),
                  ),
                ),
                _buildTextField(
                  label: 'Phone',
                  controller: phoneController,
                  onChanged: (e) => event.profileScreenEvent(
                    model.copyWith(
                      screenModel: screenModel.addPhone(e),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DefaultButton(
                  text: "SAVE CHANGES",
                  borderRadius: 10,
                  opacity: screenModel.register,
                  loading: state is EditProfileLoading,
                  onTap: () {
                    event.editUserProfile(screenModel.data);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is EditProfileError) {
          showSnackBar(context, state.error);
        }

        if (state is EditProfileSuccess) {
          showSnackBar(context, "Profile Edited Successfully");
          context
              .read<ProfileCubit>()
              .getUserProfileEvent(state.model.screenModel.email);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text('Edit Profile'),
          backgroundColor: AppColors.background,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildAvatar(),
              _buildNameEmailText(),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Uint8List> testComporessList(Uint8List list) async {
  var result = await FlutterImageCompress.compressWithList(
    list,
    minHeight: 1920,
    minWidth: 1080,
    quality: 96,
    // rotate: 135,
  );
  print(list.length);
  print(result.length);
  return result;
}
