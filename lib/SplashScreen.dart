import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
                      color: Colors.indigo,
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
