import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/cubits/buy_book_cubit.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({super.key});

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  int _selectedIndex = 0;

  void selectPaymentMethod(int index) {
    final event = context.read<BuyBookCubit>();
    final model = event.state.model;
    final screenModel = model.screenModel;

    event.buyBookScreenEvent(
      model.copyWith(
        screenModel: screenModel.copyWith(
          isPaystack: index == 0,
        ),
      ),
    );
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Payment Method",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.blueColor,
          ),
        ),
        VSpace(10),
        paymentCard(
          active: _selectedIndex == 0,
          title: 'Paystack',
          logo: 'paystack-logo.png',
          onTap: () => selectPaymentMethod(0),
        ),
        VSpace(20),
        paymentCard(
          active: _selectedIndex == 1,
          title: 'Flutterwave',
          logo: 'flutterwave_logo.jpg',
          onTap: () => selectPaymentMethod(1),
        ),
      ],
    );
  }

  Widget paymentCard({
    required bool active,
    required String title,
    required String logo,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              // padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                // color: Colors.white,
                border: Border.all(width: 2, color: Colors.grey),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: active
                  ? Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
            HSpace(10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Image.asset(
              'assets/images/$logo',
              fit: BoxFit.cover,
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
