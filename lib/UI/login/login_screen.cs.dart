import 'package:flutter/material.dart';

import '../panel/panel_screen.dart';
import 'auth_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  TextEditingController login=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    login.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      body: Center(
        child: AuthWidget(
          loginController: login,
          passwordController: password,
          onPressed: (){
            print(login.text);
            print(password.text);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AdminPanel()), (route) => false);
          },
        ),
      ),
    );
  }
}