import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/home_entity.dart';

class HomeModel extends Equatable {
  const HomeModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.homeData,
  });

  const HomeModel.initial()
      : this(
    loading: false,
    error: '',
    loaded: false,
    homeData: const HomeEntity.initial(),
  );

  final bool loading;
  final String error;
  final bool loaded;
  final HomeEntity homeData;

  bool get hasError => error.isNotEmpty;
  bool get loadOnce => loading && !loaded;

  HomeModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    HomeEntity? homeData,
  }) {
    return HomeModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      homeData: homeData ?? this.homeData,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    error,
    loaded,
    homeData,
  ];
}