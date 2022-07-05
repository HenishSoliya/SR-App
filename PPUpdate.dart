import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_retailer_application/data.dart';

class PPUpdate extends StatefulWidget {
  @override
  State<PPUpdate> createState() => _PPUpdate();
}

class _PPUpdate extends State<PPUpdate> {
  var i;
  var date;
  var color=Colors.blue[900];
  final processindicator=CircularProgressIndicator(color: Colors.black,);
  var process=false;
  var load=false;
  var data;
  var e1=false,e2=false,e3=false;
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  @override
  void initState() {
    super.initState();
    getandsetDocs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Info"),
        centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[100],
        child: (load)?Center(child: processindicator):SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              //Enter customer Name----------------------------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  controller: c1,
                  onTap: () => {e1 = false, setState(() {})},
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e1) ? "Please enter Customer Name" : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(Icons.text_fields),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Enter Customer Name',
                  ),
                ),
              ),
              //Enter Customer MO.------------------------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  controller: c2,
                  onTap: () => {e2 = false, setState(() {})},
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e2) ? "Please enter valid Customer MO." : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(Icons.phone),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Enter Customer MO.',
                  ),
                ),
              ),
              //Money-------------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  readOnly: true,
                  controller: c3,
                  onTap: () => {e3 = false, setState(() {})},
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e3) ? "" : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(Icons.pin_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Money',
                  ),
                ),
              ),
              //---------------------------------------------------
              (process)?processindicator:InkWell(
                    onTap: ()=>{
                    color=Colors.black,
                    setState((){}),
                    Timer(Duration(milliseconds: 300), ()=>{
                      color=Colors.blue[900],
                      setState((){})}),
                        if (c1.text == "") {e1 = true},
                        if (c2.text == "") {e2 = true},
                        if (c2.text.length!=10) {e2 = true},
                        if (c3.text == "") {e3 = true},
                        if (e1 == false &&
                            e2 == false &&
                            e3 == false)
                          {
                            c1.text=c1.text.toUpperCase(),
                            process = true,
                            updateData()
                          }
                  },
                  child: AnimatedContainer(
                    duration:Duration(milliseconds: 300),
                    width: 200,
                    height: 55,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                    color:color,
                    borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(child: Text("Update",
                    style: TextStyle(fontSize: 30,
                    color: Colors.white
                    ),))),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String,dynamic> createMap()
  {
    Map<String,dynamic> map={
        "name":c1.text,
        "mo":c2.text,
        "pa":int.parse(c3.text),
        "date":date
      };
      return map;
  }

  Future<void> updateData()
  async {
    try{
    await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("PandingPayment").update({
      i.toString():createMap()
    }).then((value) => {
      Fluttertoast.showToast(msg: "Update Successful")
    }).catchError((e){
      Fluttertoast.showToast(msg: "Update Failed");
      Fluttertoast.showToast(msg: e.toString());
    });
    }catch(e)
    {
      onError();
    }
    process = false;
    setState(() {});
    Navigator.popUntil(context, (route) => false);
    Navigator.pushNamed(context, "pp");
  }

    Future getandsetDocs() async {
    load=true;
    setState(() {});
    try{
      i=Data.getinstance().getIndex();
      data = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("PandingPayment").get();
      var data1=data.get(i.toString());
      c1.text=data1["name"].toString();
      c2.text=data1["mo"].toString();
      c3.text=data1["pa"].toString();
      date=data1["date"].toString();
    }catch(e)
    {
      onError();
    }
    load=false;
    setState(() {});
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