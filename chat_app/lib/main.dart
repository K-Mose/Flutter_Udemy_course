import 'package:chat_app/screen/chat.dart';
import 'package:chat_app/screen/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:chat_app/screen/auth.dart';

void main() async {
  // Unhandled Exception: Binding has not yet been initialized.
  WidgetsFlutterBinding.ensureInitialized();
  // Setup Firebase. App will be ready to use Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterChat',
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 17, 177)),
        ),
        // futureBuilder와 비슷한 빌더
        // streamBuilder는 지속적으로 값을 생산 가능함
        home: StreamBuilder(
          // authStateChanges
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // snapshot은 stream으로 연결된 값에 접근
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 인증 토큰 값을 찾는 동안 띄워줄 splashScreen
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const ChatScreen();
            }
            return const AuthScreen();
          },
        )
    );
  }
}