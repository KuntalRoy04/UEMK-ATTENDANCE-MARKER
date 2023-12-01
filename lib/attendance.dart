import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:geolocator/geolocator.dart';
import 'get_location.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);
  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final Future<bool> developerMode = FlutterJailbreakDetection.developerMode;
  final enController = TextEditingController();
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('Attendance');
  bool isLoading = false;

  bool _isLocationInArea(double latitude, double longitude) {
    // Replace these values with the coordinates of the particular area
    // double areaLatitude = 22.687411702663145;
    // double areaLongitude = 88.46009886931323;

    double areaLatitude = 22.56008058963318;
    double areaLongitude = 88.4900667024951;

    // Set a threshold for latitude and longitude (adjust as needed)
    double threshold = 0.00099964005;

    // Check if the current location is within the area
    return (latitude >= areaLatitude - threshold &&
        latitude <= areaLatitude + threshold &&
        longitude >= areaLongitude - threshold &&
        longitude <= areaLongitude + threshold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade500, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
            child: Stack(// Use a Stack to overlay BottomNavigationBar
              children: [
                Center(child: SizedBox(
                  width: 310,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 100),
                      Center(child: Image.asset('images/uem.png')),
                      Container(height: 40),
                      TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black87),
                              borderRadius: BorderRadius.circular(28),
                            ),
                          )),
                      Container(height: 20),
                      TextField(
                        controller: enController,
                        keyboardType: TextInputType.number, // Set the keyboard type to numeric
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(14),
                          FilteringTextInputFormatter.digitsOnly, // Allow only digits
                        ],
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black87),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          hintText: "Enrolment number",
                        ),
                      ),
                      Container(height: 20),
                      TextField(
                          controller: codeController,
                          decoration: InputDecoration(
                            hintText: 'Secret Code',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black87),
                              borderRadius: BorderRadius.circular(28),
                            ),
                          )),
                      Container(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          Position? currentLocation = await getCurrentLocation();
                          if (enController.text.isEmpty || enController.text.length != 14 || codeController.text.isEmpty || !_isLocationInArea(currentLocation!.latitude, currentLocation.longitude)|| await developerMode) {
                              if (await developerMode){
                                Fluttertoast.showToast(
                                  msg: 'Turn off Developer Mode because this allows location spoofing',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                              else if(enController.text.isEmpty || enController.text.length != 14 || codeController.text.isEmpty){
                                Fluttertoast.showToast(
                                  msg: 'Enter correct Enrolment number or secret code!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                              else if (!_isLocationInArea(currentLocation!.latitude, currentLocation.longitude)){
                                  Fluttertoast.showToast(
                                    msg: 'You are not in college!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                            else {
                              // Get a reference to the document
                              DocumentReference documentRef = FirebaseFirestore.instance.collection('secretCodes').doc(codeController.text);
                              // Add a new field to the existing document
                              DocumentSnapshot documentSnapshot = await documentRef.get();
                              if (documentSnapshot.exists) {
                                await documentRef.set({
                                  enController.text : nameController.text,
                                }, SetOptions(merge: true))
                                    .then((enrollmentDocRef) {
                                      nameController.clear();
                                      enController.clear();
                                      codeController.clear();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Future.delayed(const Duration(seconds: 3), () {
                                        // Close the dialog after 3 seconds
                                        Navigator.of(context).pop();
                                      });
                                      return const AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 50,
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              "Attendance Marked",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                })
                                    .catchError((error) {
                                  Fluttertoast.showToast(
                                    msg: 'Could not upload Attendance!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                });
                                setState(() {
                                  isLoading = false;
                                });
                              }
                              else{
                                Fluttertoast.showToast(
                                  msg: 'Incorrect Code!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.yellow,
                                  textColor: Colors.black,
                                  fontSize: 16.0,
                                );
                              }
                              setState(() {
                                isLoading = false;
                              });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                            backgroundColor: Colors.white,
                        ),
                        child: isLoading
                          ? const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Set the color
                            strokeWidth: 4,
                        ),
                          )
                            : const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Present 🙋', style: TextStyle(color: Colors.black, fontSize: 20)),
                            ),
                      )
                    ],
                  ),
                ),)
              ],
            )
        ),
      ),
    );
  }
}