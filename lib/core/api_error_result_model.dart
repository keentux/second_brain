import 'package:equatable/equatable.dart';

class ApiErrorResultModel extends Equatable {
  final int? statusCode;
  final String? message;

  const ApiErrorResultModel({
    this.statusCode,
    this.message,
  });

  @override
  List<Object?> get props => <Object?>[
        statusCode,
        message,
      ];
}
