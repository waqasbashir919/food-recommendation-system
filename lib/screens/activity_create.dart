import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:frs/screens/colorcodes.dart';
import 'package:frs/services/database_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'dart:io';

class ActivityCreate extends StatefulWidget {
  ActivityCreate({Key? key, required}) : super(key: key);
  @override
  State<ActivityCreate> createState() => _ActivityCreateState();
}

class _ActivityCreateState extends State<ActivityCreate> {
  DateTime now = new DateTime.now();
  var imageURI;
  var result;
  String path = '';

  List<String> items = ['gram', 'serving (250 g)'];
  String selectedItem = 'gram';
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            color: kPrimarycolour,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  List<String> food = ['Chicken Biryani', 'Chicken Karahi'];
  String selectedFood = 'Chicken Biryani';
  DropdownMenuItem<String> buildFoodItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            color: kPrimarycolour,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Future getfromCamera() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        File img = File(image!.path);
        imageURI = img;
        path = image.path;
      });
    } catch (e) {
      print("Error $e");
    }

    ClassifyImage();
  }

  Future getfromGalery() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        File img = File(image!.path);
        imageURI = img;
        path = image.path;
      });
    } catch (e) {
      print("Error $e");
    }

    ClassifyImage();
  }

  Future ClassifyImage() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
    var output = await Tflite.runModelOnImage(
        path: path,
        threshold: 0.3,
        imageMean: 0.0,
        imageStd: 255.0,
        asynch: true);
    setState(() {
      result = output;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }

  DatabaseMethods databaseMethods = DatabaseMethods();
  final _foodQuantityController = TextEditingController();
  final _servingController = TextEditingController();
  bool isTrue = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  var URL;
  userActivity(int fixCal, String foodTitle, double foodQuantity, File imageURL,
      String date, String time) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('activityImages')
        .child(foodTitle + '.jpg');
    await ref.putFile(imageURL);

    URL = await ref.getDownloadURL();

    Map<String, String> userActivityInfo = {
      'FixCal': fixCal.toString(),
      'CaloriesIntake': CaloriesIntake.toString(),
      'TotalCalIntake': totalCalIntake.toString(),
      'RemainingCal': remainingCalories.toString(),
      'foodTitle': foodTitle,
      'foodQuantity': foodQuantity.toString(),
      'imageURL': URL,
      'createdDay': date,
      'CreatedTime': time,
    };

    databaseMethods.uploadUserActivity(userActivityInfo);
  }

  var age, gender, disease, calories = 0;

  var remainingCalories;
  var totalCalIntake = 0.0;
  var CaloriesIntake = 0.0;

  Map data = {};
  var noneDisease;
  @override
  Widget build(BuildContext context) {
    // data = data.isNotEmpty
    //     ? data
    //     : ModalRoute.of(context)!.settings.arguments as Map;
    // print(data);
    DateTime date = new DateTime(now.year, now.month, now.day);
    int day, month, year;
    day = date.day;
    month = date.month;
    year = date.year;
    String formattedDate =
        day.toString() + '-' + month.toString() + '-' + year.toString();

    int hour, min, sec;
    hour = now.hour;
    min = now.minute;
    sec = now.second;
    String formattedTime = hour.toString() +
        ' hour ' +
        min.toString() +
        ' min ' +
        sec.toString() +
        ' sec';

    if (selectedItem == 'serving (250 g)') {
      setState(() {
        _foodQuantityController.text = '250';
        isTrue = true;
      });
    } else {
      setState(() {
        _foodQuantityController;
        isTrue = false;
      });
    }
    var totalCalAge = [2400, 1300, 1600, 1200, 1400, 1300];
    var isTotalValue;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Activity',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Create new Activity',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(3)),
              child: DropdownButton(
                value: selectedFood,
                items: food.map(buildFoodItem).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedFood = value!;
                  });
                },
                underline: SizedBox(),
                isExpanded: true,
              )),
          SizedBox(
            height: 5,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(3)),
              child: DropdownButton(
                value: selectedItem,
                items: items.map(buildMenuItem).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedItem = value!;
                  });
                },
                underline: SizedBox(),
                isExpanded: true,
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              readOnly: isTrue,
              controller: _foodQuantityController,
              style: TextStyle(color: kPrimarycolour),
              decoration: new InputDecoration(
                fillColor: Colors.black,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
                hintText: 'How much food do you want to eat ?',
                hintStyle: TextStyle(color: kPrimarycolour),
                labelText: 'Quantity',
                labelStyle: TextStyle(color: kPrimarycolour),
                prefixIcon: const Icon(
                  Icons.add_box,
                  color: kPrimarycolour,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          imageURI != null
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Select image from Gallery or Camera',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              color: kPrimarycolour,
                              child: IconButton(
                                onPressed: () {
                                  getfromGalery();
                                },
                                icon: Icon(Icons.photo),
                                color: Colors.black,
                                iconSize: 50,
                              ),
                            ),
                            Card(
                              color: kPrimarycolour,
                              child: IconButton(
                                onPressed: () {
                                  getfromCamera();
                                },
                                icon: Icon(Icons.camera_alt),
                                color: Colors.black,
                                iconSize: 50,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        constraints: BoxConstraints(maxHeight: 400),
                        child: ClipRRect(
                          child: Image(
                            image: FileImage(File(imageURI!.path)),
                            // height: 400,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      result != null && result![0]['label'] == '0 Biryani'
                          ? Text(
                              "Biryani",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          : Container(
                              height: 0,
                              child: Text(""),
                            ),
                      result != null &&
                              result![0]['label'] == '1 Chicken Karahi'
                          ? Text(
                              "Chicken Karahi",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          : Container(
                              height: 0,
                              child: Text(""),
                            ),
                      result != null &&
                              result![0]['label'] == '2 Not Recognized'
                          ? Text(
                              "Not recognized",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          : Container(
                              child: Text(""),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            var readUserData = await FirebaseFirestore.instance
                                .collection('users/$uid/userProfile')
                                .snapshots()
                                .first;

                            age = readUserData.docs.first['age'];
                            age = int.parse(age);
                            gender = readUserData.docs.first['gender'];
                            disease = readUserData.docs.first['disease'];

                            if (disease == "Diabetic type 1") {
                              if (selectedFood == 'Chicken Biryani') {
                                if (age > 8 && age <= 20) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 2400) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1800-3000
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 20 && age <= 40) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1300) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1000-1600
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 40) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1600) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1400-1800
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                }
                              } else if (selectedFood == 'Chicken Karahi') {
                                if (age > 8 && age <= 20) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 2400) {
                                      setState(() {
                                        // 1g contains 0.93 cal , So, 232cal in 250g of karahi ghost
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            0.93;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1800-3000
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 20 && age <= 40) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1300) {
                                      setState(() {
                                        // 1g contains 0.93 cal , So, 232cal in 250g of karahi ghost
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            0.93;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1000-1600
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 40) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1600) {
                                      setState(() {
                                        // 1g contains 0.93 cal , So, 232cal in 250g of karahi ghost
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            0.93;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1400-1800
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                }
                              }
                            } else if (disease == "Diabetic type 2") {
                              if (selectedFood == 'Chicken Biryani') {
                                if (age > 3 && age <= 10) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1200) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 10 && age <= 30) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1600) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 30 && age <= 50) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1400) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 50) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1300) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                }
                              } else if (selectedFood == 'Chicken Karahi') {
                                if (age > 8 && age <= 20) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 2400) {
                                      setState(() {
                                        // 1g contains 0.93 cal , So, 232cal in 250g of karahi ghost
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            0.93;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1800-3000
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 20 && age <= 40) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1300) {
                                      setState(() {
                                        // 1g contains 0.93 cal , So, 232cal in 250g of karahi ghost
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            0.93;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1000-1600
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 40) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1600) {
                                      setState(() {
                                        // 1g contains 0.93 cal , So, 232cal in 250g of karahi ghost
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            0.93;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1400-1800
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                }
                              }
                            } else {
                              if (selectedFood == 'Chicken Biryani') {
                                if (age > 8 && age <= 20) {
                                  setState(() {
                                    CaloriesIntake = double.parse(
                                            _foodQuantityController.text) *
                                        1.32;
                                    totalCalIntake += CaloriesIntake;
                                    // this age group can take calories between 1800-3000
                                    remainingCalories =
                                        calories - totalCalIntake;
                                    isTotalValue = calories;
                                  });
                                } else if (age > 20 && age <= 40) {
                                  setState(() {
                                    CaloriesIntake = double.parse(
                                            _foodQuantityController.text) *
                                        1.32;
                                    totalCalIntake += CaloriesIntake;
                                    // this age group can take calories between 1800-3000
                                    remainingCalories =
                                        calories - totalCalIntake;
                                    isTotalValue = calories;
                                  });
                                } else if (age > 40) {
                                  setState(() {
                                    CaloriesIntake = double.parse(
                                            _foodQuantityController.text) *
                                        1.32;
                                    totalCalIntake += CaloriesIntake;
                                    // this age group can take calories between 1800-3000
                                    remainingCalories =
                                        calories - totalCalIntake;
                                    isTotalValue = calories;
                                  });
                                } else if (selectedFood == 'Chicken Karahi') {
                                  if (age > 8 && age <= 20) {
                                    setState(() {
                                      CaloriesIntake = double.parse(
                                              _foodQuantityController.text) *
                                          1.32;
                                      totalCalIntake += CaloriesIntake;
                                      // this age group can take calories between 1800-3000
                                      remainingCalories =
                                          calories - totalCalIntake;
                                      isTotalValue = calories;
                                    });
                                  } else if (age > 20 && age <= 40) {
                                    setState(() {
                                      CaloriesIntake = double.parse(
                                              _foodQuantityController.text) *
                                          1.32;
                                      totalCalIntake += CaloriesIntake;
                                      // this age group can take calories between 1800-3000
                                      remainingCalories =
                                          calories - totalCalIntake;
                                      isTotalValue = calories;
                                    });
                                  } else if (age > 40) {
                                    setState(() {
                                      CaloriesIntake = double.parse(
                                              _foodQuantityController.text) *
                                          1.32;
                                      totalCalIntake += CaloriesIntake;
                                      // this age group can take calories between 1800-3000
                                      remainingCalories =
                                          calories - totalCalIntake;
                                      isTotalValue = calories;
                                    });
                                  }
                                }
                              }
                            }
                            userActivity(
                                isTotalValue,
                                selectedFood,
                                double.parse(_foodQuantityController.text),
                                imageURI,
                                formattedDate,
                                formattedTime);
                            Navigator.pushNamed(context, '/Dashboard');
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 18),
                          ),
                          style:
                              ElevatedButton.styleFrom(primary: kPrimarycolour),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Select image from Gallery or Camera',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              color: kPrimarycolour,
                              child: IconButton(
                                onPressed: () {
                                  getfromGalery();
                                },
                                icon: Icon(
                                  Icons.photo,
                                  color: Colors.black,
                                ),
                                iconSize: 50,
                              ),
                            ),
                            Card(
                              color: kPrimarycolour,
                              child: IconButton(
                                onPressed: () {
                                  getfromCamera();
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                                iconSize: 50,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            var readUserData = await FirebaseFirestore.instance
                                .collection('users/$uid/userProfile')
                                .snapshots()
                                .first;

                            age = readUserData.docs.first['age'];
                            age = int.parse(age);
                            gender = readUserData.docs.first['gender'];
                            disease = readUserData.docs.first['disease'];
                            calories = readUserData.docs.first['calories'];

                            if (disease == "Diabetic type 1") {
                              if (selectedFood == 'Chicken Biryani') {
                                if (age > 8 && age <= 20) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 2400) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1800-3000
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 20 && age <= 40) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1300) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1000-1600
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 40) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1600) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        // this age group can take calories between 1400-1800
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (selectedFood == 'Chicken Karahi') {
                                  if (age > 8 && age <= 20) {
                                    for (var i = 0;
                                        i < totalCalAge.length;
                                        i++) {
                                      if (totalCalAge[i] == 2400) {
                                        setState(() {
                                          // 1g contains 0.93 cal , So, 232cal in 250g of karahi ghost
                                          CaloriesIntake = double.parse(
                                                  _foodQuantityController
                                                      .text) *
                                              0.93;
                                          totalCalIntake += CaloriesIntake;
                                          // this age group can take calories between 1800-3000
                                          remainingCalories =
                                              totalCalAge[i] - totalCalIntake;
                                          isTotalValue = totalCalAge[i];
                                        });
                                      }
                                    }
                                  } else if (age > 20 && age <= 40) {
                                    for (var i = 0;
                                        i < totalCalAge.length;
                                        i++) {
                                      if (totalCalAge[i] == 1300) {
                                        setState(() {
                                          // 1g contains 0.93 cal , So, 232cal in 250g of karahi ghost
                                          CaloriesIntake = double.parse(
                                                  _foodQuantityController
                                                      .text) *
                                              0.93;
                                          totalCalIntake += CaloriesIntake;
                                          // this age group can take calories between 1000-1600
                                          remainingCalories =
                                              totalCalAge[i] - totalCalIntake;
                                          isTotalValue = totalCalAge[i];
                                        });
                                      }
                                    }
                                  } else if (age > 40) {
                                    for (var i = 0;
                                        i < totalCalAge.length;
                                        i++) {
                                      if (totalCalAge[i] == 1600) {
                                        setState(() {
                                          // 1g contains 0.93 cal , So, 232cal in 250g of karahi ghost
                                          CaloriesIntake = double.parse(
                                                  _foodQuantityController
                                                      .text) *
                                              0.93;
                                          totalCalIntake += CaloriesIntake;
                                          // this age group can take calories between 1400-1800
                                          remainingCalories =
                                              totalCalAge[i] - totalCalIntake;
                                          isTotalValue = totalCalAge[i];
                                        });
                                      }
                                    }
                                  }
                                }
                              }
                            } else if (disease == "Diabetic type 2") {
                              if (selectedFood == 'Chicken Biryani') {
                                if (age > 3 && age <= 10) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1200) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 10 && age <= 30) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1600) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 30 && age <= 50) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1400) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 50) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1300) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            1.32;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                }
                              } else if (selectedFood == 'Chicken Karahi') {
                                if (age > 3 && age <= 10) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1200) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            0.93;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 10 && age <= 30) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1600) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            0.93;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 30 && age <= 50) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1400) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            0.93;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                } else if (age > 50) {
                                  for (var i = 0; i < totalCalAge.length; i++) {
                                    if (totalCalAge[i] == 1300) {
                                      setState(() {
                                        CaloriesIntake = double.parse(
                                                _foodQuantityController.text) *
                                            0.93;
                                        totalCalIntake += CaloriesIntake;
                                        remainingCalories =
                                            totalCalAge[i] - totalCalIntake;
                                        isTotalValue = totalCalAge[i];
                                      });
                                    }
                                  }
                                }
                              }
                            } else {
                              if (selectedFood == 'Chicken Biryani') {
                                if (age > 8 && age <= 20) {
                                  setState(() {
                                    CaloriesIntake = double.parse(
                                            _foodQuantityController.text) *
                                        1.32;
                                    totalCalIntake += CaloriesIntake;
                                    // this age group can take calories between 1800-3000
                                    remainingCalories =
                                        calories - totalCalIntake;
                                    isTotalValue = calories;
                                  });
                                } else if (age > 20 && age <= 40) {
                                  setState(() {
                                    CaloriesIntake = double.parse(
                                            _foodQuantityController.text) *
                                        1.32;
                                    totalCalIntake += CaloriesIntake;
                                    // this age group can take calories between 1800-3000
                                    remainingCalories =
                                        calories - totalCalIntake;
                                    isTotalValue = calories;
                                  });
                                } else if (age > 40) {
                                  setState(() {
                                    CaloriesIntake = double.parse(
                                            _foodQuantityController.text) *
                                        1.32;
                                    totalCalIntake += CaloriesIntake;
                                    // this age group can take calories between 1800-3000
                                    remainingCalories =
                                        calories - totalCalIntake;
                                    isTotalValue = calories;
                                  });
                                } else if (selectedFood == 'Chicken Karahi') {
                                  if (age > 8 && age <= 20) {
                                    setState(() {
                                      CaloriesIntake = double.parse(
                                              _foodQuantityController.text) *
                                          1.32;
                                      totalCalIntake += CaloriesIntake;
                                      // this age group can take calories between 1800-3000
                                      remainingCalories =
                                          calories - totalCalIntake;
                                      isTotalValue = calories;
                                    });
                                  } else if (age > 20 && age <= 40) {
                                    setState(() {
                                      CaloriesIntake = double.parse(
                                              _foodQuantityController.text) *
                                          1.32;
                                      totalCalIntake += CaloriesIntake;
                                      // this age group can take calories between 1800-3000
                                      remainingCalories =
                                          calories - totalCalIntake;
                                      isTotalValue = calories;
                                    });
                                  } else if (age > 40) {
                                    setState(() {
                                      CaloriesIntake = double.parse(
                                              _foodQuantityController.text) *
                                          1.32;
                                      totalCalIntake += CaloriesIntake;
                                      // this age group can take calories between 1800-3000
                                      remainingCalories =
                                          calories - totalCalIntake;
                                      isTotalValue = calories;
                                    });
                                  }
                                }
                              }
                            }
                            userActivity(
                                isTotalValue,
                                selectedFood,
                                double.parse(_foodQuantityController.text),
                                imageURI,
                                formattedDate,
                                formattedTime);
                            Navigator.pushNamed(context, '/Dashboard');
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 18),
                          ),
                          style:
                              ElevatedButton.styleFrom(primary: kPrimarycolour),
                        ),
                      )
                    ],
                  ),
                )
        ],
      )),
    ));
  }
}
