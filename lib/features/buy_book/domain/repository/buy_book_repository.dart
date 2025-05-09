import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';

abstract interface class BuyBookRepository {
  ResultVoid purchaseBook(DataMap data);
}