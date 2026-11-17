import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'screens/login_screen.dart';

// قائمة عامة لتخزين المستخدمين في الذاكرة (تنمسح عند الـ Refresh)
List<UserModel> globalUsersList = [];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Major Path Finder',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}