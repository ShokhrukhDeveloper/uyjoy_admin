import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key, this.loginController, this.passwordController, this.onPressed});
  final TextEditingController? loginController;
  final TextEditingController? passwordController;
  final VoidCallback? onPressed;
  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 300,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.redAccent)),
      child: Column(children: [

        TextField(
          controller: widget.loginController,
          decoration: InputDecoration(labelText: 'Username'),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: widget.passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true, // Hide the entered text for passwords
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: widget.onPressed,
          child: const Text('Login'),
        ),
        SizedBox(height: 16.0),
        // TextButton(
        //   onPressed: () {
        //     // Navigate to the registration page or perform registration logic
        //     print('Navigate to registration page or perform registration logic.');
        //   },
        //   child: Text('Register'),
        // ),
        SizedBox(
          height: 10,
        ),
        // TextField(
        //   decoration: InputDecoration(
        //     hintText: "E-mail",
        //     border: OutlineInputBorder()),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Container(
        //   height: 40,
        //   width: double.infinity,
        //   decoration: BoxDecoration(color: Colors.red),
        //   child: Center(
        //     child: Text(
        //       "Kirish",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     Text("yoki"),
        //     TextButton(onPressed: () {}, child: Text("Ro'yhatdan o'tish"))
        //   ],
        // )
      ]),
    );
  }
}