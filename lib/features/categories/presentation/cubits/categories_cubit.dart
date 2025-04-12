import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/category_entity.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/usecases/get_categories.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/usecases/get_sub_categories.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/usecases/get_sub_categories_details.dart';

import '../../domain/entity/sub_category_details_entity.dart';
import '../../domain/entity/sub_category_entity.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({
    required GetCategories getCategories,
    required GetSubCategories getSubCategories,
    required GetSubCategoriesDetails getSubCategoriesDetails,
  })  : _getCategories = getCategories,
        _getSubCategories = getSubCategories,
        _getSubCategoriesDetails = getSubCategoriesDetails,
        super(CategoriesInitial());

  final GetCategories _getCategories;
  final GetSubCategories _getSubCategories;
  final GetSubCategoriesDetails _getSubCategoriesDetails;

  Future<void> getCategoriesEvent() async {
    emit(CategoriesLoadingState());

    final result = await _getCategories();

    result.fold(
      (l) => emit(
        CategoriesErrorState(
          l.errorMessage,
        ),
      ),
      (r) => emit(
        CategoriesLoadedState(r),
      ),
    );
  }

  Future<void> getSubCategoriesEvent(String id) async {
    emit(SubCategoriesLoadingState());

    final result = await _getSubCategories(id);
    print(result);

    result.fold(
      (l) => emit(
        SubCategoriesErrorState(
          l.errorMessage,
        ),
      ),
      (r){
        emit(
          SubCategoriesLoadedState(r),
        );
        print(r);
      }
    );
  }

  Future<void> getSubCategoriesDetailsEvent(String id) async {
    emit(SubCategoriesDetailsLoadingState());

    final result = await _getSubCategoriesDetails(id);

    result.fold(
      (l) => emit(
        SubCategoriesDetailsErrorState(
          l.errorMessage,
        ),
      ),
      (r) => emit(
        SubCategoriesDetailsLoadedState(r),
      ),
    );
  }
}
