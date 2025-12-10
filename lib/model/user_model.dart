import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String employeeId;
  String designation;
  String dob;
  String docId;

  UserModel({
    required this.name,
    required this.designation,
    required this.employeeId,
    required this.dob,
    required this.docId,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return UserModel(
      name: data?['name'] ?? '',
      employeeId: data?['employee_id'] ?? "",
      designation: data?['designation'] ?? "",
      dob: data?['dob'] ?? "",
      docId: snapshot.id,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "employeeId": employeeId,
      "designation": designation,
      "dob": dob,
    };
  }
}
