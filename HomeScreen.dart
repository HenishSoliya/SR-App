import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'MyDrawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var load=false;
  String name="";
  String sname="Home Screen";
  @override
  void initState() {
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sname),),
      drawer: MyDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[200],
        child: (load)?Center(child: CircularProgressIndicator(color: Colors.black,))
        :Column(
          children: [
            Spacer(flex: 1,),
            Align(
              alignment: Alignment.topLeft,
              child: Text(" Welcome back ${name}",style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold
              ),)),
            Container(
              width: double.infinity,
              height: 500,
              child: Image.asset("assets/images/home.png"),),
              Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }
  Future loading()
  async {
    load=true;
    setState(() {});
    try{
    var data=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Info").get();
    name=data.get("User Name");
    sname=data.get("Shop Name");
    }catch(e){
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