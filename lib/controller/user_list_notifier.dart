import 'package:employee_management/model/user_model.dart';
import 'package:employee_management/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserListNotifier extends ChangeNotifier {
  List<UserModel>? val;

  UserListNotifier() {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    val = await UserRepository().fetchUsers();
    notifyListeners();
  }

  Future<void> updateUser(
    String? name,
    String? email,
    String? designation,
    String? employeeId,
    String docId,
  ) async {
    val = await UserRepository().updateUserFields(
      name,
      email,
      designation,
      employeeId,
      docId,
    );
    notifyListeners();
  }

  Future<void> addUser(
    String name,
    String email,
    String employeeId,
    String designation,
  ) async {
    val = await UserRepository().addUser(name, email, employeeId, designation);
    notifyListeners();
  }

  Future<void> deleteUser(String? docId) async {
    val = await UserRepository().deleteUserFromList(docId ?? "");
    notifyListeners();
  }
}
