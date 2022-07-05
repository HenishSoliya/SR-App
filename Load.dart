import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Load extends StatelessWidget {
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    check(context);
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
  void check(BuildContext context)
  async {
  try{
    final p=await SharedPreferences.getInstance();
    if(p.getString("Email")==null && p.getString("Pass")==null)
    {
      Navigator.popUntil(context, (route) => false);
      Navigator.pushNamed(context, "register");
    }
    else
    {
      await auth.signInWithEmailAndPassword(email: p.getString("Email").toString(), password: p.getString("Pass").toString()).
      then((value) {
      Fluttertoast.showToast(msg: "Auto Login Successful.");
      Navigator.popUntil(context, (route) => false);
      Navigator.pushNamed(context, "homescreen");
    }).catchError((e){
      onError();
      Navigator.popUntil(context, (route) => false);
      Navigator.pushNamed(context, "register");
    });
    }
  }catch(e)
  {
    onError();
    Navigator.popUntil(context, (route) => false);
    Navigator.pushNamed(context, "register");
  }
}
  void onError() async{
  var r = await (Connectivity().checkConnectivity());
    if(r==ConnectivityResult.none)
    {
      Fluttertoast.showToast(msg: "Make sure internet connection is active.");
    }
    else
    {
      Fluttertoast.showToast(msg: "Something went wrong, please try again later.");
    }
  }
}