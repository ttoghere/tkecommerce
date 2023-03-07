import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tkecommerce/repositories/auth/auth_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository;
  SignInCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignInState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(
      email: value,
      status: SignInStatus.initial,
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(
      password: value,
      status: SignInStatus.initial,
    ));
  }

  Future<void> loginWithCredentials() async {
    if (state.status == SignInStatus.submitting) return;
    emit(state.copyWith(status: SignInStatus.submitting));
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: SignInStatus.success));
    } catch (_) {}
  }
}
