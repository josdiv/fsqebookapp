import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/core/ui/widgets/default_button.dart';
import 'package:foursquare_ebbok_app/features/login/presentation/screens/login_screen/login_screen.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:foursquare_ebbok_app/features/settings/presentation/cubits/settings_cubit.dart';

import '../../../../status/presentation/cubits/status_cubit.dart';

final TextEditingController _emailController = TextEditingController();

class AccountDeletionScreen extends StatefulWidget {
  const AccountDeletionScreen({super.key});

  @override
  State<AccountDeletionScreen> createState() => _AccountDeletionScreenState();
}

class _AccountDeletionScreenState extends State<AccountDeletionScreen> {
  @override
  void initState() {
    final email =
        context.read<ProfileCubit>().state.model.networkModel.profile.userEmail;
    _emailController.text = email;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> showDeleteAccountDialog(
      BuildContext context, VoidCallback onConfirm) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete Account?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'This action is permanent and will delete all your data. '
            'Are you sure you want to continue?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                onConfirm(); // Proceed with deletion
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _reasonController = TextEditingController();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform the delete account logic here
      final email = _emailController.text.trim();
      final reason = _reasonController.text.trim();
      print('Email: $email\nReason: $reason');
      context.read<SettingsCubit>().requestAccountDeletionEvent({
        'email': email,
        'reason': reason,
      });
      // You can also show a confirmation dialog or snackbar here
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is RequestDeleteErrorState) {
          showSnackBar(context, state.error);
        }

        if (state is RequestDeleteLoadedState) {
          showSnackBar(context, 'Your Account has been Deleted successfully');
          Navigator.pop(context); // Close dialog
          context.read<StatusCubit>().setUserLoginStatusEvent(false);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Delete Account'),
            backgroundColor: AppColors.orangeColor,
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const Text(
                    'Please confirm your email and provide a reason for deleting your account.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),

                  // Email field
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      final email = value?.trim();
                      if (email == null || email.isEmpty) {
                        return 'Email is required';
                      }
                      final emailRegex =
                          RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(email)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Reason field
                  TextFormField(
                    controller: _reasonController,
                    decoration: const InputDecoration(
                      labelText: 'Reason for Deletion (Optional)',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 6,
                    // validator: (value) {
                    //   if (value == null || value.trim().isEmpty) {
                    //     return 'Please provide a reason';
                    //   }
                    //   return null;
                    // },
                  ),

                  const SizedBox(height: 32),

                  // Submit button
                  DefaultButton(
                    text: 'Submit Request',
                    onTap: () => showDeleteAccountDialog(context, _submit),
                    opacity: true,
                    loading: state is RequestDeleteLoadingState,
                  ),
                  // ElevatedButton(
                  //   onPressed: _submit,
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: AppColors.orangeColor,
                  //     padding: const EdgeInsets.symmetric(vertical: 16),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  //   child: const Text(
                  //     'Submit Request',
                  //     style: TextStyle(color: Colors.white, fontSize: 16),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
