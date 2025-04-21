import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';

abstract interface class StatusRepository {
  ResultFuture<bool> getUserLoginStatus();

  ResultVoid setUserLoginStatus(bool status);
}