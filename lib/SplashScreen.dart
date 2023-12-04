import 'package:flutter/material.dart';

import 'MyWidgets.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Loading",
                  style: TextStyle(
                      color: colorsPrimary,
                      fontSize: 30,
                      fontStyle: FontStyle.italic),
                ),
              ),
              CircularProgressIndicator(),
            ],
          )),
        ));
  }
}
