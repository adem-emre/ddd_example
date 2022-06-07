import 'package:dartz/dartz.dart';
import 'package:ddd_example/domain/auth/auth_failure.dart';
import 'package:ddd_example/domain/auth/user.dart';
import 'package:ddd_example/domain/auth/value_objects.dart';

abstract class IAuthFacade{
  Option<User> getSignedInUser();
  Future<Either<AuthFailure,Unit>> registerWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  });
  Future<Either<AuthFailure,Unit>> signInWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  });
  Future<Either<AuthFailure,Unit>> signInWithGoogle();
  Future<void> signOut();
}