import 'package:flutter/material.dart';
import '../../core/services/preference_service.dart';
import '../../data/datasources/user_local_datasource.dart';

class AuthProvider with ChangeNotifier {
  final UserLocalDatasource _userData = UserLocalDatasource();

  int? _userId;
  String? _name;
  String? _email;

  int? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  bool get isLoggedIn => _userId != null;

  /// LOGIN: Validate credentials, store session
  Future<bool> login(String email, String password) async {
    final user = await _userData.loginUser(email, password);
    if (user != null) {
      _userId = user['id'];
      _name = user['name'];
      _email = user['email'];

      await PreferenceService.setLoginStatus(true);
      await loadUserFromDatabase(_userId!); // ensure info is up-to-date
      notifyListeners();
      return true;
    }
    return false;
  }

  /// REGISTER: Add new user to DB and mark logged in
  Future<void> register(String name, String email, String password) async {
    final id = await _userData.registerUser(name, email, password);
    _userId = id;
    _name = name;
    _email = email;

    await PreferenceService.setLoginStatus(true);
    notifyListeners();
  }

  /// LOGOUT: Clear user data and session
  Future<void> logout() async {
    _userId = null;
    _name = null;
    _email = null;

    await PreferenceService.logout(); // clear shared preferences
    notifyListeners();
  }

  /// LOAD USER: Fetch user info by ID from DB
  Future<void> loadUserFromDatabase(int userId) async {
    final user = await _userData.getUserById(userId);
    if (user != null) {
      _userId = user['id'];
      _name = user['name'];
      _email = user['email'];
      notifyListeners();
    }
  }

  /// EDIT PROFILE: Update name/email in DB and state
  Future<void> updateProfile(String newName, String newEmail) async {
    if (_userId != null) {
      await _userData.updateUser(_userId!, newName, newEmail);
      _name = newName;
      _email = newEmail;
      notifyListeners();
    }
  }
}
