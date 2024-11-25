import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  //controller allow you to interact with the input fields programmatically,
  //controller helps to retrieve  the text entered by the user or clearing the fields.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    //super.initState(); //Do we need the super here thought we already entered
    // Add listeners to controllers
    emailController.addListener(_onEmailChanged);
    passwordController.addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    // This function is called whenever the email text changes
    print('Email: ${emailController.text}');
  }

  void _onPasswordChanged() {
    // This function is called whenever the password text changes
    print('Password: ${passwordController.text}');
  }

  @override
  void dispose() {
    // Dispose controllers when no longer needed
    emailController.dispose();
    passwordController.dispose();
    //super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email Input Field
              TextField(
                controller: emailController, //controller of the email
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF2C2C54)), // Dark Blue
                  ),
                ),
              ),
              //controller on the email textfield

              const SizedBox(height: 16),

              // Password Input Field
              TextField(
                //controller to edit the text later
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF2C2C54)), // Dark Blue
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Login Button - Full width, rounded, and using dark blue
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C2C54), // Dark Blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Login logic
                    print('Login pressed');
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Sign Up Text with Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Sign Up Page
                      print('Sign Up clicked');
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2C2C54), // Dark Blue
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
