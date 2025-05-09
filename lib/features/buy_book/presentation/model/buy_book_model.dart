import 'package:equatable/equatable.dart';

class BuyBookModel extends Equatable {
  const BuyBookModel({
    required this.networkModel,
    required this.screenModel,
  });

  const BuyBookModel.initial()
      : this(
          networkModel: const BuyBookNetworkModel.initial(),
          screenModel: const BuyBookScreenModel.initial(),
        );

  final BuyBookNetworkModel networkModel;
  final BuyBookScreenModel screenModel;

  BuyBookModel copyWith({
    BuyBookNetworkModel? networkModel,
    BuyBookScreenModel? screenModel,
  }) {
    return BuyBookModel(
      networkModel: networkModel ?? this.networkModel,
      screenModel: screenModel ?? this.screenModel,
    );
  }

  @override
  List<Object?> get props => [networkModel, screenModel];
}

class BuyBookNetworkModel extends Equatable {
  const BuyBookNetworkModel({
    required this.loading,
    required this.error,
    required this.loaded,
  });

  final bool loading;
  final String error;
  final bool loaded;

  const BuyBookNetworkModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
        );

  bool get hasError => error.isNotEmpty;

  BuyBookNetworkModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
  }) {
    return BuyBookNetworkModel(
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

class BuyBookScreenModel extends Equatable {
  const BuyBookScreenModel({
    required this.isPaystack,
  });

  const BuyBookScreenModel.initial() : this(isPaystack: true);

  final bool isPaystack;

  BuyBookScreenModel copyWith({bool? isPaystack}) {
    return BuyBookScreenModel(
      isPaystack: isPaystack ?? this.isPaystack,
    );
  }

  @override
  List<Object?> get props => [isPaystack];
}
