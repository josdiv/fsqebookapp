import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterwave_standard_smart/core/flutterwave.dart';
import 'package:flutterwave_standard_smart/models/requests/customer.dart';
import 'package:flutterwave_standard_smart/models/requests/customizations.dart';
import 'package:flutterwave_standard_smart/models/responses/charge_response.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/payment_keys/presentation/cubits/payment_keys_cubit.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';

import '../../../cubits/buy_book_cubit.dart';

handlePaymentInitialization(
    BuildContext context, PaymentKeysState state) async {
  final profile = context.read<ProfileCubit>().state.model.networkModel.profile;
  final book =
      context.read<BookDetailsCubit>().state.model.getBookDetailsModel.entity;
  // final flutterwaveKey = dotenv.env['FLUTTERWAVE_PUBLIC_TEST_KEY'];
  final flutterwaveKey = state is GetPaymentKeysSuccessState
      ? state.keys.flutterwavePublicKey
      : '';

  String generateTxRef(String userId) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'MyApp_$userId$timestamp';
  }

  final Customer customer = Customer(
    name: profile.userName,
    phoneNumber: profile.userPhone,
    email: profile.userEmail,
  );

  // FLWPUBK-725b27ca0d3ebff79133e09017eb0e46-X
  final Flutterwave flutterwave = Flutterwave(
    context: context,
    // publicKey: flutterwaveKey!,
    publicKey: flutterwaveKey,
    currency: "NGN",
    redirectUrl: "https://www.google.com",
    txRef: generateTxRef(profile.userId),
    amount: book.parsedPrice.toString(),
    customer: customer,
    paymentOptions: "ussd, card, barter, payattitude",
    customization: Customization(title: book.bookTitle),
    isTestMode: false,
  );

  final ChargeResponse response = await flutterwave.charge();
  // response.success
  if (response.success ?? false) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transaction Successful'),
          backgroundColor: Colors.blue,
        ),
      );
    }

    final data = {
      'bookId': book.bookId,
      'userId': profile.userId,
      'paymentId': response.txRef,
      'gateway': 'flutterwave',
    };

    if (context.mounted) {
      context.read<BuyBookCubit>().purchaseBookEvent(data);
    }
  } else {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Transaction Failed/Not successful::::',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
