import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //initialize variables---------------------
  var pass = true, cpass = true;
  var color = Colors.blue[900];
  var e1 = false,e11 = false, e2 = false, e3 = false, e4 = false, e5 = false;
  var process = false;
  final processindicator = CircularProgressIndicator(
    color: Colors.black,
  );
  final c1 = TextEditingController();
  final c11 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();
  final auth = FirebaseAuth.instance;
  final db=FirebaseFirestore.instance;
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
                  "assets/images/welcome.png",
                ),
              ),
              //-----------------------------------------
              SizedBox(
                height: 30,
              ),
              //user name--------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  onTap: () => {e1 = false, setState(() {})},
                  controller: c1,
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e1) ? "Please enter User Name" : null,
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
                    prefixIcon: Icon(Icons.person),
                    hintText: 'User Name',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              //-----------------------------------------

              //Shop Name--------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  onTap: () => {e11 = false, setState(() {})},
                  controller: c11,
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e11) ? "Please enter Shop Name" : null,
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
                    prefixIcon: Icon(Icons.business),
                    hintText: 'Shop Name',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              //-----------------------------------------

              //email------------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  onTap: () => {e2 = false, setState(() {})},
                  controller: c2,
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e2) ? "Please enter Email Address" : null,
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
                  onTap: () => {e3 = false, setState(() {})},
                  controller: c3,
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e3) ? "Please enter Password with Minimum length 6" : null,
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
                    suffixIcon: InkWell(
                      child: Icon(
                        Icons.remove_red_eye,
                        color: (pass) ? Colors.grey : Colors.black,
                      ),
                      onTap: () => {pass = !pass, setState(() {})},
                    ),
                  ),
                  obscureText: pass,
                ),
              ),
              //---------------------------------------------------------

              //confirm password-----------------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  controller: c4,
                  onTap: () => {e4 = false, e5 = false, setState(() {})},
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e4)
                        ? "Please enter Confirm Password"
                        : (e5)
                            ? "Password and Confirm Password does not match!"
                            : null,
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
                    hintText: 'Confirm Password',
                    fillColor: Colors.grey[200],
                    filled: true,
                    suffixIcon: InkWell(
                      child: Icon(
                        Icons.remove_red_eye,
                        color: (cpass) ? Colors.grey : Colors.black,
                      ),
                      onTap: () => {cpass = !cpass, setState(() {})},
                    ),
                  ),
                  obscureText: cpass,
                ),
              ),
              //----------------------------------------------------------------

              //SignUp----------------------------------------------------------
              (process)
                  ? processindicator
                  : InkWell(
                      onTap: () => {
                        color = Colors.black,
                        setState(() {}),
                        Timer(Duration(milliseconds: 300),
                            () => {color = Colors.blue[900], setState(() {})}),
                        if (c1.text == "") {e1 = true},
                        if (c11.text == "") {e11 = true},
                        if (c2.text == "") {e2 = true},
                        if (c3.text == "") {e3 = true},
                        if (c3.text.length<6){e3 = true},
                        if (c4.text == "") {e4 = true},
                        if (c3.text != c4.text) {e5 = true},
                        if (e1 == false &&
                            e11 == false &&
                            e2 == false &&
                            e3 == false &&
                            e4 == false &&
                            e5 == false)
                          {
                            process = true,
                            signUp(c2.text, c3.text),
                          }
                      },
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 300,
                          height: 55,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                            "SignUp",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ))),
                    ),
              //---------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => false);
                        Navigator.pushNamed(context, "login");
                      },
                      child: Text(
                        "Login here",
                        style: TextStyle(color: Colors.blue[900], fontSize: 15),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Map<String,dynamic> createMap(String name,String sn,String email)
  {
    Map<String,dynamic> map={
      "User Name":name,
      "Shop Name":sn,
      "Email":email,
      "d":10,
      "s":10
      };
      return map;
  }

  void signUp(String e, String pass) async {
    User? user;
    await auth
        .createUserWithEmailAndPassword(email: e, password: pass)
        .then((value) async => {
              user = auth.currentUser,
              user?.sendEmailVerification(),
              await db.collection(user!.uid).doc("Info").set(createMap(c1.text, c11.text, c2.text)),
              await db.collection(user!.uid).doc("Growth").set({"length":0}),
              await db.collection(user!.uid).doc("PGrowth").set({"length":0}),
              await db.collection(user!.uid).doc("PandingPayment").set({"length":0}),
              await db.collection(user!.uid).doc("Stock").set({"Arr":[]}),
              Fluttertoast.showToast(msg: "Account Created :)"),
              showDialog(
              barrierDismissible: false,
              context: context,builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        title: Row(
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              color: Colors.blue,
                              size: 50,
                            ),
                            Text("Verify Email Address"),
                          ],
                        ),
                        content: Text(
                            "Email sent in register Email Address, Check it and Verify Email by link"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.popUntil(context, (route) => false);
                                Navigator.pushNamed(context, "login");
                              },
                              child: Text("OK"))
                        ],
                      )),
            })
        .catchError((e) {
      onError(e);
      process = false;
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
