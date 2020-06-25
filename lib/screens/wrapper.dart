import 'package:authentication/models/user.dart';
import 'package:authentication/screens/authenticate/authenticate.dart';
import 'package:authentication/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return either home or authenticate widget
    if(user == null){
      return authenticate();
    }else{
      return Home();
    }
  }
}
