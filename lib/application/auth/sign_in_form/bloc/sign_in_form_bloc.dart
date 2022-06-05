import 'package:dartz/dartz.dart';
import 'package:ddd_example/domain/auth/auth_failure.dart';
import 'package:ddd_example/domain/auth/value_objects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  SignInFormBloc() : super(SignInFormState.initial()) {
    on<SignInFormEvent>((event, emit) {});
  }
}
