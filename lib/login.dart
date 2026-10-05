
import 'package:flutter/material.dart';
import 'package:wrenchgo/admin_login.dart';
import 'package:wrenchgo/home.dart';
import 'package:wrenchgo/mech_dash.dart';
import 'package:wrenchgo/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter email and password'),
        ),
      );
      return;
    }

    // Login logic will be added here later.
    print('Email: $email');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // ---------------- TOP SECTION ----------------

              Container(
                width: double.infinity,
                height: 280,
                decoration: const BoxDecoration(
                  color: Color(0xFF1D4ED8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.build,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ---------------- LOGIN TITLE ----------------

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 38),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 38),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome back!\nSign in to continue.',
                    style: TextStyle(
                      color: Color(0xFF475569),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ---------------- EMAIL LABEL ----------------

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 38),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email Address',
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ---------------- EMAIL FIELD ----------------

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFFD1D5DB),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFFD1D5DB),
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
                ),
              ),

              const SizedBox(height: 20),

              // ---------------- PASSWORD LABEL ----------------

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 38),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ---------------- PASSWORD FIELD ----------------

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: TextField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFFD1D5DB),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFFD1D5DB),
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
                ),
              ),

              const SizedBox(height: 5),

              // ---------------- FORGOT PASSWORD ----------------

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                      // Forgot password logic later
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Color(0xFF006FFD),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // ---------------- LOGIN BUTTON ----------------

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
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
              ),
              const SizedBox(height: 35),

              // ---------------- LOGIN AS Mech BUTTON ----------------

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MechanicDashboard()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 15, 228, 68),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Login as Mechanic',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ---------------- REGISTER ----------------

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Color(0xFF71727A),
                      fontSize: 12,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: Color(0xFF006FFD),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminLogin(),
                        ),
                      );
                    },
                    child: const Text(
                      'Login as admin',
                      style: TextStyle(
                        color: Color(0xFF006FFD),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
