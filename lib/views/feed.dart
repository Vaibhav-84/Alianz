import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:zero_hunger/services/auth.dart';
import 'package:zero_hunger/helper/authenticate.dart';
import 'package:zero_hunger/views/edit_feed.dart';
import 'package:zero_hunger/views/upload.dart';
import 'package:zero_hunger/widgets/widget.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayFeed extends StatefulWidget {
  @override
  _DisplayFeedState createState() => _DisplayFeedState();
}

class _DisplayFeedState extends State<DisplayFeed> {
  AuthMethods authMethods = new AuthMethods();

  Query _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('Posts');

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('Posts');
  }

  Widget _buildContactItem({Map contact}) {
    Color typeColor = getTypeColor(contact['type']);
    return Container(
       decoration: BoxDecoration(
         boxShadow: [
                    BoxShadow(
                      color: Colors.grey[500],
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
       ),
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      // padding: EdgeInsets.all(10),
      // height: 230,
      // color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColoredBox(
            color: Colors.orange[100],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.orange,
                    size: 30,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    contact['name'],
                     
                    style:  GoogleFonts.openSans(
                      textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),),
                  ),
                
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Flexible(
              child: Row(
                
                children: [
                 Text('Description: ',
                 style: TextStyle(
                      fontSize: 16,
                      color: Colors.pink[200],
                      fontWeight: FontWeight.w600,
                    ),
                 ),
                  // SizedBox(
                  //   width: 6,
                  // ),
                ],
              ),
            ),
          ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        contact['description'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
           ),
      
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(
                  Icons.location_pin,
                  color: Colors.red[300],
                  size: 25,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  contact['location'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(
                  Icons.phone_iphone,
                  color: Colors.red[300],
                  size: 25,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  contact['number'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.group_work,
                  color: typeColor,
                  size: 25,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  contact['type'],
                  style: TextStyle(
                    fontSize: 16,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (_) => EditFeed(
          //                       contactKey: contact['key'],
          //                     )));
          //       },
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.edit,
          //             color: Theme.of(context).primaryColor,
          //           ),
          //           SizedBox(width: 16),
          //           Text(
          //             'Edit',
          //             style: TextStyle(
          //               fontSize: 16,
          //               color: Colors.red,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //     SizedBox(
          //       width: 20,
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         _showDeleteDailog(contact: contact);
          //       },
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.delete,
          //             color: Theme.of(context).primaryColor,
          //           ),
          //           SizedBox(width: 16),
          //           Text(
          //             'Delete',
          //             style: TextStyle(
          //               fontSize: 16,
          //               color: Colors.red,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //     SizedBox(
          //       width: 20,
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  // _showDeleteDailog({Map contact}) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Delete ${contact['name']}'),
  //           content: Text('Are you sure you want to Delete?'),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('Cancel')),
  //             TextButton(
  //                 onPressed: () {
  //                   reference
  //                       .child(contact['key'])
  //                       .remove()
  //                       .whenComplete(() => Navigator.pop(context));
  //                 },
  //                 child: Text('Delete'))
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 50,
        ),
        backgroundColor: Colors.orange[600],
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            contact['key'] = snapshot.key;
            return _buildContactItem(contact: contact);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Upload()));
        },
        label: Text('Upload'),
        
        icon: Icon(Icons.file_upload),
        backgroundColor: Colors.orange[500],
      ),
    );
  }

  Color getTypeColor(String type) {
    Color color = Theme.of(context).accentColor;

    if (type == 'Donation') {
      color = Colors.green;
    }
    if (type == 'Request') {
      color = Colors.orange;
    }
    return color;
  }
}
