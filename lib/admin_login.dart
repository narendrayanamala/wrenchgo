
import 'package:flutter/material.dart';
import 'package:wrenchgo/admin_dash.dart';
import 'package:wrenchgo/reports_analytics.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Admin login successful'),
      ),
    );

    // Add your admin dashboard navigation here later.
  }

  void _forgotPassword() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();

        return AlertDialog(
          title: const Text('Forgot Password'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Admin Email',
              hintText: 'Enter your email',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text('Password reset request sent'),
                  ),
                );
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _header(),

                    const SizedBox(height: 45),

                    const Text(
                      'Admin Login',
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 30),

                    _emailField(),

                    const SizedBox(height: 22),

                    _passwordField(),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _forgotPassword,
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Color(0xFF006FFD),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 55),

                    const Text(
                      '@2026 WrenchGo. All rights reserved.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF202124),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.build_circle,
                size: 48,
                color: Color(0xFF2563EB),
              ),
            ),
            const SizedBox(width: 15),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Wrench',
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text: 'Go',
                    style: TextStyle(
                      color: Color(0xFF2563EB),
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        const Text(
          'Admin panel',
          style: TextStyle(
            color: Color(0xFF202124),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Roadside Assistance Made Easy',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF202124),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email / Admin ID',
        hintText: 'Enter your email',
        prefixIcon: const Icon(Icons.email_outlined),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFD1D5DB),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF2563EB),
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your email or Admin ID';
        }

        return null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
          icon: Icon(
            obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFD1D5DB),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF2563EB),
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }

        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }

        return null;
      },
    );
  }
}
