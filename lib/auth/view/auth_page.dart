import 'package:employee_management/auth/service/firebase_service.dart';
import 'package:employee_management/auth/view/sign_up_page.dart';
import 'package:employee_management/home/home_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCntrllr = TextEditingController();
    final passCntrllr = TextEditingController();
    final auth = FirebaseService();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sign In", style: TextStyle(fontSize: 32)),
          SizedBox(height: 50),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 226, 223, 223),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5, color: Colors.black),
            ),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailCntrllr,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Email",
                contentPadding: EdgeInsets.only(left: 8),
              ),
            ),
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              final emailVal = emailCntrllr.text.trim();
              final passVal = passCntrllr.text.trim();
              if (emailVal.isNotEmpty && passVal.isNotEmpty) {
                final user = await auth.signIn(emailVal, passVal);
                if (user!.email!.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
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
          SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
            child: Text(
              "SignUp",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
