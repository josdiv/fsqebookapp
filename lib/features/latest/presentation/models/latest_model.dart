import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/entity/latest_entity.dart';

class LatestModel extends Equatable {
  const LatestModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.latestBooks,
  });

  const LatestModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          latestBooks: const [],
        );

  final bool loading;
  final String error;
  final bool loaded;
  final List<LatestEntity> latestBooks;

  bool get hasError => error.isNotEmpty;
  bool get loadOnce => loading && !loaded;

  LatestModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    List<LatestEntity>? latestBooks,
  }) {
    return LatestModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      latestBooks: latestBooks ?? this.latestBooks,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        latestBooks,
      ];
}
