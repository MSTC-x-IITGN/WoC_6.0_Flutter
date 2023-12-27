import 'package:flutter/services.dart';
import 'package:stocks_app/profile/MyPortFolio.dart';
import 'app.dart';
import 'views/dash_screen.dart';

final userName = FirebaseAuth.instance.currentUser!.displayName;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Articles()),
        ChangeNotifierProvider(create: (ctx) => Securities()),
      ],
      child: MaterialApp(
        title: "Stock News",
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
          canvasColor: const Color.fromARGB(255, 0, 0, 0),
          primaryColor: Colors.black,
          appBarTheme: theme.appBarTheme.copyWith(
            iconTheme: const IconThemeData(color: Colors.white),
            color: Colors.black,
            elevation: 0.0,
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              fontSize: 22,
            ),
          ),
          textTheme: theme.textTheme.copyWith(
            bodyLarge: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 15,
              color: Colors.black,
            ),
            bodyMedium: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              color: Colors.black,
            ),
            displayLarge: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
            displayMedium: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            labelLarge: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          colorScheme: theme.colorScheme
              .copyWith(
                secondary: Colors.white,
              )
              .copyWith(error: const Color(0xFFf73131)),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, authSnapshot) {
            if (authSnapshot.hasData) {
              return const TabsScreen();
            } else {
              return const LoginView();
            }
          },
        ),
        routes: {
          '/login': (_) => const LoginView(),
          TabsScreen.routeName: (_) => const TabsScreen(),
          '/register': (_) => const RegisterView(),
          '/portfolio': (_) => const MyPortfolio(),
        },
      ),
    );
  }
}
