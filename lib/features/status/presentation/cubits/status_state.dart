part of 'status_cubit.dart';

sealed class StatusState extends Equatable {
  const StatusState([this.model = const StatusModel.initial()]);

  final StatusModel model;

  @override
  List<Object> get props => [model];
}

final class StatusInitial extends StatusState {}

final class StatusScreenModel extends StatusState {
  const StatusScreenModel(super.model);
}
