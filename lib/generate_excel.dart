import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<Map<String, dynamic>?> fetchData(String documentId) async {
  try {
    // Query Firestore based on the date or other parameters
    DocumentReference documentReference = FirebaseFirestore.instance.collection('secretCodes').doc(documentId);

    // Fetch the document
    DocumentSnapshot snapshot = await documentReference.get();

    // Check if there is data
    if (snapshot.exists) {
      // Access all fields
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data;
    } else {
      print('Document does not exist.');
      return null; // Return null if the document does not exist
    }
  } catch (e) {
    print('Error fetching data: $e');
    return null; // Return null in case of an error
  }
}


Future<void> writeToExcel(String documentId, Map<String, dynamic>? data) async {
  // Ensure that documentId is not empty or null
  if (documentId.isNotEmpty) {
    // Check if data is not null before proceeding
    if (data != null) {
      Map<String, dynamic> nonNullableData = data; // No need for ! operator here

      var excel = Excel.createExcel();
      var sheet = excel['Sheet1'];

      // Add headers
      sheet.appendRow(['Field', 'Value']);

      // Add data
      nonNullableData.forEach((key, value) {
        sheet.appendRow([key, value.toString()]);
      });

      // Save to the "Android/media" directory
      Directory? externalStorageDirectory = await getExternalStorageDirectory();
      String excelPath = '${externalStorageDirectory?.path}/Android/media/$documentId.xlsx';

      List<int> onValue = excel.encode() ?? []; // Provide an empty list as a default value if onValue is null
      File(excelPath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);

      Fluttertoast.showToast(
        msg: 'Excel file saved at: $excelPath',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Error: Data is null. Cannot write to Excel!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  } else {
    Fluttertoast.showToast(
      msg: 'Error: Document ID is empty or null.!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.yellow,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}

