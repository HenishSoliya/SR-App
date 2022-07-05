import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_retailer_application/data.dart';


class Payment extends StatefulWidget {
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var money;
  var color=Colors.blue[900];
  final processindicator=CircularProgressIndicator(color: Colors.black,);
  var process=false;
  var e1=false,e2=false,e3=false;
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  @override
  void initState() {
    super.initState();
    money=Data.getinstance().getObj();
    c3.text=money.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[100],
        child: SingleChildScrollView(
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
                  keyboardType: TextInputType.phone,
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
              //-------------------------------------------------
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
                            addpandingpayment()
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
                    child: Center(child: Text("Add",
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

  Map<String,dynamic> createMap(String i)
  {
    var y=DateTime.now().year;
    var m=DateTime.now().month;
    var d=DateTime.now().day;
    var s="/";
    var date=d.toString()+s+m.toString()+s+y.toString();
    Map<String,dynamic> map={
        "name":c1.text,
        "mo":c2.text,
        "pa":int.parse(c3.text),
        "date":date,
      };
      map={
        i:map
      };
      return map;
  }


  Future<void> addpandingpayment()
  async {
    try{
    var sdata=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("PandingPayment");
    var data=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("PandingPayment").get();
    var n=data.get("length");
    n++;
    sdata.update(createMap(n.toString())).then((value) => {
      sdata.update({
        "length":n
      }),
      Fluttertoast.showToast(msg: "Saved")
    });
    }catch(e)
    {
      onError();
    }
    process=false;
    setState(() {});
    Navigator.popUntil(context, (route) => false);
    Navigator.pushNamed(context, "homescreen");
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