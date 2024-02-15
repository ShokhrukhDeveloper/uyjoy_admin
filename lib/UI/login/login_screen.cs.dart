import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uy_admin/storage/LocalStoage.dart';
import 'package:uy_admin/urls/Urls.dart';
import '../panel/panel_screen.dart';
import 'auth_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();

  bool loading=false;
  Future<void>logIn({required String login, required String password})async
  {
    setState(() {
      loading=true;
    });
    var response = await http.post(Uri.parse(AppUrls.logIn),
        headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    },body: jsonEncode(
          {
            "phone": login,
            "password": password
          }
    ));
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      var session = jsonDecode(response.body);
      LocalStorage.accessToken=session["data"]["accesToken"];
      success();
    }

  }
  void success(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AdminPanel()),
        (route) => false);
  }
  @override
  void dispose() {
    login.dispose();
    password.dispose();
    if(LocalStorage.accessToken==null)success();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AuthWidget(
          loginController: login,
          passwordController: password,
          onPressed: () {
            print(login.text);
            print(LocalStorage.accessToken);
            logIn(login: login.text, password: password.text);


          },
        ),
      ),
    );
  }
}
