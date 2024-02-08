import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/state/auth/providers/auth_state_provider.dart';
import 'package:untitled2/state/auth/providers/is_logged_in_provider.dart';
import 'package:untitled2/state/providers/is_loading_provider.dart';
import 'package:untitled2/view/components/loding/loading_screen.dart';
import 'package:untitled2/view/login/login_view.dart';
import 'package:untitled2/view/main/main_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
          indicatorColor: Colors.blueGrey),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(builder: (context, ref, child) {
        ref.listen<bool>(isLoadingProvider, (_, isLoading) {
          if (isLoading) {
            LoadingScreen.instance().show(context: context);
          } else {
            LoadingScreen.instance().hide();
          }
        });
        final isLoggedIn = ref.watch(isLogggedProvider);

        if (isLoggedIn) {
          return const MainView();
        } else {
          return const LoginView();
        }
      }),
    );
  }
}

//class HomePage extends StatefulWidget {
//  const HomePage({super.key});
//
//  @override
//  State<HomePage> createState() => _HomePageState();
//}

///class _HomePageState extends State<HomePage> {
///  @override
///  Widget build(BuildContext context) {
///    return Scaffold(
///      appBar: AppBar(
///        title: const Text("Home"),
///        backgroundColor: const Color(0xFF201F2E),
///      ),
///      body: Consumer(
///        builder: (_, ref, child) {
///           return TextButton(
///             onPressed: () async {
///               await ref.read(authStateProvider.notifier).logOut();
///             },
///             child: Text("Log out"),
///           );
///        },
///      ),
///    );
///  }
///}
/*
class LoginView extends ConsumerWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login View"),
        backgroundColor: const Color(0xFF201F2E),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
              child: const Text("Sign in with google")),
          TextButton(
              onPressed: ref.read(authStateProvider.notifier).loginWithFaceBook,
              child: const Text("Sign in with FaceBook"))
        ],
      ),
    );
  }
}
*/