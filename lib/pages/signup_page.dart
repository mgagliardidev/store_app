import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:store_app/pages/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'MyStore',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildCredentialsInput("First Name", _firstNameController),
            const SizedBox(height: 20),
            _buildCredentialsInput("Last Name", _lastNameController),
            const SizedBox(height: 20),
            _buildCredentialsInput("Email", _emailController),
            const SizedBox(height: 20),
            _buildCredentialsInput("Password", _passwordController,
                privacyField: true),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  minimumSize: const Size(0, 60)),
              onPressed: _signUp,
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                  children: [
                    TextSpan(
                      text: 'Sign In!',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = _goToSignIn,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCredentialsInput(String label, TextEditingController controller,
      {bool privacyField = false}) {
    return TextField(
      controller: controller,
      obscureText: privacyField,
      enableSuggestions: !privacyField,
      autocorrect: !privacyField,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  void _signUp() {
    // Implement sign-up logic here
    print('Sign Up with first name: ${_firstNameController.text}');
    print('Sign Up with last name: ${_lastNameController.text}');
    print('Sign Up with email: ${_emailController.text}');
  }

  void _goToSignIn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
