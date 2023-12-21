import 'app.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blue,
  hintColor: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);

// Dark Theme
ThemeData darkTheme = ThemeData(
  primaryColor: Colors.deepPurple,
  hintColor: Colors.amber,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: const AppBarTheme(
    color: Colors.deepPurple,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);
