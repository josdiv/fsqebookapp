import 'package:equatable/equatable.dart';

class APIException extends Equatable implements Exception {
  const APIException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

// class APIException extends ServerException{
//   const APIException({required super.message, required super.statusCode,});
// }