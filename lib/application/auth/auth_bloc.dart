import 'dart:async';

import 'package:ddd_example/domain/auth/i_auth_facade.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;

  AuthBloc(this._authFacade) : super(const _Initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map<FutureOr<void>>(
          authCheckRequested: (e) {
            final useroption = _authFacade.getSignedInUser();
            emit(useroption.fold(() => const AuthState.unauthenticated(),
                (_) => const AuthState.authenticated()));
          },
          signedOut: (e) async {
            await _authFacade.signOut();
            emit(const AuthState.unauthenticated());
          });
    });
  }
}
