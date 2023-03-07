// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tkecommerce/app_shelf.dart';
import 'package:tkecommerce/repositories/auth/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;
  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
    required UserRepository userRepository,
  })  : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _userRepository = userRepository;
  @override
  Future<auth.User?> signUp({
    required User user,
    required String password,
  }) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          )
          .then(
            (value) => _userRepository.createUser(
              user: user.copyWith(id: value.user!.uid),
            ),
          );
    } catch (_) {}
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on FirebaseException catch (error) {
      if (error.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(
          child: Text("User Not Found!!"),
        )));
      } else if (error.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(
          child: Text("Wrong Password!!"),
        )));
      }
    }
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }
}
