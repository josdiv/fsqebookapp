import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/cubits/authors_cubit.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/screens/authors_screen/widgets/authors_grid_widget.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/screens/authors_screen/widgets/authors_header_widget.dart';

import '../../../../../core/helper/common_loader.dart';
import '../../../../../core/misc/spacer.dart';

class AuthorsScreen extends StatefulWidget {
  const AuthorsScreen({super.key});

  @override
  State<AuthorsScreen> createState() => _AuthorsScreenState();
}

class _AuthorsScreenState extends State<AuthorsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<AuthorsCubit>()
        .getAuthorsEvent();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorsCubit, AuthorsState>(
      listener: (context, state) {
        final event = context.read<AuthorsCubit>();
        final model = state.model;
        final model1 = model.getAuthorsNetworkModel;

        if (model1.hasError) {
          showSnackBar(context, model1.error);
          event.authorScreenEvent(
            model.copyWith(
              getAuthorsNetworkModel: model1.copyWith(
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
            AuthorsHeaderWidget(),
            Expanded(child: AuthorsGridWidget())
          ],
        );
      },
    );
  }
}
