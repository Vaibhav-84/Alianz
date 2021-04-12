import 'package:flutter/material.dart';
import 'package:zero_hunger/helper/authenticate.dart';
import 'package:zero_hunger/services/auth.dart';
import 'package:zero_hunger/views/feed.dart';
import 'package:zero_hunger/views/request_feed.dart';
import 'package:zero_hunger/views/upload.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthMethods authMethods = new AuthMethods();

  int _cIndex = 0;

final List<Widget> _children = [
    DisplayFeed(),
    DisplayRequestFeed(),
    
  ];

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _children[_cIndex],







      
       bottomNavigationBar:BottomNavigationBar(
        currentIndex: _cIndex,
        type: BottomNavigationBarType.shifting ,
        items: const<BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.hail,
            color: Colors.orange),
            title: Text('Donations',
             style: TextStyle(color: Colors.grey),))
          ,
          
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page,
            color: Colors.orange),
            title:  Text('Requests',
            style: TextStyle(color: Colors.grey),)
          )
        ],
        
        onTap: (index){
            _incrementTab(index);
        },
        backgroundColor: Colors.grey[200],
      ),
      
    );
  }
}
