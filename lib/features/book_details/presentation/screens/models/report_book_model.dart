import 'package:equatable/equatable.dart';

class ReportBookModel extends Equatable {
  const ReportBookModel({
    required this.loading,
    required this.error,
    required this.loaded,
  });

  final bool loading;
  final String error;
  final bool loaded;

  const ReportBookModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
        );

  bool get hasError => error.isNotEmpty;

  ReportBookModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
  }) {
    return ReportBookModel(
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
