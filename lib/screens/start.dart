import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frs/screens/Dashboard.dart';
import 'colorcodes.dart';
import 'login.dart';

class start extends StatelessWidget {
  const start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/cherry.jpg'),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'HEALTH LESSONS\n',
                          style: Theme.of(context).textTheme.headline5),
                      TextSpan(
                          text: 'MASTER THE ART OF PREDICTING',
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => StreamBuilder<User?>(
                                  stream:
                                      FirebaseAuth.instance.authStateChanges(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text("Something went wrong"),
                                      );
                                    } else if (snapshot.hasData) {
                                      return Dashboard();
                                    } else {
                                      return SignUp();
                                    }
                                  }))));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 28),
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kPrimarycolour,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Some Workouts',
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
        ],
      ),
    );
  }
}
