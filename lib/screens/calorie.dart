import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frs/screens/colorcodes.dart';
import 'constant.dart';

class calorie extends StatefulWidget {
  const calorie({Key? key}) : super(key: key);

  @override
  State<calorie> createState() => _calorieState();
}

class _calorieState extends State<calorie> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DateTime now = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime date = new DateTime(now.year, now.month, now.day);
    int day, month, year;
    day = date.day;
    month = date.month;
    year = date.year;
    String formattedDate =
        day.toString() + '-' + month.toString() + '-' + year.toString();

    var totalCalIntake = 0.0;
    var calIntake;
    var remaCal = 0.0;
    var fixCal = 0.0;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 50, right: 20),
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 24, 226, 132),
                      Color.fromARGB(255, 8, 85, 42),
                    ],
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/virus.png"),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.arrow_back_ios_new)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/Drcorona.svg",
                            width: 230,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                          Positioned(
                            top: 20,
                            left: 150,
                            child: Text(
                              "All you need \nis stay healthy",
                              style: kHeadingTextStyle.copyWith(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                      value: "Pakistan",
                      items: [
                        'Pakistan',
                        'Bangladesh',
                        'United States',
                        'Japan'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Health Update\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                              text: "Newest update Febuary $day",
                              style: TextStyle(
                                color: kTextLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              builder: (context, child) => Theme(
                                  data: ThemeData().copyWith(
                                      colorScheme: ColorScheme.dark(
                                          primary: Colors.white),
                                      dialogBackgroundColor: Colors.black),
                                  child: child!));
                          if (newDate == null) return;
                          setState(() {
                            now = newDate;
                            day = now.day;
                            month = now.month;
                            year = now.year;
                            formattedDate = day.toString() +
                                '-' +
                                month.toString() +
                                '-' +
                                year.toString();
                            print(formattedDate);
                          });
                        },
                        child: Text(
                          "Select Date",
                          style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: kPrimarycolour),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  // StreamBuilder(
                  //     stream: FirebaseFirestore.instance
                  //         .collection('users/$uid/userProfile')
                  //         .snapshots(),
                  //     builder:
                  //         (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //       if (snapshot.hasData) {

                  //         var calories = snapshot.data!.docs[0]['calories'];
                  //       }
                  //       return Container();
                  //     }),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users/$uid/userActivity')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            var length = snapshot.data!.docs.length;
                            totalCalIntake = 0;
                            for (var i = 0; i < length; i++) {
                              var items = snapshot.data!.docs[i];
                              var day = items['createdDay'];
                              calIntake = items['CaloriesIntake'];
                              var hardCodeCal = items['FixCal'];
                              if (day == formattedDate) {
                                totalCalIntake += double.parse(calIntake);
                                fixCal = double.parse(hardCodeCal);
                              }
                            }
                            remaCal = fixCal - totalCalIntake;
                            int currentCal = totalCalIntake.toInt();
                            int remCal = remaCal.toInt();
                            int finalCal = fixCal.toInt();

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Counter(
                                  color: kIColor,
                                  number: currentCal,
                                  title: "Consumption",
                                ),
                                Counter(
                                  color: kRcolor,
                                  number: remCal,
                                  title: "Remaining Cal",
                                ),
                                Counter(
                                  color: kDColor,
                                  number: finalCal,
                                  title: "Required Cal",
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Counter(
                                  color: kIColor,
                                  number: 0,
                                  title: "Current Cal",
                                ),
                                Counter(
                                  color: kDColor,
                                  number: 0,
                                  title: "Required Cal",
                                ),
                                Counter(
                                  color: kRcolor,
                                  number: 0,
                                  title: "Remaining Cal",
                                ),
                              ],
                            );
                          }
                        }),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Healthiest Ratio",
                        style: kTitleTextstyle,
                      ),
                      Text(
                        "See details",
                        style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    padding: EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.contain,
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
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  const Counter({
    Key? key,
    required this.number,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "$number",
          style: TextStyle(
            fontSize: 20,
            color: color,
          ),
        ),
        Text(title, style: kSubTextStyle),
      ],
    );
  }
}
