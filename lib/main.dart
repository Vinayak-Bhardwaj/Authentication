import 'package:authentication/models/user.dart';
import 'package:authentication/screens/wrapper.dart';
import 'package:authentication/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        //Returns to Wrapper
        home:Wrapper(),
      ),
    );
  }
}
