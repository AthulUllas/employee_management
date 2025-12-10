import 'package:employee_management/auth/service/firebase_service.dart';
import 'package:employee_management/auth/view/auth_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCntrllr = TextEditingController();
    final passCntrllr = TextEditingController();
    final auth = FirebaseService();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("SignUp", style: TextStyle(fontSize: 24)),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 226, 223, 223),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5, color: Colors.black),
            ),
            child: TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: emailCntrllr,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Email",
                contentPadding: EdgeInsets.only(left: 8),
              ),
            ),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 226, 223, 223),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5, color: Colors.black),
            ),
            child: TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: passCntrllr,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Password",
                contentPadding: EdgeInsets.only(left: 8),
              ),
            ),
          ),
          SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              final emailVal = emailCntrllr.text.trim();
              final passwordVal = passCntrllr.text.trim();
              if (emailVal.isNotEmpty && passwordVal.isNotEmpty) {}
            },
            child: GestureDetector(
              onTap: () async {
                final emailVal = emailCntrllr.text.trim();
                final pasVal = passCntrllr.text.trim();
                if (emailVal.isNotEmpty && pasVal.isNotEmpty) {
                  final user = await auth.signUp(emailVal, pasVal);
                  if (user!.email!.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthPage()),
                    );
                  }
                }
              },
              child: Container(
                width: 130,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: Colors.black),
                ),
                child: Center(
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
