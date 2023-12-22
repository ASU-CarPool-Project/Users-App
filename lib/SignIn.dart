import 'package:asu_carpool/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool _isObscure = true;

  /////////////////////////////////////////////////////////////////////////////

  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: controllerEmail.text.trim(),
          password: controllerPassword.text);

      // If sign-in is successful, navigate to the next screen (Routes)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const home()),
      );

      // Reset the form after successful sign-in
      formKey.currentState!.reset();
      toastMsg("Sign In Successful!");
    } on FirebaseAuthException catch (e) {
      print("Failed to sign in: $e");
      toastMsg("Failed to Sign In: ${e.message}");
    }
  }

  Future<void> _forgetPass() async {
    String email = ''; // Variable to store the entered email

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Reset Password"),
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
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset("assets/logos/ASCP_User.png",
                      height: 200, width: 200),
                ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText:
                            _isObscure, // _isObscure is a boolean variable to toggle visibility
                        controller: controllerPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ('Enter Your Password');
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: const OutlineInputBorder(),
                          hintText: 'Password',
                          icon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
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
                  onPressed: _signIn,
                  child: textButtons("Sign In"),
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
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text(
                    "Don't have an account yet? Sign up here",
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
                      MaterialPageRoute(builder: (context) => const home()),
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
