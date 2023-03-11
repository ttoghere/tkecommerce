import "package:flutter_bloc/flutter_bloc.dart";
import 'package:equatable/equatable.dart';
import 'package:tkecommerce/models/user_model.dart';
import 'package:tkecommerce/repositories/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;
  SignUpCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignUpState.initial());
  void userChanged(User user) {
    emit(state.copyWith(user: user, status: SignUpStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignUpStatus.initial));
  }

  Future<void> signUpWithCredentials() async {
    if (!state.isFormValid || state.status == SignUpStatus.submitting) return;
    emit(state.copyWith(status: SignUpStatus.submitting));
    try {
      var authUser = await _authRepository.signUp(
        user: state.user!,
        password: state.password,
      );
      emit(state.copyWith(status: SignUpStatus.success, authUser: authUser));
    } catch (_) {}
  }
}
