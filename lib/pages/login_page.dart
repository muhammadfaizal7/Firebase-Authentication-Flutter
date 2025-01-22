import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_sosial_media/components/my_button.dart';
import 'package:minimal_sosial_media/components/my_textfield.dart';
import 'package:minimal_sosial_media/helper/helper_function.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // login method
  void login() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      // try signing in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // close loading circle only if the widget is still mounted
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // close loading circle only if the widget is still mounted
      if (mounted) {
        Navigator.pop(context);
      }

      // display error message to user
      if (mounted) {
        displayMessageToUser(e.message ?? "An error occurred", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Menambahkan properti ini
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        // Membungkus dalam SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(
                height: 25,
              ),
              // app name
              const Text(
                "F A Z A R U N",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              // email textfield
              MyTextfield(
                  hintText: "Email",
                  obsecureText: false,
                  controller: emailController),
              const SizedBox(
                height: 10,
              ),
              // password textfield
              MyTextfield(
                  hintText: "Password",
                  obsecureText: true,
                  controller: passwordController),
              const SizedBox(
                height: 10,
              ),
              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ],
              ),
              // sign in button
              const SizedBox(
                height: 10,
              ),
              MyButton(text: "Login", onTap: login),
              const SizedBox(
                height: 25,
              ),
              // don't have an account? register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
