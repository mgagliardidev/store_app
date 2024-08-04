import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // Implement login logic here
    print('Login with email: ${_emailController.text}');
  }

  void _signInWithGoogle() {
    // Implement Google login logic here
    print('Login with Google');
  }

  void _signInWithApple() {
    // Implement Apple login logic here
    print('Login with Apple');
  }

  void _goToSignUp() {
    // Navigate to the Sign Up page
    print('Navigate to Sign Up page');
  }

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
                // Company Name
                const Text(
                  'My Company',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Email TextField
                _buildCredentialsInput("Email", _emailController),

                const SizedBox(height: 20),

                // Password TextField
                _buildCredentialsInput("Password", _passwordController),

                const SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      minimumSize: const Size(0, 60)),
                  onPressed: _login,
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),

                //apple and google login buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialLoginButton(
                        onTap: _signInWithApple,
                        imagePath: 'assets/logos/apple_logo.png'),
                    const SizedBox(width: 20),
                    _buildSocialLoginButton(
                        onTap: _signInWithGoogle,
                        imagePath: 'assets/logos/google_logo.png'),
                  ],
                ),
                const SizedBox(height: 40),

                // Sign Up Button
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _goToSignUp,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ));
  }

  Widget _buildCredentialsInput(
      String label, TextEditingController controller) {
    return TextField(
      controller: controller,
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

  Widget _buildSocialLoginButton(
      {required VoidCallback onTap, required String imagePath}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: const Center(
        child: Text('Sign Up Page'),
      ),
    );
  }
}
