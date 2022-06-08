import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ddd_example/domain/auth/auth_failure.dart';
import 'package:ddd_example/domain/auth/i_auth_facade.dart';
import 'package:ddd_example/domain/auth/value_objects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<SignInFormEvent>((event, emit) async {
      Future<void> _performActionOnAuthFacadeWithEmailAndPassword(
          Future<Either<AuthFailure, Unit>> Function(
                  {required EmailAddress email, required Password password})
              forwardedCall) async {
        final isEmailValid = state.emailAddress.isValid();
        final isPasswordValid = state.password.isValid();
        Either<AuthFailure, Unit>? failureOrSuccess;
        if (isEmailValid && isPasswordValid) {
          emit(state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          ));
          failureOrSuccess = await forwardedCall(
            email: state.emailAddress,
            password: state.password,
          );
        }

        emit(state.copyWith(
          isSubmitting: false,
          showErrorMessages: true,
          authFailureOrSuccessOption: optionOf(failureOrSuccess),
        ));
      }

      await event.map<FutureOr<void>>(
          emailChanged: (e) => emit(state.copyWith(
                emailAddress: EmailAddress(e.emailStr),
                authFailureOrSuccessOption: none(),
              )),
          passwordChanged: (e) => emit(state.copyWith(
                password: Password(e.passwordStr),
                authFailureOrSuccessOption: none(),
              )),
          registerWithEmailAndPasswordPressed: (e) async {
            await _performActionOnAuthFacadeWithEmailAndPassword(
                _authFacade.registerWithEmailAndPassword);
          },
          signInWithEmailAndPasswordPressed: (e)async {
            await _performActionOnAuthFacadeWithEmailAndPassword(
                _authFacade.signInWithEmailAndPassword);
          },
          signInWithGooglePressed: (e) async {
            emit(state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            ));
            final failureOrSuccess = await _authFacade.signInWithGoogle();
            emit(state.copyWith(
              isSubmitting: false,
              authFailureOrSuccessOption: some(failureOrSuccess),
            ));
          });
    });
  }
}
