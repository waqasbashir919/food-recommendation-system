import 'package:flutter/material.dart';
import 'package:frs/screens/colorcodes.dart';

class OptionScreen extends StatefulWidget {
  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
          'Option Screen',
          style: TextStyle(color: kWhiteColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/foodImage1.png'), fit: BoxFit.fill),
          color: Colors.black,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: 120,
                    width: 160,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Bmr');
                      },
                      icon: Icon(Icons.man_sharp),
                      label: Text('Weight Gain ?'),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimarycolour,
                      ),
                    )),
                Container(
                    height: 120,
                    width: 160,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Bmr');
                      },
                      icon: Icon(Icons.woman_outlined),
                      label: Text('Weight Loss ?'),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimarycolour,
                      ),
                    ))
              ],
            ),
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
                        Navigator.pushNamed(context, '/Milestone');
                      },
                      icon: Icon(Icons.home),
                      label: Text('Milestone'),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimarycolour,
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
