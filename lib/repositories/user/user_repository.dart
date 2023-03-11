// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tkecommerce/models/user_model.dart';
import 'package:tkecommerce/repositories/user/base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;
  UserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<void> createUser({required User user}) async {
    await _firebaseFirestore
        .collection("users")
        .doc(user.id)
        .set(user.toDocument());
  }

  @override
  Stream<User> getUser({required String userId}) {
    log("Getting User Data from Cloud Firestore");
    return _firebaseFirestore
        .collection("users")
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromJson(snap.data()!, snap.id));
  }

  @override
  Future<void> updateUser({required User user}) async {
    return _firebaseFirestore
        .collection("users")
        .doc(user.id)
        .update(user.toDocument())
        .then((value) => log("User Document Updated"));
  }
}
