import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/cubits/authors_cubit.dart';

import '../../../../../../core/helper/common_loader.dart';
import '../../author_details_screen/author_details_screen.dart';
import 'authors_card.dart';

class AuthorsGridWidget extends StatelessWidget {
  const AuthorsGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorsCubit, AuthorsState>(
      listener: (context, state) {
        final event = context.read<AuthorsCubit>();
        final model = state.model;
        final model1 = model.getSingleAuthorNetworkModel;

        if (model1.loading) {
          commonLoader(context);
        }

        if (model1.hasError) {
          Loader.hide();
          showSnackBar(context, model1.error);
          event.authorScreenEvent(
            model.copyWith(
              getSingleAuthorNetworkModel: model1.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (model1.loaded) {
          Loader.hide();
          event.authorScreenEvent(
            model.copyWith(
              getSingleAuthorNetworkModel: model1.copyWith(
                loaded: false,
              ),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthorDetailsScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        final event = context.read<AuthorsCubit>();
        final model = state.model;
        final model1 = model.getAuthorsNetworkModel;
        final items = model1.authors;
        final loading = model1.newLoading;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: .8, // Adjust to your needs
          ),
          itemCount: loading ? 9 : items.length,
          itemBuilder: (context, index) {
            if(loading) {
              return AuthorsCardShimmer();
            }
            return GestureDetector(
              onTap: () => event.getSingleAuthorEvent(items[index].authorId),
              child: AuthorsCard(
                url: items[index].authorImage,
                name: items[index].authorName,
              ),
            );
          },
        );
      },
    );
  }
}
