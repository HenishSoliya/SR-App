import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data.dart';

class PPInfo extends StatefulWidget {
  @override
  State<PPInfo> createState() => _PPInfo();
}

class _PPInfo extends State<PPInfo> {
  var i,o;
  var load=false;
  @override
  void initState() {
    super.initState();
    i=Data.getinstance().getIndex();
    o=Data.getinstance().getObj();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:(load)?Container():
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
          child: Icon(Icons.edit),
          tooltip: "Edit",
          onPressed: (){
            Data.getinstance().setData("", null, i);
            Navigator.pushNamed(context, "ppupdate");
          }
        ),
        SizedBox(width: 20,),
        FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.delete),
          tooltip: "Delete",
          onPressed: (){
            deleteStock(i);
          }
        ),
        ],
      ),
      appBar: AppBar(title: Text(o["name"]),centerTitle: true,actions: [InkWell(child: Icon(Icons.phone),
      onTap: () async {
        await launch("tel:"+o["mo"]);
      },)],),
      body: Container(
        color: Colors.blue[100],
        width: double.infinity,
        height: double.infinity,
        child: (load)?Center(child: CircularProgressIndicator(color: Colors.black,)):Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.fromLTRB(30, 30, 30, 100),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30)
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Text(
                "Name : ${o["name"]}""\n""\n"
                "Pending Amount : ${o["pa"]}""\n""\n"
                "MO. : ${o["mo"]}""\n""\n"
                "Date : ${o["date"]}",
                style: TextStyle(
                  fontSize: 20
                ),
                ),
            ),
          ),
        ),
      ),
    );
  }
 void deleteStock(int i)
  async {
    load=true;
    setState(() {});
  try{
    var data = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("PandingPayment").get();
    var n=await data.get("length");
    var map;
    var o=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("PandingPayment");
    if(n==1)
    {
      o.set({"length":0}).then((value) => {
        Fluttertoast.showToast(msg: "Delete Successful")
      });
    }
    else if(i==n)
    {
      o.update({
        n.toString():FieldValue.delete()
      }).then((value) => {
        n--,
        o.update({
        "length":n
      }).then((value) => {
        Fluttertoast.showToast(msg: "Delete Successful")
      })
      });
    }
    else{
      map=await data.get(n.toString());
      o.update({
        i.toString():map
      }).then((value) => {
        o.update({
        n.toString():FieldValue.delete()
      }).then((value) => {
        n--,
        o.update({
        "length":n
      }).then((value) => {
        Fluttertoast.showToast(msg: "Delete Successful")
      })
      })
      });
    }
  }catch(e)
  {
    Fluttertoast.showToast(msg: "Delete Fail");
    onError();
  }
  load=false;
  setState(() {});
  Timer(Duration(seconds: 1), (){
    Navigator.popUntil(context, (route) => false);
    Navigator.pushNamed(context, "pp");
  });
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