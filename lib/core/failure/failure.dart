import 'package:equatable/equatable.dart';

import 'exceptions.dart';

class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  String get errorMessage => message;

  @override
  // TODO: implement props
  List<Object?> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({
    required super.message,
    required super.statusCode,
  });

  APIFailure.fromException(APIException exception)
      : this(
    message: exception.message,
    statusCode: exception.statusCode,
  );
}
