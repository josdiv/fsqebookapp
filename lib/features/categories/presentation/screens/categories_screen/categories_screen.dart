import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/categories_screen/widgets/category_grid_widget.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/categories_screen/widgets/category_header_widget.dart';

import '../../../../../core/helper/common_loader.dart';
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
        final model = state.model;
        final model1 = model.model1;
        final event = context.read<CategoriesCubit>();

        if (model1.hasError) {
          showSnackBar(context, model1.error);
          event.categoriesScreenEvent(
            model.copyWith(
              model1: model1.copyWith(
                error: '',
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            VSpace(80),
            CategoryHeaderWidget(),
            Expanded(
              child: CategoryGridWidget(),
            )
          ],
        );
      },
    );
  }
}
