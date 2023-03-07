// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_cubit.dart';

enum SignInStatus { initial, submitting, success, error }

class SignInState extends Equatable {
  final String email;
  final String password;
  final SignInStatus status;
  final auth.User? user;

  const SignInState({
    required this.email,
    required this.password,
    required this.status,
    this.user,
  });

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        user,
      ];

  factory SignInState.initial() {
    return const SignInState(
      email: "",
      password: "",
      status: SignInStatus.initial,
      user: null,
    );
  }

  SignInState copyWith({
    String? email,
    String? password,
    SignInStatus? status,
    auth.User? user,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  bool get stringify => true;
}
