import 'package:flutter/material.dart';

import 'admin_dashboard.dart';

class AdminLogin extends StatefulWidget {
  AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isShowPasswordIconTapped = false;

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: const Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            'Admin Login',
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
            end: Alignment.bottomCenter,
          ),
        ),
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding:  const EdgeInsets.only(left: 15, top: 50.0, right: 15, bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                const SizedBox(height: 50.0,),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: const Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0,),
                TextField(
                  controller: _passwordController,
                  obscureText: !isShowPasswordIconTapped,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          isShowPasswordIconTapped = !isShowPasswordIconTapped;
                        });
                      },
                      child: isShowPasswordIconTapped? const Icon(Icons.visibility):const Icon(Icons.visibility_off)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          String username = _usernameController.text;
                          String password = _passwordController.text;

                          if (username == 'admin' && password == 'admin123') {
                            // Navigate to the admin dashboard or perform desired actions
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const AdminDashboard()),
                            );
                          } else {
                            // Show error message or handle invalid login
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Invalid Credentials'),
                                  content: const Text('Please check your username and password.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text('Login', style: TextStyle(color: Colors.black))
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

