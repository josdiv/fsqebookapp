import 'package:flutter/material.dart';
import 'package:flutterwave_standard_smart/core/flutterwave.dart';
import 'package:flutterwave_standard_smart/models/requests/customer.dart';
import 'package:flutterwave_standard_smart/models/requests/customizations.dart';
import 'package:flutterwave_standard_smart/models/responses/charge_response.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/core/ui/widgets/default_button.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/screens/buy_book_screen/widgets/buy_book_summary_widget.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/screens/buy_book_screen/widgets/payment_method_widget.dart';
// import 'package:paystack_for_flutter/paystack_for_flutter.dart';

class BuyBookScreen extends StatelessWidget {
  const BuyBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    handlePaymentInitialization() async {
      final Customer customer = Customer(
          name: "Flutterwave Developer",
          phoneNumber: "1234566677777",
          email: "customer@customer.com");
      final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWPUBK_TEST-094702635511968867736f3231112fbf-X",
        currency: "NGN",
        redirectUrl: "add-your-redirect-url-here",
        txRef: "add-your-unique-reference-heres",
        amount: "3000",
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "My Payment"),
        isTestMode: true,
      );

      final ChargeResponse response = await flutterwave.charge();
      // response.success
    }

    return Scaffold(
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
                onTap: () {
                  handlePaymentInitialization();
                  // PaystackFlutter().pay(
                  //   context: context,
                  //   secretKey: 'sk_test_83772c4211d8f0990272634452772373934562c9', // Your Paystack secret key gotten from your Paystack dashboard.
                  //   amount: 60000, // The amount to be charged in the smallest currency unit. If amount is 600, multiply by 100(600*100)
                  //   email: 'customeremail@gmail.com', // The customer's email address.
                  //   firstName: 'Victor', // Customer's first name
                  //   lastName: 'Ebuka', // Customer's last name
                  //   callbackUrl: 'https://callback.com', // The URL to which Paystack will redirect the user after the transaction.
                  //   showProgressBar: true, // If true, it shows progress bar to inform user an action is in progress when getting checkout link from Paystack.
                  //   paymentOptions: [PaymentOption.card, PaymentOption.bankTransfer, PaymentOption.mobileMoney],
                  //   currency: Currency.NGN,
                  //   metaData: {
                  //     "product_name": "Nike Sneakers",
                  //     "product_quantity": 3,
                  //     "product_price": 24000
                  //   }, // Additional metadata to be associated with the transaction
                  //   onSuccess: (paystackCallback){
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(content: Text('Transaction Successful::::${paystackCallback.reference}'),
                  //           backgroundColor: Colors.blue,
                  //         ));
                  //   }, // A callback function to be called when the payment is successful.
                  //   onCancelled: (paystackCallback){
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //           content: Text('Transaction Failed/Not successful::::${paystackCallback.reference}'),
                  //           backgroundColor: Colors.red,
                  //         ));
                  //   }, // A callback function to be called when the payment is canceled.
                  // );
                },
              ),
              VSpace(50)
            ],
          ),
        ),
      ),
    );
  }
}
