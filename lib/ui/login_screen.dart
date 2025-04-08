import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ui/theme/color.dart'; // Import theme colors
// import 'game_screen.dart'; // game_screen import is not needed here if only navigating

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true; // To toggle password visibility

  void _login() {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      // Simulate login - In a real app, you would perform authentication here
      print("Giriş başarılı (simüle edildi): ${emailController.text}");
      // Navigate to game screen upon successful validation
      Navigator.pushReplacementNamed(context, '/game');
    } else {
      // Show error or feedback if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen giriş bilgilerinizi kontrol edin.')),
      );
      print("Giriş başarısız: Form doğrulama hatası");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove AppBar for a cleaner look, or customize it
      // appBar: AppBar(...),
      body: Container(
        // UI Improvement: Add Gradient Background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [MainColor.primaryColor, MainColor.accentColor.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Card( // UI Improvement: Wrap form in a Card
              elevation: 8.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              color: Colors.white.withOpacity(0.95), // Slightly transparent white card
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min, // Make card height fit content
                    children: [
                      // UI Improvement: Use App Logo or Styled Text
                      // Option 1: Use Asset Logo (Make sure path is correct in pubspec.yaml)
                       Image.asset(
                         'assets/images/logo.png', 
                         height: 80, 
                         errorBuilder: (context, error, stackTrace) => 
                            Icon(Icons.gamepad_outlined, size: 80, color: MainColor.primaryColor), // Fallback icon
                       ), 
                      // Option 2: Styled Text Logo
                      // Text(
                      //   "XOX",
                      //   style: TextStyle(
                      //     fontSize: 60, 
                      //     fontWeight: FontWeight.bold,
                      //     color: MainColor.primaryColor,
                      //     letterSpacing: 5,
                      //   ),
                      // ),
                      const SizedBox(height: 35),
                      TextFormField(
                        controller: emailController,
                        decoration: _inputDecoration(
                          labelText: "E-posta (Test)",
                          hintText: "ornek@eposta.com",
                          prefixIcon: Icons.email_outlined,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen e-posta adresinizi girin.';
                          }
                          // Basic email format check
                          if (!RegExp(r"^\S+@\S+\.\S+$").hasMatch(value)) {
                            return 'Geçerli bir e-posta adresi girin.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        decoration: _inputDecoration(
                          labelText: "Şifre (Test)",
                          hintText: "******",
                          prefixIcon: Icons.lock_outline,
                          // UI Improvement: Add password visibility toggle
                          suffixIcon: IconButton(
                             icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey[600],
                              ),
                             onPressed: () {
                               setState(() {
                                  _obscureText = !_obscureText;
                               });
                             },
                           )
                        ),
                        obscureText: _obscureText, // Use state variable
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen şifrenizi girin.';
                          }
                          if (value.length < 3) { // Keep simple validation for testing
                            return 'Şifre en az 3 karakter olmalı.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      // UI Improvement: Styled Login Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MainColor.primaryColor, // Use theme color
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0), // More rounded
                          ),
                          elevation: 5, // Add shadow
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2, // Add letter spacing
                          ),
                        ),
                        onPressed: _login,
                        child: const Text("GİRİŞ YAP"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper function for consistent InputDecoration styling
  InputDecoration _inputDecoration({required String labelText, required String hintText, required IconData prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(color: Colors.grey[700]),
      hintStyle: TextStyle(color: Colors.grey[400]),
      prefixIcon: Icon(prefixIcon, color: MainColor.primaryColor.withOpacity(0.8)),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.grey[100]?.withOpacity(0.8), // Lighter fill color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none, // Remove default border
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0), // Subtle border when enabled
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: MainColor.primaryColor, width: 1.5), // Highlight border when focused
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // Adjust padding
    );
  }
}
