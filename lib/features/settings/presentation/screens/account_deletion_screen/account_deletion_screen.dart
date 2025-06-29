import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/core/ui/widgets/default_button.dart';
import 'package:foursquare_ebbok_app/features/settings/presentation/cubits/settings_cubit.dart';

class AccountDeletionScreen extends StatefulWidget {
  const AccountDeletionScreen({super.key});

  @override
  State<AccountDeletionScreen> createState() => _AccountDeletionScreenState();
}

class _AccountDeletionScreenState extends State<AccountDeletionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
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
          showSnackBar(context,
              'Your Request to Delete Account has been sent successfully');
          Navigator.pop(context);
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
                      labelText: 'Reason for Deletion',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 6,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please provide a reason';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // Submit button
                  DefaultButton(
                    text: 'Submit Request',
                    onTap: _submit,
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
