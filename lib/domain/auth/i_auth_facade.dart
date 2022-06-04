import 'package:dartz/dartz.dart';
import 'package:ddd_example/domain/auth/auth_failure.dart';

abstract class IAuthFacade{
  Future<Either<AuthFailure,Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure,Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure,Unit>> signInWithGoogle();
}