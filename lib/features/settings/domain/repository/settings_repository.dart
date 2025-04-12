import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';

abstract interface class SettingsRepository {
  ResultFuture<String> getAboutUs();
  ResultFuture<String> getTermsOfUse();
  ResultVoid requestAccountDeletion(DataMap data);
}