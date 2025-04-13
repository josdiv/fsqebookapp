import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/usecases/get_categories.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/usecases/get_sub_categories.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/usecases/get_sub_categories_details.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/model/categories_model.dart';

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

  Future<void> categoriesScreenEvent(CategoriesModel model) async {
    emit(
      CategoriesScreenState(model),
    );
  }

  Future<void> getCategoriesEvent() async {
    final model = state.model;
    final model1 = model.model1;

    emit(
      CategoriesScreenState(
        model.copyWith(
          model1: model1.copyWith(
            loading: true,
            error: '',
          ),
        ),
      ),
    );

    final result = await _getCategories();

    result.fold(
      (l) => emit(
        CategoriesScreenState(
          model.copyWith(
            model1: model1.copyWith(
              loading: false,
              loaded: false,
              error: l.errorMessage,
            ),
          ),
        ),
      ),
      (r) => emit(
        CategoriesScreenState(
          model.copyWith(
            model1: model1.copyWith(
              loading: false,
              loaded: true,
              error: '',
              categories: r,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getSubCategoriesEvent(
      {required String id, required String categoryName}) async {
    final model = state.model;
    final model2 = model.model2;

    emit(
      CategoriesScreenState(
        model.copyWith(
          model2: model2.copyWith(
            loading: true,
            loaded: false,
            error: '',
          ),
        ),
      ),
    );

    final result = await _getSubCategories(id);

    result.fold(
      (l) => emit(
        CategoriesScreenState(
          model.copyWith(
            model2: model2.copyWith(
              loading: false,
              loaded: false,
              error: l.errorMessage,
            ),
          ),
        ),
      ),
      (r) => emit(
        CategoriesScreenState(
          model.copyWith(
            model2: model2.copyWith(
              loading: false,
              loaded: true,
              categoryName: categoryName,
              error: '',
              subCategories: r,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getSubCategoriesDetailsEvent({
    required String id,
    required String subCategoryName,
  }) async {
    final model = state.model;
    final model3 = model.model3;

    emit(
      CategoriesScreenState(
        model.copyWith(
          model3: model3.copyWith(
            loading: true,
            loaded: false,
            error: '',
          ),
        ),
      ),
    );

    final result = await _getSubCategoriesDetails(id);

    result.fold(
      (l) => emit(
        CategoriesScreenState(
          model.copyWith(
            model3: model3.copyWith(
              loading: false,
              loaded: false,
              error: l.errorMessage,
            ),
          ),
        ),
      ),
      (r) => emit(
        CategoriesScreenState(
          model.copyWith(
            model3: model3.copyWith(
              loading: false,
              loaded: true,
              subCategoryName: subCategoryName,
              error: '',
              subCategoryDetails: r,
            ),
          ),
        ),
      ),
    );
  }
}
