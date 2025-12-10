import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_management/model/user_model.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
  Future<List<UserModel>> fetchUsers() async {
    try {
      final collection = FirebaseFirestore.instance.collection('employees');
      final users = await collection.get();
      final allData = users.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();

      return allData;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<UserModel>> deleteUserFromList(String docId) async {
    try {
      final collectionToDelete = FirebaseFirestore.instance
          .collection('employees')
          .doc(docId);
      await collectionToDelete.delete();
      final collection = await FirebaseFirestore.instance
          .collection('employees')
          .get();
      final allData = collection.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();
      return allData;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<UserModel>> updateUserFields(
    String? name,
    String? email,
    String? designation,
    String? employeeId,
    String docId,
  ) async {
    try {
      final fields = await FirebaseFirestore.instance
          .collection('employees')
          .doc(docId)
          .get();
      await FirebaseFirestore.instance
          .collection('employees')
          .doc(docId)
          .update({
            'name': name ?? fields['name'],
            'email': email ?? fields['email'],
            'employee_id': employeeId ?? fields['employee_id'],
            'designation': designation ?? fields['designation'],
          });

      final collection = await FirebaseFirestore.instance
          .collection('employees')
          .get();
      final allData = collection.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();
      return allData;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<UserModel>> addUser(
    String name,
    String email,
    String employeeId,
    String designation,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('employees').add({
        'name': name,
        'email': email,
        'designation': designation,
        'employee_id': employeeId,
      });
      final collection = await FirebaseFirestore.instance
          .collection('employees')
          .get();
      final allData = collection.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();
      return allData;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
