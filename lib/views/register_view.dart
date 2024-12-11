
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Register',style: TextStyle(color: Colors.white),),backgroundColor: Colors.blueAccent,),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sign Up for Your Accountt',
      
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
      
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 300,
              child: Column(
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 12.0),
                      hintText: 'Enter your email here',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _password,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 12.0),
                        hintText: 'Enter your password here',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            )
                        )
      
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                try {
                  final email = _email.text;
                  final password = _password.text;
      
                  final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                      email: email,
                      password: password
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'channel-error') {
                    print('Fill in the fields before proceeding');
                  } else if (e.code == 'invalid-email') {
                    print('Invalid Email');
                  } else if (e.code == 'weak-password') {
                    print('Invalid password, enter at least 6 characters');
                  } else if (e.code == 'email-already-in-use') {
                    print('This email is already in use');
                  }
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 32.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(23.0)),
                ),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
                elevation: 5,
                shadowColor: Colors.black.withOpacity(0.45),
              ),
      
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false,);


              },
              child: const Text('Are you registered? Log in to your account!',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  decorationThickness: 2,
                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}


