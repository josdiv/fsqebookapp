import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/repository/book_details_repository.dart';

class ReportBook implements UsecaseWithParams<void, DataMap> {
  const ReportBook(this._repository);

  final BookDetailsRepository _repository;

  @override
  ResultFuture<void> call(DataMap params) async =>
      _repository.reportBook(params);
}
