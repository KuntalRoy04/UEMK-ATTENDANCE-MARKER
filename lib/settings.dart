import 'package:flutter/material.dart';

import 'admin_login.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key); // Corrected the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade500, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 65.0, right: 15, bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 90),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminLogin()),
                        );
                      },
                      child: const Icon(
                        Icons.switch_account,
                        color: Colors.black,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    // Redirect to the Password page
                  },
                  child: buildOption('Password', 'Change or set Password'),
                ),
                InkWell(
                  onTap: () {
                    // Redirect to the Dark Mode page
                  },
                  child: buildOption('Change Picture', 'Change Picture of yourself'),
                ),
                InkWell(
                  onTap: () {
                    // Redirect to the Change Password page
                  },
                  child: buildOption('Payment Details', 'Change your account password'),
                ),
                InkWell(
                  onTap: () {
                    // Handle logout
                  },
                  child: buildOption('Marks System', 'Check your examination marks'),
                ),
                InkWell(
                  onTap: () {
                    //Show routine
                  },
                  child: buildOption('Class Routine', 'Check class timing daily'),
                ),
                InkWell(
                  onTap: () {
                    //Show routine
                  },
                  child: buildOption('Faculty Details', 'Information of all the faculties'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOption(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
