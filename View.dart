import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data.dart';

class View extends StatefulWidget {
  @override
  State<View> createState() => _View();
}

class _View extends State<View> {
  var load=false;
  int n=0;
  var data;
  var children=<Widget>[];
  @override
  void initState() {
    super.initState();
    getDocs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [InkWell(
          onTap: (){
            getDocs();
          },
          child: Icon(Icons.refresh)
          )],
        title: Text("Panding Payment"),
      centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[100],
          child: (load)?Center(child: CircularProgressIndicator(color: Colors.black,)):
          SingleChildScrollView(
            child: Column(
            children: children,
                  ),
          ),
      ),
    );
  }

  Widget myContainer(Map<String,dynamic> o)
  {
    return InkWell(
        onTap: (){
          Data.getinstance().setData("", o, 0);
          Navigator.pushNamed(context, "ppp");
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30)
          ),
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
          height: 50,
          child: Center(child: Text(o["name"],
          style: TextStyle(fontSize: 20),
          )),
        )
    );
  }

  Future getDocs() async {
    load=true;
    setState(() {});
    try{
      data = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("PandingPayment").get();
      n=await data.get("length");
      children.clear();
      if(n==0)
      {
        Fluttertoast.showToast(msg: "No Data Found!");
      }
      for(int i=1;i<=n;i++)
      {
       children.add(SizedBox(height: 20,));
       children.add(myContainer(await data.get(i.toString())));
      }
      children.add(SizedBox(height: 20,));
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


class PPPInfo extends StatefulWidget {
  @override
  State<PPPInfo> createState() => _PPPInfo();
}

class _PPPInfo extends State<PPPInfo> {
  var o;
  @override
  void initState() {
    super.initState();
    o=Data.getinstance().getObj();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(o["name"]),centerTitle: true),
      body: Container(
        color: Colors.blue[100],
        width: double.infinity,
        height: double.infinity,
        child: Container(
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
}