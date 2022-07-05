import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPass extends StatefulWidget {
  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  var color=Colors.blue[900];
  final c=TextEditingController();
  var e=false;
  var process=false;
  final processindicator=CircularProgressIndicator(color: Colors.black,);
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue[100],
      //-------------------------------------
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //image------------------------------------
              Container(
                width: double.infinity,
                height: 220,
                child: Image.asset(
                  "assets/images/login.png",
                ),
              ),
              //-----------------------------------------
              SizedBox(height: 30,),
              //email------------------------------------
              Container(
                  width: double.infinity,
                  height: 100,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    onTap: ()=>{
                      e=false,setState((){})
                    },
                    controller: c,
                    decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e)?"Please enter Email Address":null,
                    errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.blue),
                    ),
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Email Address',
                    fillColor: Colors.grey[200],
                    filled: true,
                    ),
                    ),
                ),
              //-----------------------------------------
              //Send reset password link via Email----------------------------------------------------------
                (process)?processindicator:InkWell(
                  onTap: ()=>{
                    color=Colors.black,
                    setState((){}),
                    Timer(Duration(milliseconds: 300), ()=>{
                      color=Colors.blue[900],
                      setState((){})}),
                      if(c.text==""){e=true},
                      if(e==false)
                      {
                        process=true,
                        resetPass(c.text)
                      }
                  },
                  child: AnimatedContainer(
                    duration:Duration(milliseconds: 300),
                    width: 300,
                    height: 55,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                    color:color,
                    borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(child: Text("Send reset password link via Email",
                    style: TextStyle(fontSize: 15,
                    color: Colors.white
                    ),))),
                ),
                //---------------------------------------------------------------
                SizedBox(height: 20,),
                FloatingActionButton(onPressed: (){
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, "login");
                },
                backgroundColor: Colors.blue[900],
                child: Icon(Icons.arrow_back_rounded,
                ),
                )
            ],
          ),
        ),
      ),
    );
  }
  void resetPass(String email)
  async {
    await auth.sendPasswordResetEmail(email: email).then((value) => {
      Fluttertoast.showToast(msg: "Email sent successfully."),
      Navigator.popUntil(context, (route) => false),
      Navigator.pushNamed(context, "login")
    }).catchError((e){
      onError(e);
      process=false;
      setState(() {});
    });
  }
    void onError(e) async{
    var r = await (Connectivity().checkConnectivity());
    if(r==ConnectivityResult.none)
    {
      Fluttertoast.showToast(msg: "Make sure internet connection is active.");
    }
    else
    {
      Fluttertoast.showToast(msg: e.message);
      Fluttertoast.showToast(msg: "Something went wrong, please try again later.");
    }
  }
}