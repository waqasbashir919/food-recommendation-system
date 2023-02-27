import 'package:flutter/material.dart';
import 'package:frs/screens/activity_create.dart';
import 'package:frs/screens/colorcodes.dart';
import 'package:frs/services/database_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Bmr extends StatefulWidget {
  @override
  State<Bmr> createState() => _BmrState();
}

class _BmrState extends State<Bmr> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseMethods databaseMethods = DatabaseMethods();
  bool isResult = false;
  bool isSetTrue = false;
  int isTrue = 0;
  double height = 0;
  int weight = 0;
  int age = 0;
  String? result;
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 43, 40, 40),
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: Text(
              'BMR Calculation',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Basal Metabolic Rate (BMR)",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 120,
                      width: 160,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            isTrue = 0;
                          });
                        },
                        icon: Icon(Icons.man_sharp),
                        label: Text('Male'),
                        style: ElevatedButton.styleFrom(
                          primary: isTrue == 0 ? kPrimarycolour : Colors.black,
                        ),
                      )),
                  Container(
                      height: 120,
                      width: 160,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            isTrue = 1;
                          });
                        },
                        icon: Icon(Icons.man_sharp),
                        label: Text('Female'),
                        style: ElevatedButton.styleFrom(
                          primary: isTrue == 0 ? Colors.black : kPrimarycolour,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Height ',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          height.toStringAsFixed(2) + ' cm',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Slider(
                            value: height,
                            min: 0,
                            max: 185,
                            divisions: 180,
                            activeColor: kPrimarycolour,
                            inactiveColor: Color.fromARGB(255, 201, 194, 172),
                            onChanged: (value) {
                              setState(() {
                                height = value;
                              });
                            }),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: 150,
                        width: (MediaQuery.of(context).size.width / 2) - 15,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Weight',
                              style: TextStyle(color: kWhiteColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$weight' + ' kg',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 25,
                                  width: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: kPrimarycolour),
                                      onPressed: () {
                                        setState(() {
                                          if (weight >= 1) weight = weight - 1;
                                        });
                                      },
                                      child: Container(
                                          child: Icon(
                                        Icons.remove,
                                        size: 18,
                                      ))),
                                ),
                                Container(
                                  height: 25,
                                  width: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: kPrimarycolour),
                                      onPressed: () {
                                        setState(() {
                                          weight = weight + 1;
                                        });
                                      },
                                      child: Container(
                                          child: Icon(
                                        Icons.add,
                                        size: 20,
                                      ))),
                                )
                              ],
                            )
                          ],
                        )),
                    Container(
                        height: 150,
                        width: (MediaQuery.of(context).size.width / 2) - 15,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Age',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$age',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 25,
                                  width: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: kPrimarycolour),
                                      onPressed: () {
                                        setState(() {
                                          if (age >= 1) age = age - 1;
                                        });
                                      },
                                      child: Container(
                                          child: Icon(
                                        Icons.remove,
                                        size: 18,
                                      ))),
                                ),
                                Container(
                                  height: 25,
                                  width: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: kPrimarycolour),
                                      onPressed: () {
                                        setState(() {
                                          age = age + 1;
                                        });
                                      },
                                      child: Container(
                                          child: Icon(
                                        Icons.add,
                                        size: 20,
                                      ))),
                                )
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (age > 0 && weight > 0 && height > 0) {
                      calculateBMR();
                    } else {
                      errorMessage();
                    }
                  },
                  child: Text('Calculate BMR'),
                  style: ElevatedButton.styleFrom(primary: kPrimarycolour),
                ),
              )
            ],
          )),
    );
  }

  calculateBMR() {
    var snackBar = SnackBar(
      content: Column(
        children: [
          Text('Your BMR result'),
          Container(
              child: isTrue == 0
                  ? Container(child: calculateMaleBmr())
                  : Container(child: calculateFemaleBmr())),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Future.delayed(
        Duration(
          seconds: 3,
        ), () {
      if (isResult == true) {
        Navigator.pushNamed(context, '/Dashboard');
      }
    });
  }

  Future errorMessage() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Incomplete information'),
            content: Container(
              child: Text('Please fill all the fields'),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go back'),
                style: ElevatedButton.styleFrom(
                    primary: kPrimarycolour, minimumSize: Size.fromHeight(40)),
              )
            ],
          ));

  calculateMaleBmr() {
    if ((age >= 15 && age <= 80) && weight >= 35 && height >= 56.4) {
      double bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;

      setState(() {
        isResult = true;
        result = bmr.toStringAsFixed(2);
        Map<String, String> userInfo = {
          'name': data['name'],
          'age': data['age'],
          'gender': data['gender'],
          'height': data['height'],
          'weight': data['weight'],
          'disease': data['disease'],
          'phone': data['phone'],
          'alt_phone': data['alt_phone'],
          'calories': result.toString()
        };

        databaseMethods.uploadUserInfo(userInfo);
      });

      return Container(
          child: Text('You have to take $result calories per day'));
    } else if (age < 15 || age > 80) {
      setState(() {
        isResult = false;
      });
      return Container(child: Text('Please provide age between 15-80'));
    } else if (weight < 35) {
      setState(() {
        isResult = false;
      });
      return Container(child: Text('Please provide weight greater than 34'));
    } else if (height < 56.4) {
      setState(() {
        isResult = false;
      });
      return Container(
          child: Text('Please provide height greater than 56.4cm'));
    }
    setState(() {
      isResult = false;
    });
  }

  calculateFemaleBmr() {
    if ((age >= 15 && age <= 80) && weight >= 35 && height >= 56.4) {
      double bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
      String result = bmr.toStringAsFixed(2);
      setState(() {
        isResult = true;
        result = bmr.toStringAsFixed(2);
        Map<String, String> userInfo = {
          'uid': '$uid+1',
          'name': data['name'],
          'age': data['age'],
          'gender': data['gender'],
          'height': data['height'],
          'weight': data['weight'],
          'disease': data['disease'],
          'phone': data['phone'],
          'alt_phone': data['alt_phone'],
          'calories': result.toString()
        };

        databaseMethods.uploadUserInfo(userInfo);
      });
      return Container(
          child: Text('You have to take $result calories per day'));
    } else if (age < 15 || age > 80) {
      setState(() {
        isResult = false;
      });
      return Container(child: Text('Please provide age between 15-80'));
    } else if (weight < 35) {
      setState(() {
        isResult = false;
      });
      return Container(child: Text('Please provide weight greater than 34'));
    } else if (height < 56.4) {
      setState(() {
        isResult = false;
      });
      return Container(
          child: Text('Please provide height greater than 56.4cm'));
    }
  }
}
