import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frs/screens/Dashboard.dart';
import 'package:frs/screens/colorcodes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frs/services/database_methods.dart';

// import 'package:get/get.dart';
// import 'package:multiselect/multiselect.dart';

class userprofile extends StatefulWidget {
  const userprofile({Key? key}) : super(key: key);

  @override
  State<userprofile> createState() => _userprofileState();
}

class _userprofileState extends State<userprofile> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  final name_controller = TextEditingController();
  final age_controller = TextEditingController();
  final height_controller = TextEditingController();
  final weight_controller = TextEditingController();
  final phone_controller = TextEditingController();
  final alt_phone_controller = TextEditingController();
  String uid = FirebaseAuth.instance.currentUser!.uid;

  uploadUserProfile(
      String name, age, gender, height, weight, disease, phone, alt_phone) {
    Map<String, String> userInfo = {
      'name': name.trim(),
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'disease': disease,
      'phone': phone,
      'alt_phone': alt_phone,
    };

    databaseMethods.uploadUserInfo(userInfo);
  }

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  List<String> items = ["none", "Diabetic type 1", "Diabetic type 2"];
  String selecteditem = "none";

  List<String> items2 = [
    "4",
    "4.1",
    "4.2",
    "4.3",
    "4.4",
    "4.5",
    "4.6",
    "4.7",
    "4.8",
    "4.9",
    "5",
    "5.1",
    "5.2",
    "5.3",
    "5.4",
    "5.5",
    "5.6",
    "5.7",
    "5.8",
    "5.9",
    "6",
    "6.1",
    "6.2",
    "6.3",
    "6.4",
    "6.5",
    "6.6",
    "6.7",
    "6.8",
    "6.9",
    "7",
    "7.1",
    "7.2",
    "7.3",
    "7.4",
    "7.5",
    "7.6",
    "7.7",
    "7.8",
    "7.9",
    "8",
    "none"
  ];
  String selecteditem2 = "none";
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'INFORMATION WE NEED\n',
                        style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      TextSpan(
                        text: 'Please Follow the Basic Steps',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: kPrimarycolour),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Theme(
                data: ThemeData(
                    buttonTheme: ButtonThemeData(
                        buttonColor: Colors.orange,
                        colorScheme: ColorScheme.dark(
                            onPrimary: Colors.white, primary: Colors.red)),
                    backgroundColor: Colors.white,
                    colorScheme: ColorScheme.light(
                      primary: kPrimarycolour,
                    )),
                child: Stepper(
                  type: stepperType,
                  physics: const ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancelled,
                  steps: <Step>[
                    Step(
                      title: const Text(
                        "Basic Information",
                        style: TextStyle(color: kWhiteColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: name_controller,
                            style: TextStyle(color: kPrimarycolour),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kWhiteColor)),
                              labelText: "Name",
                              labelStyle: TextStyle(
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: age_controller,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: kPrimarycolour),
                            decoration: InputDecoration(
                              labelText: "Age",
                              labelStyle: TextStyle(
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Gender",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                value: "Male",
                                groupValue: gender,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => kPrimarycolour),
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("Male"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                value: "Female",
                                groupValue: gender,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => kPrimarycolour),
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("Female"),
                            ],
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: const Text(
                        "Technical Information",
                        style: TextStyle(color: kWhiteColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Height",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: kWhiteColor),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(canvasColor: kPrimarycolour),
                              child: DropdownButton(
                                isExpanded: true,
                                items: items2.map((String items2) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      items2,
                                      style: TextStyle(color: kWhiteColor),
                                    ),
                                    value: items2,
                                  );
                                }).toList(),
                                value: selecteditem2,
                                onChanged: (String? newValue2) {
                                  setState(() {
                                    selecteditem2 = newValue2!;
                                  });
                                },
                              ),
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            controller: weight_controller,
                            style: TextStyle(color: kPrimarycolour),
                            decoration: InputDecoration(
                              labelText: "Weight",
                              labelStyle: TextStyle(
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Disease",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: kWhiteColor),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(canvasColor: kPrimarycolour),
                              child: DropdownButton(
                                isExpanded: true,
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    child: Text(items),
                                    value: items,
                                  );
                                }).toList(),
                                value: selecteditem,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selecteditem = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: const Text(
                        "Contact Information",
                        style: TextStyle(color: kWhiteColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            style: TextStyle(color: kPrimarycolour),
                            controller: phone_controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              labelStyle: TextStyle(
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            style: TextStyle(color: kPrimarycolour),
                            controller: alt_phone_controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Alternative Phone Number",
                              labelStyle: TextStyle(
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (selecteditem == "none") {
                  Navigator.pushNamed(context, '/Bmr', arguments: {
                    'name': name_controller.text,
                    'age': age_controller.text,
                    'gender': gender,
                    'height': selecteditem2,
                    'weight': weight_controller.text,
                    'disease': selecteditem,
                    'phone': phone_controller.text,
                    'alt_phone': alt_phone_controller.text
                  });
                } else {
                  uploadUserProfile(
                      name_controller.text,
                      age_controller.text,
                      gender,
                      selecteditem2,
                      weight_controller.text,
                      selecteditem,
                      phone_controller.text,
                      alt_phone_controller.text);
                  Navigator.pushNamed(context, '/Dashboard');
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(120, 0, 20, 40),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      color: kPrimarycolour,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "All Set",
                          style: TextStyle(color: kWhiteColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // SvgPicture.asset(
                        //   "assets/icons/forward.svg",
                        //   height: 11,
                        // ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: kWhiteColor,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  continued() {
    _currentStep < 2
        ? setState(
            () => _currentStep += 1,
          )
        : null;
  }

  cancelled() {
    _currentStep > 0
        ? setState(
            () => _currentStep -= 1,
          )
        : null;
  }
}
