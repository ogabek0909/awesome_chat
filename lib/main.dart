import 'package:awesome_chat/firebase_options.dart';
import 'package:awesome_chat/screens/auth_screen.dart';
import 'package:awesome_chat/screens/chat_screen.dart';
import 'package:awesome_chat/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          bodySmall: GoogleFonts.ubuntuCondensed(),
        ),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      routerConfig: GoRouter(
        initialLocation: '/auth',
        routes: [
          GoRoute(
            path: '/',
            name: SplashScreen.routName,
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            path: '/auth',
            redirect: (context, state) {
              if (FirebaseAuth.instance.currentUser != null) {
                return '/chat';
              }
            },
            name: AuthScreen.routeName,
            builder: (context, state) => AuthScreen(),
          ),
          GoRoute(
            path: '/chat',
            name: ChatScreen.routeName,
            builder: (context, state) => const ChatScreen(),
          ),
        ],
      ),
    );
  }
}
