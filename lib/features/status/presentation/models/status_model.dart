import 'package:equatable/equatable.dart';

class StatusModel extends Equatable {
  const StatusModel({
    required this.isUserLoggedIn,
  });

  const StatusModel.initial() : this(isUserLoggedIn: false);

  final bool isUserLoggedIn;

  StatusModel copyWith({bool? isUserLoggedIn}) {
    return StatusModel(isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn);
  }

  @override
  List<Object?> get props => [isUserLoggedIn];
}
