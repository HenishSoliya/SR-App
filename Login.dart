import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //initialize variables---------------------
  var pass=true;
  var color=Colors.blue[900];
  var e1=false,e2=false;
  var process=false;
  final processindicator=CircularProgressIndicator(color: Colors.black,);
  final c1=TextEditingController();
  final c2=TextEditingController();
  final auth=FirebaseAuth.instance;
  //-----------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //background---------------------------
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
                      e1=false,setState((){})
                    },
                    controller: c1,
                    decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e1)?"Please enter Email Address":null,
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

              //password---------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  onTap: ()=>{
                      e2=false,setState((){})
                    },
                  controller: c2,
                  decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.blue),
                  ),
                  errorText: (e2)?"Please enter Password":null,
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
                prefixIcon: Icon(Icons.lock),
                hintText: 'Password',
                fillColor: Colors.grey[200],
                filled: true,
                suffixIcon: InkWell(child: Icon(Icons.remove_red_eye,color: (pass)?Colors.grey:Colors.black,),
                  onTap: ()=>{
                    pass=!pass,
                    setState((){})
                  },),
                ),
                obscureText: pass,
                ),
                ),
                //---------------------------------------------------------

                //SignIn----------------------------------------------------------
                (process)?processindicator:InkWell(
                  onTap: ()=>{
                    color=Colors.black,
                    setState((){}),
                    Timer(Duration(milliseconds: 300), ()=>{
                      color=Colors.blue[900],
                      setState((){})}),
                      if(c1.text==""){e1=true},
                      if(c2.text==""){e2=true},
                      if(e1==false && e2==false)
                      {
                        process=true,
                        signIn(c1.text,c2.text),
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
                    child: Center(child: Text("SignIn",
                    style: TextStyle(fontSize: 30,
                    color: Colors.white
                    ),))),
                ),
                //---------------------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not registered yet?",style: TextStyle(fontSize: 15),),
                    TextButton(onPressed: (){
                      Navigator.popUntil(context, (route) => false);
                      Navigator.pushNamed(context,"register");
                    }, child: Text("Click here",style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 15
                    ),))
                  ],
                ),
                //forgotpass-----------------------------------------------------
                TextButton(onPressed: (){
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, "forgotpass");
                },
                child: Text("Forgot password?",style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 15
                    ),))
            //-------------------------------------------------------------------
            ],
          ),
        ),
      ),
    );
  }
  void signIn(String e,String pass)
  async {
    try{
    User? user;
    await auth.signInWithEmailAndPassword(email: e, password: pass).
    then((value) async {
      user=auth.currentUser;
      if(user?.emailVerified==true)
      {
        final p=await SharedPreferences.getInstance();
        p.clear();
        p.setString("Email", e);
        p.setString("Pass", pass);
        Fluttertoast.showToast(msg: "Login Successful.");
        Navigator.popUntil(context, (route) => false);
        Navigator.pushNamed(context, "homescreen");
      }
      else{
        auth.signOut();
        user=null;
        Fluttertoast.showToast(msg: "Email not verified, Verified it first");
        process=false;
        setState(() {});
      }
    });
    }
    catch(e)
    {
      onError(e);
    }
    process=false;
    setState(() {});
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