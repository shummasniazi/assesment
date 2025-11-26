import 'package:equatable/equatable.dart';

/// Base failure class for domain layer errors
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Network related failures
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Server related failures
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Cache related failures
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
