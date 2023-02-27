import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frs/screens/colorcodes.dart';

class Dashprogress extends StatefulWidget {
  const Dashprogress({
    Key? key,

    //required this.press,
  }) : super(key: key);

  @override
  State<Dashprogress> createState() => _DashprogressState();
}

class _DashprogressState extends State<Dashprogress> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  var title, imageURL, quantity, createdDay, createdTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'All Activities',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users/$uid/userActivity')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var length = snapshot.data!.docs.length;

            return ListView.builder(
              itemCount: length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                var items = snapshot.data!.docs[i];
                title = items['foodTitle'];
                imageURL = items['imageURL'];
                quantity = items['foodQuantity'];
                createdDay = items['createdDay'];
                createdTime = items['CreatedTime'];
                return Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(15),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Image.network(
                          imageURL,
                          height: MediaQuery.of(context).size.height * 0.25,
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
                            style:
                                TextStyle(color: kPrimarycolour, fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Created Day: ",
                                    style: TextStyle(
                                        color: kWhiteColor, fontSize: 15),
                                  ),
                                  Text(
                                    createdDay,
                                    style: TextStyle(
                                        color: kWhiteColor, fontSize: 15),
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
                                        color: kWhiteColor, fontSize: 15),
                                  ),
                                  Text(
                                    createdTime,
                                    style: TextStyle(
                                        color: kWhiteColor, fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text('You did not created any activity yet.'));
          }
        },
      ),
    );
  }
}
