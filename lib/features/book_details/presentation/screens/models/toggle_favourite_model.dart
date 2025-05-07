import 'package:equatable/equatable.dart';

class ToggleFavouriteModel extends Equatable {
  const ToggleFavouriteModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.message,
  });

  final bool loading;
  final String error;
  final bool loaded;
  final String message;

  const ToggleFavouriteModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          message: '',
        );

  bool get hasError => error.isNotEmpty;

  ToggleFavouriteModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    String? message,
  }) {
    return ToggleFavouriteModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        message,
      ];
}
