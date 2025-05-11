import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/cubits/latest_cubit.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/screens/widgets/latest_grid_widget.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/screens/widgets/latest_header_widget.dart';

import '../../../../core/helper/common_loader.dart';
import '../../../../core/misc/spacer.dart';

class LatestScreen extends StatefulWidget {
  const LatestScreen({super.key});

  @override
  State<LatestScreen> createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LatestCubit>().getLatestBooksEvent();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LatestCubit, LatestState>(
      listener: (context, state) {
        final model = state.model;
        final event = context.read<LatestCubit>();

        if (model.hasError) {
          showSnackBar(context, model.error);

          event.latestScreenEvent(
            model.copyWith(
              error: '',
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            VSpace(80),
            LatestHeaderWidget(),
            Expanded(
              child: LatestGridWidget(),
            )
          ],
        );
      },
    );
  }
}
