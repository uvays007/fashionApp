import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comercial_app/helper/passwordvalidation.dart';
import 'package:comercial_app/screens/Authentications_screens/login.dart';
import 'package:comercial_app/screens/global_screen/global.dart';
import 'package:comercial_app/screens/nav_screen/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? usernameerror;
  String? emailerror;
  String? passworderror;

  bool haserror = false;
  bool ispasswordvisible = true;

  Future<void> _signup() async {
    haserror = false;
    setState(() {
      usernameerror = null;
      emailerror = null;
      passworderror = null;
    });
    if (_usernameController.text.trim().isEmpty) {
      setState(() {
        usernameerror = "Please enter your username";
      });
      haserror = true;
    }
    if (_emailController.text.trim().isEmpty) {
      setState(() {
        emailerror = "Please enter your email";
      });
      haserror = true;
    }
    if (_passwordController.text.trim().isEmpty) {
      setState(() {
        passworderror = "Please enter your password";
      });
      haserror = true;
    }
    if (haserror) return;

    final passwordValidation = validatePassword(
      _passwordController.text.trim(),
    );
    if (passwordValidation != null) {
      setState(() {
        passworderror = passwordValidation;
      });
      return;
    }
    setState(() => _loading = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Nav()),
      );
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').add({
        'username': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
      });
      docemail = _emailController.text.trim();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          setState(() => emailerror = "This email is already registered");
          break;
        case 'invalid-email':
          setState(() => emailerror = "Invalid email address");
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Signup failed. Please try again.")),
          );
      }
      if (!mounted) return;
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'FITMAX',
                style: TextStyle(
                  fontFamily: 'LondrinaSolid',
                  shadows: [
                    Shadow(
                      offset: Offset(0, 4),
                      blurRadius: 6.0,
                      color: Colors.grey,
                    ),
                  ],
                  fontWeight: FontWeight.w600,
                  fontSize: 45,
                  color: Color(0xFFC19375),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Create an account',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Enter your email to sign up for this app',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 12),

              TextField(
                onChanged: (_) {
                  if (usernameerror != null) {
                    setState(() {
                      usernameerror = null;
                    });
                  }
                },
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: usernameerror,
                  contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF828282)),
                  ),
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                onChanged: (_) {
                  if (emailerror != null) {
                    setState(() {
                      emailerror = null;
                    });
                  }
                },
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: emailerror,
                  contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF828282)),
                  ),
                  hintText: 'Enter your Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                onChanged: (_) {
                  if (passworderror != null) {
                    setState(() {
                      passworderror = null;
                    });
                  }
                },
                controller: _passwordController,
                obscureText: ispasswordvisible,
                decoration: InputDecoration(
                  errorText: passworderror,
                  contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF828282)),
                  ),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        ispasswordvisible = false;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        ispasswordvisible = true;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        ispasswordvisible = true;
                      });
                    },
                    child: ispasswordvisible
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFC19375),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: _loading ? null : _signup,
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Continue', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFC19375),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Expanded(
                    child: Divider(
                      color: Color(0xFFE6E6E6),
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'or',
                    style: TextStyle(
                      color: Color(0xFF828282),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color(0xFFE6E6E6),
                      thickness: 1,
                      indent: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFEEEEEE),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 12),
                      Image.asset(
                        width: 20,
                        height: 20,
                        'assets/images/Google_Favicon_2025.png',
                      ),
                      const SizedBox(width: 8),
                      const Text('Continue with Google'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFEEEEEE),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(size: 30, Icons.apple),
                      const SizedBox(width: 3),
                      const Text('Continue with Apple'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'By clicking continue, you agree to our Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
