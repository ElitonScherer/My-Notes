import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilites/show_error_dialog.dart';

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
    _email = TextEditingController();
    _password = TextEditingController();
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
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ))),
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

                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  final user = AuthService.firebase().currentUser;
                  await AuthService.firebase().sendEmailVerification();

                  Navigator.of(context).pushNamed(verifyEmailRoute);
                }on ChannelErrorAuthException catch(e){
                  await showErrorDialog(
                    context,
                    'Fill in the fields before proceeding',
                  );
                }on InvalidEmailAuthException catch(e) {
                  await showErrorDialog(
                    context,
                    'Invalid Email',
                  );

                }on WeakPasswordAuthException catch(e) {
                  await showErrorDialog(
                    context,
                    'Invalid password, enter at least 6 characters',
                  );

                }on EmailAlreadyInUseAuthException catch(e) {
                  await showErrorDialog(
                    context,
                    'This email is already in use',
                  );

                } on GenericAuthException catch(e){

                  await showErrorDialog(
                    context,
                    'Failed to register',
                  );
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
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                elevation: 5,
                shadowColor: Colors.black.withOpacity(0.45),
              ),
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text(
                'Are you registered? Log in to your account!',
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
