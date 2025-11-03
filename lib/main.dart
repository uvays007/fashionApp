import 'package:comercial_app/screens/Authentications_screens/login.dart';
import 'package:comercial_app/screens/Authentications_screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase initialized successfully");
  } catch (e, s) {
    print("❌ Firebase initialization failed: $e");
    print(s);
  }

  runApp(
    ScreenUtilInit(
      designSize: const Size(
        390,
        844,
      ), // Use your design’s base screen size (e.g. iPhone 12)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Login());
  }
}
