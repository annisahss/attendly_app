import '../entities/user.dart';

abstract class UserRepository {
  Future<User> register(String name, String email, String password);
  Future<User?> login(String email, String password);
  Future<User?> getUserById(int id);
  Future<void> updateUser(int id, String name, String email);
}
