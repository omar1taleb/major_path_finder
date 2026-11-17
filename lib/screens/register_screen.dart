import 'package:flutter/material.dart';
import '../main.dart';
import '../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedGender;
  String? _selectedTrack;
  bool _isDarkMode = false; // الـ Checkbox الخاص بالـ Dark mode حسب تعديل الدكتور

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _registerUser() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _selectedGender != null &&
        _selectedTrack != null) {
      
      // إضافة المستخدم للقائمة العالمية
      globalUsersList.add(UserModel(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        gender: _selectedGender!,
        track: _selectedTrack!,
        isDarkMode: _isDarkMode,
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered Successfully! Please Login.')),
      );

      // العودة لصفحة الـ Login باستخدام Navigator.pop (أسبوع 7)
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields and selections!')),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full Name Input
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16.0),

            // Email Input
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16.0),

            // Password Input
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility),
              ),
            ),
            const SizedBox(height: 16.0),

            // Radio Buttons: Gender (أسبوع 6)
            const Text('Gender', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: _selectedGender,
                  onChanged: (val) {
                    setState(() {
                      _selectedGender = val;
                    });
                  },
                ),
                const Text('Male'),
                const SizedBox(width: 20),
                Radio<String>(
                  value: 'Female',
                  groupValue: _selectedGender,
                  onChanged: (val) {
                    setState(() {
                      _selectedGender = val;
                    });
                  },
                ),
                const Text('Female'),
              ],
            ),
            const SizedBox(height: 16.0),

            // Dropdown Menu: Bac Track (أسبوع 6)
            DropdownButtonFormField<String>(
              value: _selectedTrack,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bac Track',
              ),
              hint: const Text('Select your track (SV, SG, LH, SE)'),
              items: ['SV', 'SG', 'LH', 'SE'].map((String track) {
                return DropdownMenuItem<String>(
                  value: track,
                  child: Text(track),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedTrack = newValue;
                });
              },
            ),
            const SizedBox(height: 16.0),

            // Appearance Checkbox (تعديل الدكتور: إزالة الInterests ووضع Appearance مع Dark mode)
            const Text('Appearance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            CheckboxListTile(
              title: const Text('Dark mode'),
              value: _isDarkMode,
              onChanged: (bool? value) {
                setState(() {
                  _isDarkMode = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24.0),

            // Register Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E40AF),
                  foregroundColor: Colors.white,
                ),
                onPressed: _registerUser,
                child: const Text('Register', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16.0),

            // Already have an account link
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(color: Color(0xFF1E40AF), fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}