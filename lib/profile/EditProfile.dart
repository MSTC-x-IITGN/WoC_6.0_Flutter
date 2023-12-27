import 'package:flutter/material.dart';

class MyEditProfile extends StatefulWidget {
  String title = 'Wallet';
  MyEditProfile(String name, {super.key}) {
    title = name;
  }

  @override
  State<MyEditProfile> createState() => _MyEditProfileState();
}

class _MyEditProfileState extends State<MyEditProfile> {
  var nameController;
  String pswd = '123456789jay';
  var emailController;
  var passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: const Color.fromRGBO(207, 207, 207, 0.5),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 30),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Name', style: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                          right: 15.0, left: 15.0, top: 15),
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: TextField(
                          controller: TextEditingController(
                              text: 'Chevli Jay Riteshkumar'),
                          style: const TextStyle(height: 2),
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Enter Name'),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 30),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Email ID', style: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                          right: 15.0, left: 15.0, top: 15),
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: TextField(
                          controller: TextEditingController(
                              text: 'jconeseven@gmail.com'),
                          style: const TextStyle(height: 2),
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Enter EmailID'),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 30),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child:
                            Text('Contact No', style: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                          right: 15.0, left: 15.0, top: 15),
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: TextField(
                          controller: TextEditingController(text: '9874561230'),
                          style: const TextStyle(height: 2),
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Enter ContactNo'),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 30),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Password', style: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                          right: 15.0, left: 15.0, top: 15, bottom: 30),
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: TextField(
                          controller: TextEditingController(
                              text: '${pswd}'.replaceRange(
                                  1, pswd.length - 1, '********')),
                          enabled: false,
                          obscureText: false,
                          style: const TextStyle(height: 2),
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Enter Password'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    fixedSize: const Size(150, 50),
                    elevation: 11,
                    shadowColor: Colors.grey,
                  ),
                  child: const Text('Update Profile')),
            ],
          ),
        ),
      ),
    );
  }
}
