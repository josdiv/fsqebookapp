import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/categories_screen/widgets/category_grid_widget.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/categories_screen/widgets/category_header_widget.dart';

import '../../../../../core/misc/spacer.dart';
import '../../cubits/categories_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getCategoriesEvent();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesErrorState) {
          Loader.hide();
        }

        if (state is CategoriesLoadedState) {
          Loader.hide();
        }
      },
      builder: (context, state) {
        return state is CategoriesLoadingState
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  VSpace(80),
                  CategoryHeaderWidget(),
                  state is CategoriesLoadedState
                      ? Expanded(
                          child: CategoryGridWidget(
                            categories: state.categories,
                          ),
                        )
                      : Text("Cannot Fetch Categories")
                ],
              );
      },
    );
  }
}
