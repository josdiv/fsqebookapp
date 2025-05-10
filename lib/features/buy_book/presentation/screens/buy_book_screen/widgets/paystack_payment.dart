import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/cubits/buy_book_cubit.dart';
import 'package:paystack_for_flutter/paystack_for_flutter.dart';

import '../../../../../book_details/presentation/cubits/book_details_cubit.dart';
import '../../../../../profile/presentation/cubits/profile_cubit.dart';

handlePaystackPayment(BuildContext context) {
  final profile = context.read<ProfileCubit>().state.model.networkModel.profile;
  final book =
      context.read<BookDetailsCubit>().state.model.getBookDetailsModel.entity;
  final paystackKey = dotenv.env['PAYSTACK_SECRET_TEST_KEY'];

  print(paystackKey);

  PaystackFlutter().pay(
    context: context,
    secretKey: paystackKey!,
    // Your Paystack secret key gotten from your Paystack dashboard.
    amount: book.paystackPrice,
    // The amount to be charged in the smallest currency unit. If amount is 600, multiply by 100(600*100)
    email: profile.userEmail,
    // The customer's email address.
    firstName: profile.userName,
    // Customer's first name
    // lastName: 'Ebuka',
    // Customer's last name
    callbackUrl: 'https://callback.com',
    // The URL to which Paystack will redirect the user after the transaction.
    showProgressBar: true,
    // If true, it shows progress bar to inform user an action is in progress when getting checkout link from Paystack.
    paymentOptions: [
      PaymentOption.card,
      PaymentOption.bankTransfer,
      PaymentOption.bank,
      PaymentOption.ussd,
      // PaymentOption.mobileMoney
    ],
    currency: Currency.NGN,
    metaData: {
      "product_name": book.bookTitle,
      "product_quantity": 1,
      "product_price": book.paystackPrice,
    },
    // Additional metadata to be associated with the transaction
    onSuccess: (paystackCallback) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transaction Successful'),
          backgroundColor: Colors.blue,
        ),
      );

      final data = {
        'bookId': book.bookId,
        'userId': profile.userId,
        'paymentId': paystackCallback.reference,
        'gateway': 'paystack',
      };

      context.read<BuyBookCubit>().purchaseBookEvent(data);
    },
    // A callback function to be called when the payment is successful.
    onCancelled: (paystackCallback) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Transaction Failed/Not successful::::',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }, // A callback function to be called when the payment is canceled.
  );
}
