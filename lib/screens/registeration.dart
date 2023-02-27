import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frs/screens/Dashboard.dart';
import 'package:frs/screens/login.dart';
import 'package:frs/screens/stepper.dart';
import 'package:frs/services/database_methods.dart';
// import 'package:frsprofile/Dashboard.dart';
import 'colorcodes.dart';

class registeration extends StatefulWidget {
  const registeration({Key? key}) : super(key: key);

  @override
  State<registeration> createState() => _registerationState();
}

class _registerationState extends State<registeration> {
  final DatabaseMethods databaseMethods = DatabaseMethods();
  final formKey = GlobalKey<FormState>();

  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  Future signUp() async {
    FocusScope.of(context).unfocus();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email_controller.text.trim(),
          password: password_controller.text.trim());

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => userprofile()));
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  bool isTrue = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: kPrimarycolour),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: kPrimarycolour,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Enter your name",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.home,
                          color: kPrimarycolour,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          decoration:
                              InputDecoration(hintText: "Permanent Address"),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
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
                                  controller: email_controller,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      hintText: "Email Address"),
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
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
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
                                  controller: password_controller,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isTrue = !isTrue;
                                          });
                                        },
                                        child: isTrue == true
                                            ? Icon(
                                                Icons.visibility,
                                                color: kPrimarycolour,
                                              )
                                            : Icon(Icons.visibility_off,
                                                color: kPrimarycolour),
                                      )),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == "") {
                                      return "Please type password";
                                    } else if (value!.length < 6) {
                                      return 'Enter minimum 6 characters';
                                    } else {
                                      return null;
                                    }
                                  },
                                  obscureText: isTrue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: <Widget>[
                //       Padding(
                //         padding: const EdgeInsets.only(right: 16.0),
                //         child: Icon(
                //           Icons.lock,
                //           color: kPrimarycolour,
                //         ),
                //       ),
                //       Expanded(
                //         child: TextField(
                //           textInputAction: TextInputAction.next,
                //           decoration:
                //               InputDecoration(hintText: "Confirm Password"),
                //           obscureText: isTrue,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: signUp,
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 50,
                      margin: EdgeInsets.only(bottom: 28),
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kPrimarycolour,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
