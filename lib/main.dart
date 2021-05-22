import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_laundary/Pages/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Services/SharedPrefernces.dart';
import 'Services/Get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPrefernces.sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Demo()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online laundary',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
