import 'package:flutter/material.dart';
import 'src/config/router/routes.dart';
import 'package:provider/provider.dart';
import 'src/config/router/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/data/repositories/repository_impl.dart';
import 'src/presentation/providers/app_provider.dart';
import 'src/presentation/providers/home_provider.dart';
import 'src/data/data_sources/remote/auth_service.dart';
import 'src/presentation/providers/login_provider.dart';
import 'src/presentation/providers/signup_provider.dart';
import 'src/data/repositories/auth_repository_impl.dart';
import 'src/presentation/providers/details_provider.dart';
import 'src/data/data_sources/remote/remote_services.dart';
import 'src/data/data_sources/remote/storage_service.dart';
import 'src/data/data_sources/remote/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final remote = RemoteServices(
    AuthService(),
    FirebaseService(),
    StorageService(),
  );
  final authRepository = AuthRepositoryImpl(remote);
  final repository = RepositoryImpl(remote);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(authRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => SignupProvider(authRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => AppProvider(repository),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailsProvider(),
        )
      ],
      child: const Application(),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute: RoutesName.splashRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        datePickerTheme: const DatePickerThemeData(
          dividerColor: Colors.black,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.black),
          ),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.black),
          ), // Foreground color for today
        ),
        cardTheme: const CardTheme(surfaceTintColor: Colors.white),
        dialogTheme: const DialogTheme(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
