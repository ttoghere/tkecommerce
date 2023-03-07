// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, submitting, success, error }

class SignUpState extends Equatable {
  final String password;
  final SignUpStatus status;
  final auth.User? authUser;
  final User? user;
  SignUpState({
    required this.password,
    required this.status,
    this.authUser,
    this.user,
  });

  bool get isFormValid => user!.email.isNotEmpty && password.isNotEmpty;

  @override
  List<Object?> get props => [password, status, authUser, user];

  SignUpState copyWith({
    String? password,
    SignUpStatus? status,
    auth.User? authUser,
    User? user,
  }) {
    return SignUpState(
      password: password ?? this.password,
      status: status ?? this.status,
      authUser: authUser ?? this.authUser,
      user: user ?? this.user,
    );
  }

  @override
  bool get stringify => true;

  factory SignUpState.initial() {
    return SignUpState(
      password: "",
      status: SignUpStatus.initial,
      authUser: null,
      user: const User(),
    );
  }
}
