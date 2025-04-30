import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/core/ui/widgets/default_button.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
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
    return Center(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/profile.jpg'), // replace with your asset or network image
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
  }

  Widget _buildNameEmailText() {
    return Column(
      children: [
        SizedBox(height: 10),
        Text('John Doe',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text('john.doe@example.com',
            style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildTextField({required String label, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        obscureText: obscureText,
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
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildTextField(label: 'Name'),
            _buildTextField(label: 'Email'),
            _buildTextField(label: 'Password', obscureText: true),
            _buildTextField(label: 'Phone'),
            SizedBox(height: 20),
            DefaultButton(text: "SAVE CHANGES", borderRadius: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
