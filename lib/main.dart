import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginbloc/Authentification/blocs/auth/auth_bloc.dart';
import 'package:loginbloc/Authentification/blocs/onboarding/onboarding_bloc.dart';
import 'package:loginbloc/Authentification/cubits/cubit/signup_cubit.dart';
import 'package:loginbloc/Authentification/provider.dart/user_provider.dart';
import 'package:loginbloc/Authentification/repositories/auth/auth_repository.dart';
import 'package:loginbloc/Authentification/repositories/database/database_repository.dart';
import 'package:loginbloc/Authentification/repositories/storage/storage_repository.dart';
import 'package:loginbloc/Authentification/responsive/mobileScreenLayout.dart';
import 'package:loginbloc/screens/Access/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'API-KEY',
          appId: 'APPId',
          messagingSenderId: 'messagingSenderId',
          projectId: 'projectId',
          storageBucket: 'storageBucket'),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
             RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        //   RepositoryProvider(
        //   create: (context) => EventRepository(),
        // ),
        RepositoryProvider(
          create: (context) => DatabaseRepository(),
        ),
        RepositoryProvider(
          create: (context) => StorageRepository(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
       child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) =>
                SignupCubit(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc(
              databaseRepository: context.read<DatabaseRepository>(),
              storageRepository: context.read<StorageRepository>(),
            ),
          ),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'loginbloc cubit',
        theme: ThemeData.light(),
        // home: ResponsiveLayout(
        //   mobileScreenLayout: MobileScreenLayout(),
        //   webScreenLayout: WebScreenLayout(),
        // ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const mobileScreenLayout();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }

            return const WelcomeScreen();
          },
        ),
      ),
       ),
    );
  }
}
