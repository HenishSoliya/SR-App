import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GrowthSet extends StatefulWidget {
  @override
  State<GrowthSet> createState() => _GrowthSetState();
}

class _GrowthSetState extends State<GrowthSet> {
  var load=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Settings"),centerTitle: true,),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[100],
          child: (load)?Center(child: CircularProgressIndicator(color: Colors.black,))
          :SingleChildScrollView(child: Column(children: [
            InkWell(
              onTap: () {
                changemonth();
              },
              child: Container(
                decoration: BoxDecoration(border: Border(
                  bottom: BorderSide(color: Colors.black),
                  ),
                  color: Colors.grey[200]
                  ),
                child: ListTile(
                  leading: Icon(Icons.calendar_today,color: Colors.blue[900]),
                  title: Text("Change Month",style: TextStyle(fontSize: 20),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.deepPurple,),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                delete(1);
              },
              child: Container(
                decoration: BoxDecoration(border: Border(
                  bottom: BorderSide(color: Colors.black),
                  ),
                  color: Colors.grey[200]
                  ),
                child: ListTile(
                  leading: Icon(Icons.delete_forever,color: Colors.red),
                  title: Text("Clear current-month Data",style: TextStyle(fontSize: 20),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.deepPurple,),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                delete(2);
              },
              child: Container(
                decoration: BoxDecoration(border: Border(
                  bottom: BorderSide(color: Colors.black),
                  ),
                  color: Colors.grey[200]
                  ),
                child: ListTile(
                  leading: Icon(Icons.delete_forever,color: Colors.red),
                  title: Text("Clear previous-month Data",style: TextStyle(fontSize: 20),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.deepPurple,),
                ),
              ),
            )
          ],)),
        )
    );
  }

  void delete(d)
  async {
  load=true;
  setState(() {});
  try{
  if(d==1)
  {
    await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Growth").set({"length":0});
    Fluttertoast.showToast(msg: "Clear current-month Data Successful");
  }
  else
  {
    await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("PGrowth").set({"length":0});
    Fluttertoast.showToast(msg: "Clear previous-month Data Successful");
  }
  }catch(e)
  {
    onError();
  }
  load=false;
  setState(() {});
  Navigator.popUntil(context, (route) => false);
  Navigator.pushNamed(context, "growth");
  }

  void changemonth()
  async {
  load=true;
  setState(() {});
  try{
  var cm=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Growth").get();
  var pm=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("PGrowth");
  var n=cm.get("length");
  pm.set({"length":n});
  for(int i=1;i<=n;i++)
  {
    var map=cm.get(i.toString());
    pm.update({i.toString():map});
  }
  await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Growth").set({"length":0});
  Fluttertoast.showToast(msg: "Change Month Successful");
  }
  catch(e)
  {
    onError();
  }
  load=false;
  setState(() {});
  Navigator.popUntil(context, (route) => false);
  Navigator.pushNamed(context, "growth");
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