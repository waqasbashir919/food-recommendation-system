import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frs/screens/login.dart';
import 'package:frs/screens/start.dart';
import 'package:frs/services/database_methods.dart';
import 'colorcodes.dart';
import 'widgets/DashFeatures.dart';
import 'widgets/Dashprogress.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DatabaseMethods databaseMethods = DatabaseMethods();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  var title, imageURL, quantity, createdDay, createdTime;

  @override
  Widget build(BuildContext context) {
    var email = FirebaseAuth.instance.currentUser!.email;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        // backgroundColor: kPrimarycolour,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 35),
              decoration: BoxDecoration(
                  // color: Colors.blue,
                  ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/user dp.JPG'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users/$uid/userProfile')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          var currentUser;
                          for (var i = 0; i < snapshot.data!.docs.length; i++) {
                            currentUser = snapshot.data!.docs[i]['name'];
                          }
                          return Text(
                            currentUser,
                            style: TextStyle(fontSize: 20),
                          );
                        } else {
                          return Text(
                            'You did not set your username',
                            style: TextStyle(fontSize: 20),
                          );
                        }
                      }),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    email.toString(),
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                tileColor: Color.fromARGB(255, 27, 27, 27),
                title: const Text('Home'),
                onTap: () {
                  _scaffoldKey.currentState!.closeDrawer();
                },
                leading: Icon(Icons.home),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                tileColor: Color.fromARGB(255, 27, 27, 27),
                title: const Text('Delete Account'),
                onTap: () async {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Center(
                              child: AlertDialog(
                            actions: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                          'Are you sure you want to delete your account ?'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) => Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                        color: kPrimarycolour,
                                                      )));
                                              Future.delayed(
                                                  Duration(milliseconds: 3000),
                                                  () {
                                                databaseMethods.deleteAccount();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            start())));
                                              });
                                            },
                                            child: Text('Yes'),
                                            style: ElevatedButton.styleFrom(
                                              primary: kPrimarycolour,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'),
                                            style: ElevatedButton.styleFrom(
                                              primary: kPrimarycolour,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )));
                  // databaseMethods.deleteAccount();
                },
                leading: Icon(Icons.delete),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                tileColor: Color.fromARGB(255, 27, 27, 27),
                title: const Text('Logout'),
                onTap: () async {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Center(
                              child: CircularProgressIndicator(
                            color: kPrimarycolour,
                          )));
                  Future.delayed(Duration(milliseconds: 2000), () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => start()));
                  });
                },
                leading: Icon(Icons.logout),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => _scaffoldKey.currentState!.openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 50),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(
                      "assets/icons/menu.svg",
                      height: 11,
                      color: kPrimarycolour,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Text(
                  "Dashboard to Manage \nYour Health",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    DashboardFeatures(title: "Activities", active: true),
                    DashboardFeatures(title: "Calories"),
                    DashboardFeatures(title: "Indicators"),
                    DashboardFeatures(title: "Status"),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kPrimarycolour),
                ),
                child: SvgPicture.asset("assets/icons/search.svg",
                    color: kPrimarycolour),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users/$uid/userActivity')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var length = snapshot.data!.docs.length;
                    if (length > 0) {
                      var lastIndex = snapshot.data!.docs.last;
                      title = lastIndex['foodTitle'];
                      imageURL = lastIndex['imageURL'];
                      quantity = lastIndex['foodQuantity'];
                      createdDay = lastIndex['createdDay'];
                      createdTime = lastIndex['CreatedTime'];
                      return Column(
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'You have created $length activities',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Dashprogress(),
                                        ));
                                  },
                                  label: Text('Check all'),
                                  icon: Icon(Icons.visibility),
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimarycolour),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.all(15),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  Image.network(
                                    imageURL,
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  ListTile(
                                    title: Text(
                                      title,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      quantity + " gram",
                                      style: TextStyle(
                                          color: kPrimarycolour, fontSize: 17),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Created Day: ",
                                              style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              createdDay,
                                              style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Created Time: ",
                                              style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              createdTime,
                                              style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text('You did not created any activity yet.'));
                },
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 28, right: 28, top: 20, bottom: 5),
                child: Text(
                  'Create new Activity',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/ActivityCreate');
                  },
                  child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kPrimarycolour,
                        ),
                        height: 50,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          color: kBlackColor,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
