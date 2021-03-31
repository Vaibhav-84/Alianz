import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:zero_hunger/widgets/widget.dart';
import 'package:google_fonts/google_fonts.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController _nameController, _numberController, _desController,_locController;
  String _typeSelected = '';
  DatabaseReference _ref;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _desController = TextEditingController();
    _locController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Posts');
  }

  Widget _buildContactType(String title) {
    return InkWell(
      child: Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          color: _typeSelected == title ? Colors.orange[900] : Colors.orange[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _typeSelected = title;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Post'),
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Your Name',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    prefixIcon: Icon(
                      Icons.account_circle,
                      size: 30,
                      color: Colors.orange,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    hintText: 'Contact',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    prefixIcon: Icon(
                      Icons.phone_android,
                      size: 30,
                      color: Colors.orange,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _desController,
                  decoration: InputDecoration(
                    hintText: 'Detailed Description',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    labelText: "Description",
                    labelStyle: TextStyle(
                      color: Colors.orange,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _locController,
                  decoration: InputDecoration(
                    hintText: 'Location',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    labelText: "Location",
                    labelStyle: TextStyle(
                      color: Colors.orange,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildContactType('Donation'),
                      SizedBox(
                        width: 10,
                      ),
                      _buildContactType('Request'),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // Container(
                //   width: double.infinity,
                //   padding: EdgeInsets.symmetric(horizontal: 10),
                //   child: RaisedButton(
                //     color: Colors.blue,
                //     child: Text(
                //       'Post',
                //       style: TextStyle(
                //         fontSize: 20,
                //         color: Colors.white,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     onPressed: () {
                //       saveContact();
                //     },
                //   ),
                // )

                GestureDetector(
                  onTap: () {
                    saveContact();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.orange[500],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Post",
                      style: GoogleFonts.barlow(
                        textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void saveContact() {
    String name = _nameController.text;
    String number = _numberController.text;
    String description = _desController.text;
    String location = _locController.text;

    Map<String, String> contact = {
      'name': name,
      'number': number,
      'location':location,
      'description': description,

      'type': _typeSelected,
    };

    _ref.push().set(contact).then((value) {
      Navigator.pop(context);
    });
  }
}
