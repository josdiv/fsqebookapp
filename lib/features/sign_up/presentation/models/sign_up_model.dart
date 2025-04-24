import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/entity/user_entity.dart';
import 'package:foursquare_ebbok_app/features/sign_up/presentation/models/sign_up_network_model.dart';
import 'package:foursquare_ebbok_app/features/sign_up/presentation/models/sign_up_screen_model.dart';

class SignUpModel extends Equatable {
  const SignUpModel({
    required this.networkModel,
    required this.screenModel,
  });

  const SignUpModel.initial()
      : this(
    networkModel: const SignUpNetworkModel.initial(),
    screenModel: const SignUpScreenModel.initial(),
  );

  final SignUpNetworkModel networkModel;
  final SignUpScreenModel screenModel;


  SignUpModel copyWith({
    SignUpNetworkModel? networkModel,
    SignUpScreenModel? screenModel,
  }) {
    return SignUpModel(
      networkModel: networkModel ?? this.networkModel,
      screenModel: screenModel ?? this.screenModel,
    );
  }

  @override
  List<Object?> get props => [
    networkModel,
    screenModel,
  ];
}