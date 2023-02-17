import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Icon(CupertinoIcons.profile_circled,size: 90,),),
          Text("USER NAME:ANJAR"),
          Text("Registered On:27/07/22"),
          ElevatedButton(onPressed: (){}, child: Text("Logout"))
        ],
      ),
    );
  }
}
