import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tabbed_app.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String theme = "";
  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    theme = prefs.getString("theme")!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: theme != "dark"
          ? ThemeData.light(useMaterial3: true)
          : ThemeData.dark(useMaterial3: true),
      home: DefaultTabController(
        length: 4,
        child: TabbedApp(),
      ),
    );
  }
}
