import 'package:flutter/material.dart';
import 'package:frs/screens/colorcodes.dart';

class Milestone extends StatefulWidget {
  @override
  State<Milestone> createState() => _MilestoneState();
}

class _MilestoneState extends State<Milestone> {
  double currentWeight = 54;
  double startWeight = 50;
  double goalWeight = 75;
  @override
  Widget build(BuildContext context) {
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
            color: kWhiteColor,
          ),
        ),
        title: Text(
          'Milestone',
          style: TextStyle(color: kWhiteColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: kPrimarycolour,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('Duration',
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Calorie required',
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Submit',
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ]),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '3 weeks',
                              style:
                                  TextStyle(color: kWhiteColor, fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('--------',
                                style: TextStyle(
                                    color: kWhiteColor, fontSize: 16)),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/Dashboard');
                              },
                              child: Text('Select',
                                  style: TextStyle(color: kWhiteColor)),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black),
                            ),
                          ],
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '6 weeks',
                              style:
                                  TextStyle(color: kWhiteColor, fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('--------',
                                style: TextStyle(
                                    color: kWhiteColor, fontSize: 16)),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/Dashboard');
                              },
                              child: Text('Select',
                                  style: TextStyle(color: kWhiteColor)),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black),
                            ),
                          ],
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '9 weeks',
                              style:
                                  TextStyle(color: kWhiteColor, fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('--------',
                                style: TextStyle(
                                    color: kWhiteColor, fontSize: 16)),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/Dashboard');
                              },
                              child: Text('Select',
                                  style: TextStyle(color: kWhiteColor)),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black),
                            ),
                          ],
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '12 weeks',
                              style:
                                  TextStyle(color: kWhiteColor, fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('--------',
                                style: TextStyle(
                                    color: kWhiteColor, fontSize: 16)),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/Dashboard');
                              },
                              child: Text('Select',
                                  style: TextStyle(color: kWhiteColor)),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black),
                            ),
                          ],
                        ),
                      ]),
                ],
              ),
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: kPrimarycolour,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Current Weight',
                    style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: 120,
                    decoration: BoxDecoration(
                        color: kBlackColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      '$currentWeight kg',
                      style: TextStyle(color: kWhiteColor, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Start:',
                            style: TextStyle(color: kWhiteColor, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: kBlackColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              '$startWeight kg',
                              style:
                                  TextStyle(color: kWhiteColor, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Goal:',
                            style: TextStyle(color: kWhiteColor, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: kBlackColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              '$goalWeight kg',
                              style:
                                  TextStyle(color: kWhiteColor, fontSize: 15),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
