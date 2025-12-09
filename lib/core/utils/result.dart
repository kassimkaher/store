import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';

typedef Result<T> = Either<Failure, T>;

extension ResultExtension<T> on Result<T> {
  /// Map success case
  Result<U> mapSuccess<U>(U Function(T) transform) {
    return fold(
      (failure) => Left(failure),
      (success) => Right(transform(success)),
    );
  }

  /// Map failure case
  Result<T> mapFailure(Failure Function(Failure) transform) {
    return fold(
      (failure) => Left(transform(failure)),
      (success) => Right(success),
    );
  }

  /// Get success value or null
  T? getOrNull() {
    return fold((failure) => null, (success) => success);
  }

  /// Get failure or null
  Failure? getFailureOrNull() {
    return fold((failure) => failure, (success) => null);
  }

  /// Check if success
  bool isSuccess() {
    return fold((failure) => false, (success) => true);
  }

  /// Check if failure
  bool isFailure() {
    return fold((failure) => true, (success) => false);
  }
}
