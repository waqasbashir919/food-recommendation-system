import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frs/screens/Dashboard.dart';
import 'package:frs/screens/registeration.dart';
import 'package:frs/screens/start.dart';
import 'colorcodes.dart';
import 'stepper.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  Future signIn() async {
    FocusScope.of(context).unfocus();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
                child: CircularProgressIndicator(
              color: kPrimarycolour,
            )));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_controller.text.trim(),
          password: password_controller.text.trim());
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Dashboard()),
      );

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/cherry.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "LOG IN",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/Registration');
                        },
                        child: Text(
                          "SIGN UP",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.alternate_email,
                            color: kPrimarycolour,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: email_controller,
                            decoration:
                                InputDecoration(hintText: "Email Address"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == "") {
                                return "Please fill the email box";
                              } else if (!regExp.hasMatch(value!)) {
                                return "Invalid email format";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.lock,
                          color: kPrimarycolour,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: password_controller,
                          decoration: InputDecoration(hintText: "Password"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == "") {
                              return "Please type password";
                            } else if (value!.length < 6) {
                              return 'Enter minimum 6 characters';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          child: Icon(
                            Icons.android,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          child: Icon(
                            Icons.chat,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: signIn,
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimarycolour,
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
