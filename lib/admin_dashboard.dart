import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'generate_excel.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late CollectionReference<Map<String, dynamic>> collectionReference;
  List<String> items = [];
  late Timer timer;
  TextEditingController adminSecretCodeController = TextEditingController();

  String generateRandomString(int length) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    String result = '';

    for (int i = 0; i < length; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: const Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            'Data Download',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        toolbarHeight: 80,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25, top: 50.0, right: 25, bottom: 50),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Generate Code', style: TextStyle(fontSize: 20)),
                  InkWell(
                    onTap: () {
                      try {
                        String newCode = generateRandomString(8);
                        FirebaseFirestore.instance.collection('secretCodes').doc(newCode).set({'Enrolment number': 'Name'});
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 50,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Share: $newCode',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 26),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } catch (e) {
                        Fluttertoast.showToast(msg: "Could not Generate. Try again!");
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      size: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              TextField(
                controller: adminSecretCodeController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Admin Secret Code",
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                  onPressed: () async {
                    var documentData = await fetchData(adminSecretCodeController.text);
                    await writeToExcel(adminSecretCodeController.text, documentData);
                    // Add logic to open or display the downloaded file if needed
                  }, child: const Text('Download', style: TextStyle(color: Colors.black),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
