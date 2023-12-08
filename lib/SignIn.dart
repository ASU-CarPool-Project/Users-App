import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:asu_carpool/Routes.dart';
import 'MyWidgets.dart';
import 'SignUp.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  /////////////////////////////////////////////////////////////////////////////

  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: controllerEmail.text.trim(),
              password: controllerPassword.text);

      // If sign-in is successful, navigate to the next screen (Routes)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Routes()),
      );

      // Reset the form after successful sign-in
      formKey.currentState!.reset();

      // Show a success toast message
      Fluttertoast.showToast(
        msg: "Sign In Successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on FirebaseAuthException catch (e) {
      print("Failed to sign in: $e");

      // Show an error toast message
      Fluttertoast.showToast(
        msg: "Failed to Sign In: ${e.message}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _forgetPass() async {
    String email = ''; // Variable to store the entered email

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Reset Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  // icon: Icon(Icons.email),
                  labelText: "Email",
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(colorsPrimary!),
              ),
              onPressed: () async {
                // Close the dialog
                Navigator.of(context).pop();

                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email);

                  // Show a success toast message
                  Fluttertoast.showToast(
                    msg:
                    "Password reset email sent. Check your email to reset your password.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 4,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } on FirebaseAuthException catch (e) {
                  print("Failed to send password reset email: $e");

                  // Show an error toast message
                  Fluttertoast.showToast(
                    msg: "Failed to send password reset email: ${e.message}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: textButtons("Reset"),
            ),
          ],
        );
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPrimary,
        title: textPageTitle("ASU CAR POOL"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ListView(
              children: [
                Image.asset('assets/logos/users_carpool.jpeg', width: 200, height: 200,),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controllerEmail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ('Enter Your Email');
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          icon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: controllerPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ('Enter Your Password');
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                          icon: Icon(Icons.lock_outline_rounded),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(colorsPrimary!),
                  ),
                  child: textButtons("Sign In"),
                  onPressed: _signIn,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _forgetPass();
                  },
                  child: const Text(
                    "Forget Password? click to reset",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: const Text(
                    "Don't have an account yet? Sign up here!",
                    style: TextStyle(
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Routes()),
                    );
                  },
                  child: const Text(
                    "Are you here for testing? Continue as a guest",
                    style: TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
