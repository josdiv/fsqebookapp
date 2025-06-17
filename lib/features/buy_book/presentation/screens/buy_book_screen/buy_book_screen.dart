import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/core/ui/widgets/default_button.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/cubits/buy_book_cubit.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/screens/buy_book_screen/widgets/buy_book_summary_widget.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/screens/buy_book_screen/widgets/flutterwave_payment.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/screens/buy_book_screen/widgets/payment_method_widget.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/screens/buy_book_screen/widgets/paystack_payment.dart';
import 'package:foursquare_ebbok_app/features/payment_keys/presentation/cubits/payment_keys_cubit.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';

import '../buy_book_success_screen/buy_book_success_screen.dart';
// import 'package:paystack_for_flutter/paystack_for_flutter.dart';

class BuyBookScreen extends StatefulWidget {
  const BuyBookScreen({super.key});

  @override
  State<BuyBookScreen> createState() => _BuyBookScreenState();
}

class _BuyBookScreenState extends State<BuyBookScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PaymentKeysCubit>().getPaymentKeysEvent();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyBookCubit, BuyBookState>(
      listener: (context, state) {
        final model = state.model;

        final networkModel = model.networkModel;
        final event = context.read<BuyBookCubit>();

        if (networkModel.loading) {
          commonLoader(context);
        }

        if (networkModel.hasError && Loader.isShown) {
          Loader.hide();
          showSnackBar(context, networkModel.error);
          event.buyBookScreenEvent(
            model.copyWith(
              networkModel: networkModel.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (networkModel.loaded && Loader.isShown) {
          Loader.hide();
          final email = context
              .read<ProfileCubit>()
              .state
              .model
              .networkModel
              .profile
              .userEmail;
          context.read<ProfileCubit>().getUserProfileEvent(email);
          event.buyBookScreenEvent(
            model.copyWith(
              networkModel: networkModel.copyWith(
                loaded: false,
              ),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BuyBookSuccessScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        final model = state.model;
        final screenModel = model.screenModel;

        return BlocBuilder<PaymentKeysCubit, PaymentKeysState>(
          builder: (context, state) {
            return state is GetPaymentKeysErrorState ? PaymentFailureScreen() : Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      VSpace(70),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: AppColors.redColor,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      VSpace(50),
                      BuyBookSummaryWidget(),
                      VSpace(20),
                      Divider(),
                      VSpace(10),
                      PaymentMethodWidget(),
                      Spacer(),
                      DefaultButton(
                        text: 'PROCEED TO PAY',
                        opacity: true,
                        borderRadius: 40,
                        onTap: () => screenModel.isPaystack
                            ? handlePaystackPayment(context, state)
                            : handlePaymentInitialization(context, state),
                      ),
                      VSpace(50)
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class PaymentFailureScreen extends StatelessWidget {
  const PaymentFailureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Payment failure image
              Image.asset(
                'assets/images/payment_failed.png',
                // Ensure this file is in pubspec.yaml under assets
                // height: 200,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Try Again',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
