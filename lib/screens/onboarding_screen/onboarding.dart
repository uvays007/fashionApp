import 'package:comercial_app/screens/Authentications_screens/signup.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/onboard.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),

                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.amber, Colors.orangeAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    'Choose\nYour\nPerfect Fashion',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: const [
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Find the latest & best outfits\nthat match your lifestyle.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
