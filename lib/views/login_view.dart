import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilites/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Log In to Your Account',
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
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
                    )),
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
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              try {
                final email = _email.text;
                final password = _password.text;


                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } else {
                  await AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamedAndRemoveUntil(verifyEmailRoute,(route) => false,);
                }
              } on InvalidCredentialAuthException catch(e){

                await showErrorDialog(
                  context,
                  'Invalid Credential',
                );

              }on ChannelErrorAuthException catch(e){
                await showErrorDialog(
                  context,
                  'Fill in the fields',
                );

              } on InvalidEmailAuthException catch(e){
                await showErrorDialog(
                  context,
                  'Invalid Email',
                );

              } on GenericAuthException catch(e) {
                await showErrorDialog(
                  context,
                  'Authentication error',
                );
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(23.0))),
              foregroundColor: Colors.white,
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              elevation: 5,
              shadowColor: Colors.black.withOpacity(0.45),
            ),
            child: const Text('Sing up'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text(
              'Not registered yet? Register here!',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
                decorationThickness: 2,
              ),
            ),
          )
        ],
      )),
    );
  }
}
