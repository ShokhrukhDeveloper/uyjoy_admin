import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uy_admin/UI/panel/panel_screen.dart';
import 'package:uy_admin/storage/LocalStoage.dart';
import 'UI/login/login_screen.cs.dart';

void main()async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:LocalStorage.accessToken==null? const LoginScreen():const AdminPanel(),
    );
  }
}

