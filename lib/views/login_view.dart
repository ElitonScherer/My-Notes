import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';


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
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login',
          style:TextStyle(
             color: Colors.white,
          ),

        ),
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.black.withOpacity(0.8),
        elevation: 5,

      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch(snapshot.connectionState){

              case ConnectionState.done:
                return  Center(
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
                        width:300,
                        child: Column(

                          children: [
                            TextField(
                              controller: _email,
                              enableSuggestions:false ,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 12.0),
                                hintText: 'Enter your email here',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0
                                  )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0
                                    )
                                ),
                              )
                            ),
                            const SizedBox(height: 10),
                            TextField(
                                controller: _password,
                                enableSuggestions:false ,
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
                                          width: 1.0
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0
                                      )
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () async {
                          try{
                            final email=_email.text;
                            final password=_password.text;
                            final userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email,
                              password: password,

                            );
                          //  print(userCredential);
                          } on FirebaseAuthException catch (e){
                            if(e.code=='invalid-credential'){
                              print('invalid credential, please try again');
                              
                            }
                          }on Exception catch (e){
                            print(e.toString());
                          }


                        },

                        style:TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 32.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(23.0))
                          ),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                          elevation: 5,
                          shadowColor: Colors.black.withOpacity(0.45),
                        ),
                        child: const Text('Sing up'),

                      )
                    ],

                  )


                );

              default:
                return const Center(child:  Text('Loading...'));

            }


          },

      ),


    );

  }


}