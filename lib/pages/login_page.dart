import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:store_app/pages/main_page.dart';
import 'package:store_app/pages/signup_page.dart';

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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpPage()));
  }

  void _goToHomePage() async {
    // Navigate to the Home page
    Route route = MaterialPageRoute(builder: (context) => MainPage());
    await Navigator.pushReplacement(context, route);
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
                // Company Logo
                const Text(
                  'MyStore',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // EMAIL
                _buildCredentialsInput("Email", _emailController),

                const SizedBox(height: 20),

                // PASSWORD
                _buildCredentialsInput("Password", _passwordController,
                    privacyField: true),

                const SizedBox(height: 20),

                // LOGIN
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

                // APPLE/GOOGLE
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

                // SIGN UP
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

                const SizedBox(height: 40),

                // W/O ACCOUNT
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      minimumSize: const Size(0, 60)),
                  onPressed: _goToHomePage,
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.tertiary),
                          children: [
                        const TextSpan(
                          text: 'Continue wihout an account',
                        ),
                        WidgetSpan(
                            child: Icon(Icons.arrow_forward,
                                color: Theme.of(context).colorScheme.tertiary))
                      ])),
                ),
              ]),
        ));
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
          color: Colors.grey[300],
        ),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Image(
              image: AssetImage(imagePath),
              fit: BoxFit.fill,
            )),
      ),
    );
  }
}
