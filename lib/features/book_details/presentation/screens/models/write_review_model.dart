import 'package:equatable/equatable.dart';

class WriteReviewModel extends Equatable {
  const WriteReviewModel({
    required this.loading,
    required this.error,
    required this.loaded,
  });

  final bool loading;
  final String error;
  final bool loaded;

  const WriteReviewModel.initial()
      : this(
    loading: false,
    error: '',
    loaded: false,
  );

  bool get hasError => error.isNotEmpty;

  WriteReviewModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
  }) {
    return WriteReviewModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    error,
    loaded,
  ];
}