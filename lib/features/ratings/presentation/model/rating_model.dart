import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/screens/model/rating_screen_model.dart';

class RatingModel extends Equatable {
  const RatingModel({required this.screenModel});

  final RatingScreenModel screenModel;

  const RatingModel.initial()
      : this(
          screenModel: const RatingScreenModel.initial(),
        );

  RatingModel copyWith({RatingScreenModel? screenModel}) {
    return RatingModel(screenModel: screenModel ?? this.screenModel);
  }

  @override
  List<Object?> get props => [screenModel];
}
