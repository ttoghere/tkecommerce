import 'package:tkecommerce/models/user_model.dart';

abstract class BaseUserRepository {
  Stream<User> getUser({required String userId});
  Future<void> createUser({required User user});
  Future<void> updateUser({required User user});
}
