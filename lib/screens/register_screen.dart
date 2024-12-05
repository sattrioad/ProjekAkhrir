import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService();
  bool _isAgreed = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  void _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match!'),
          backgroundColor: Colors.red.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_isPasswordValid(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password must be at least 8 characters!'),
          backgroundColor: Colors.red.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You must agree to the terms and conditions!'),
          backgroundColor: Colors.red.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    try {
      await _authService.registerUser(email, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration successful!'),
          backgroundColor: Colors.green.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: $e'),
          backgroundColor: Colors.red.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF424242),
          title: Text('Terms and Conditions',
              style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Text(
              'By registering, you agree to our terms and conditions.',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF212121),
              Color(0xFF424242),
              Color(0xFF616161),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Title
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Main Content Container
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        // Email Field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _emailController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.white70),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Password Field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _passwordController,
                            style: TextStyle(color: Colors.white),
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.lock, color: Colors.white70),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Confirm Password Field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _confirmPasswordController,
                            style: TextStyle(color: Colors.white),
                            obscureText: !_isConfirmPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.lock, color: Colors.white70),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),

                        // Password Requirements
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Password must be at least 8 characters.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Terms and Conditions
                        Row(
                          children: [
                            Checkbox(
                              value: _isAgreed,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isAgreed = value!;
                                });
                              },
                              fillColor: MaterialStateProperty.resolveWith(
                                (states) =>
                                    states.contains(MaterialState.selected)
                                        ? Colors.white.withOpacity(0.2)
                                        : Colors.white.withOpacity(0.1),
                              ),
                              checkColor: Colors.white,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: _showTermsAndConditions,
                                child: Text(
                                  'I agree to the terms and conditions',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),

                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
