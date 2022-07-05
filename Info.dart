import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data.dart';

class Info extends StatefulWidget {
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  var info;
  String infoname="";
  int infoindex=0;
  var load=false;
  @override
  void initState() {
    super.initState();
    Data d=Data.getinstance();
    info=d.getObj();
    infoname=d.getName();
    infoindex=d.getIndex();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:(load)?Container():Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
          child: Icon(Icons.edit),
          tooltip: "Edit",
          onPressed: (){
            Data d=Data.getinstance();
            d.setData(infoname, null,infoindex);
            Navigator.pushNamed(context, "updatestock");
          }
        ),
        SizedBox(width: 20,),
        FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.delete),
          tooltip: "Delete",
          onPressed: (){
            deleteStock(infoname,infoindex);
          }
        ),
        ],
      ),
      appBar: AppBar(title: Text(infoname),centerTitle: true,),
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
                "Name : ${infoname}""\n""\n"
                "Price : ${info["price"]}""\n""\n"
                "Quantity : ${info["qnt"]}""\n""\n"
                "Manufacturing Date : ${info["mfg"]}""\n""\n"
                "Expiry Date : ${info["exp"]}",
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
  void deleteStock(String name, int i)
  async {
    load=true;
    setState(() {});
  try{
    var data = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock").get();
    var arr=data.get("Arr");
    var o=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock");
    var field=data.get(name);
    field.removeAt(i);
    o.update({name:field});
    if(field.length==0)
    {
      o.update({name:FieldValue.delete()});
      arr.remove(name);
      o.update({"Arr":arr});
    }
    Fluttertoast.showToast(msg: "Delete Successful");
    }catch(e)
    {
      Fluttertoast.showToast(msg: "Delete Fail");
      onError();
    }
  Timer(Duration(seconds: 1), (){
    Navigator.popUntil(context, (route) => false);
    Navigator.pushNamed(context, "stock");
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