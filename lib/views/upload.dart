import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:zero_hunger/widgets/widget.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController _nameController, _numberController;
  String _typeSelected = '';
  DatabaseReference _ref;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Posts');
  }

  Widget _buildContactType(String title) {
    return InkWell(
      child: Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          color: _typeSelected == title ? Colors.green : Colors.red,
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
          backgroundColor: Colors.red[500],
        ),
        body: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    prefixIcon: Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                  )),
              SizedBox(height: 15),
              TextFormField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    hintText: 'Enter Nunber',
                    prefixIcon: Icon(
                      Icons.phone_android,
                      size: 30,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                  )),
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
                    _buildContactType('Volunteer'),
                    SizedBox(
                      width: 10,
                    ),
                    _buildContactType('Want To Donate'),
                    SizedBox(
                      width: 10,
                    ),
                    _buildContactType('Want To Help'),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25,),
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
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.red[500],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Post",
                            style: mediumTextStyle(),
                          ),
                        ),
                      ),
            ],
          ),
        ));
  }

  void saveContact() {
    String name = _nameController.text;
    String number = _numberController.text;

    Map<String, String> contact = {
      'name': name,
      'number': number,
      'type': _typeSelected,
    };

    _ref.push().set(contact).then((value){
      Navigator.pop(context);
    });
  }
}
