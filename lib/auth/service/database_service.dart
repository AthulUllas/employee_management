import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final firestoreInstance = FirebaseFirestore.instance;
  Future<void> createUser(String email, String employeeId) async {
    // collection.collection.doc().set({});
  }
  Future<void> fetchUsers() async {}
}
