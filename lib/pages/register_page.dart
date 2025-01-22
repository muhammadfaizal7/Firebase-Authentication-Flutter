import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_sosial_media/components/my_button.dart';
import 'package:minimal_sosial_media/components/my_textfield.dart';
import 'package:minimal_sosial_media/helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final TextEditingController uesernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  // register method
  void register() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // make sure password matches
    if (passwordController.text != confirmPwController.text) {
      // pop loading circle
      Navigator.pop(context);
      // show error message to the user
      displayMessageToUser("Password don't match!", context);
    } else {
      // try creating the user
      try {
        // create the user
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // pop loading circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);
        // display error message to user
        displayMessageToUser(e.code, context);
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
              // username textfield
              MyTextfield(
                  hintText: "Username",
                  obsecureText: false,
                  controller: uesernameController),
              const SizedBox(
                height: 10,
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
              // confirm password textfield
              MyTextfield(
                  hintText: "Confirm Password",
                  obsecureText: true,
                  controller: confirmPwController),
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
              // register button
              const SizedBox(
                height: 10,
              ),
              MyButton(text: "Register", onTap: register),
              const SizedBox(
                height: 25,
              ),
              // don't have an account? register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login Here",
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
