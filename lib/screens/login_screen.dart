import 'package:flutter/material.dart';
import '../main.dart';
import '../models/user_model.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginUser() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // البحث عن المستخدم في القائمة المؤقتة
    try {
      UserModel loggedInUser = globalUsersList.firstWhere(
        (user) => user.email == email && user.password == password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful! Welcome.')),
      );

      // الانتقال إلى صفحة Home مع تمرير بيانات المستخدم (أسبوع 7)
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomeScreen(user: loggedInUser),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Email or Password! (Note: Data clears on refresh)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Major Path Finder'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email Field
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16.0),

            // Password Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24.0),

            // Login Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E40AF),
                  foregroundColor: Colors.white,
                ),
                onPressed: _loginUser,
                child: const Text('Login', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16.0),

            // Continue as guest
            TextButton(
              onPressed: () {
                // تمرير يوزر افتراضي للزائر (Guest)
                UserModel guestUser = UserModel(
                  name: 'Guest',
                  email: 'guest@app.com',
                  password: '',
                  gender: 'N/A',
                  track: 'General',
                  isDarkMode: false,
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(user: guestUser),
                  ),
                );
              },
              child: const Text('Continue as guest', style: TextStyle(color: Color(0xFF475569))),
            ),
            const SizedBox(height: 16.0),

            // Register Navigation
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text(
                "Don't have an account? Register",
                style: TextStyle(color: Color(0xFF1E40AF), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}