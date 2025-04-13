import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/cubits/authors_cubit.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/screens/authors_screen/widgets/authors_grid_widget.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/screens/authors_screen/widgets/authors_header_widget.dart';

import '../../../../../core/misc/spacer.dart';

class AuthorsScreen extends StatefulWidget {
  const AuthorsScreen({super.key});

  @override
  State<AuthorsScreen> createState() => _AuthorsScreenState();
}

class _AuthorsScreenState extends State<AuthorsScreen> {
  @override
  void initState() {
    context.read<AuthorsCubit>().getAuthorsEvent();
    super.initState();
  }

  // @override
  // void dispose() {
  //   Loader.hide();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorsCubit, AuthorsState>(
      listener: (context, state) {
        // final event = context.read<AuthorsCubit>();
        // final model = state.model;
        // final model1 = model.getAuthorsNetworkModel;
        //
        // if (model1.loading) {
        //   commonLoader(context);
        // }
        //
        // if (model1.hasError) {
        //   Loader.hide();
        //   showSnackBar(context, model1.error);
        //   event.authorScreenEvent(
        //     model.copyWith(
        //       getAuthorsNetworkModel: model1.copyWith(
        //         error: '',
        //       ),
        //     ),
        //   );
        // }
        //
        // if (model1.loaded) {
        //   Loader.hide();
        //   event.authorScreenEvent(
        //     model.copyWith(
        //       getAuthorsNetworkModel: model1.copyWith(
        //         loaded: false,
        //       ),
        //     ),
        //   );
        // }
      },
      builder: (context, state) {
        final model = state.model;
        final model1 = model.getAuthorsNetworkModel;

        return Column(
          children: [
            VSpace(80),
            AuthorsHeaderWidget(),
            model1.hasError
                ? Center(
                    child: Text("Cannot fetch Authors"),
                  )
                : Expanded(child: AuthorsGridWidget())
          ],
        );
      },
    );
  }
}
