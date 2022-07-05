import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlertSet extends StatefulWidget {
  @override
  State<AlertSet> createState() => _AlertSetState();
}

class _AlertSetState extends State<AlertSet> {
  var stock,day;
  var process=false;
  var load=false;
  var processindicator=CircularProgressIndicator(color: Colors.black,);
  final c1=TextEditingController();
  final c2=TextEditingController();
  var e1=false, e2=false;
  var color=Colors.blue[900];
  @override
  void initState() {
    super.initState();
    loaddata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Settings"),centerTitle: true,),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[100],
          padding: EdgeInsets.all(20),
          child: (load)?Center(child: processindicator)
          :SingleChildScrollView(child: Column(children: [
            //set days--------------------------------------------------------
            Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: c1,
                  onTap: () => {e1 = false, setState(() {})},
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e1) ? "Please enter valid value" : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(Icons.pin_outlined),
                    suffixIcon: InkWell(
                      onTap: (){
                        c1.text=day;
                      },
                      child: Icon(Icons.downloading)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Enter Days',
                  ),
                ),
              ),
            //---------------------------------------------------------------
            SizedBox(height: 20,),
            //set stock----------------------------------------------------------------
            Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: c2,
                  onTap: () => {e2 = false, setState(() {})},
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e2) ? "Please enter valid value" : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(Icons.pin_outlined),
                    suffixIcon: InkWell(
                      onTap: (){
                        c2.text=stock;
                      },
                      child: Icon(Icons.downloading)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Enter Stock',
                  ),
                ),
              ),
            SizedBox(height: 20,),
            //----------------------------------------------------------------
            (process)?processindicator:InkWell(
                    onTap: ()=>{
                    color=Colors.black,
                    setState((){}),
                    Timer(Duration(milliseconds: 300), ()=>{
                      color=Colors.blue[900],
                      setState((){})}),
                        if (c1.text == "") {e1 = true},
                        if (c2.text == "") {e2 = true},
                        if (e1 == false &&
                            e2 == false)
                          {
                            process=true,
                            setdata()
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
                    child: Center(child: Text("Set",
                    style: TextStyle(fontSize: 30,
                    color: Colors.white
                    ),))),
                ),
          ],
          )
          ),
        )
    );
  }

  loaddata()
  async {
    load=true;
    setState(() {});
    try
      {
        var db=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Info").get();
        stock=db.get("s").toString();
        day=db.get("d").toString();
      }catch(e)
      {
        onError();
      }
    load=false;
    setState(() {});
  }

  void setdata()
  async {
    process=true;
    setState(() {});
    if(int.parse(c1.text)<=28 && int.parse(c2.text)<=28 && int.parse(c1.text)>=5 && int.parse(c2.text)>=5)
    {
      try
      {
        var db=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Info");
        db.update({"d":int.parse(c1.text),"s":int.parse(c2.text)});
        Fluttertoast.showToast(msg: "Set data successful.");
        Navigator.popUntil(context, (route) => false);
        Navigator.pushNamed(context, "alert");
      }catch(e)
      {
        onError();
      }
    }
    else
    {
      Fluttertoast.showToast(msg: "Value must be in range of 5-28.");
    }
    process=false;
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