import 'dart:async';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_retailer_application/MyDrawer.dart';
import 'package:smart_retailer_application/data.dart';
import 'Piteam.dart';

class Bill extends StatefulWidget {
  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill>{
  var load=false;
  var data,arr,n,pi;
  num total=0;

  @override
  void initState() {
    super.initState();
    getDocs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Badge(
        badgeColor: Color(0xFFD32F2F),
        badgeContent: Text(" "+total.toString()+" ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
            ),
        child: FloatingActionButton(onPressed: ()
        {
          Navigator.pushNamed(context, "cart");
        },
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.shopping_cart),),
      ),
      appBar: AppBar(
        actions: [InkWell(
          onTap: (){
            getDocs();
          },
          child: Icon(Icons.refresh)
          )],
        title: Text("Generate Bills"),
      centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[100],
          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: (load)?Center(child: CircularProgressIndicator(color: Colors.black,)):
          ListView.builder(
            itemCount: n,
            itemBuilder: (BuildContext context, int index) {
              return myContainer(arr[index]);
            },
          ),
      ),
    );
  }

  Widget myContainer(String name)
  {
    return InkWell(
        onTap: () async {
          Data d=Data.getinstance();
          d.setData(name, data.get(name),0);
          await Navigator.pushNamed(context, "viewlistb");
          total=await pi.total();
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30)
          ),
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(50, 20, 50, 0),
          height: 50,
          child: Badge(
                badgeColor: (pi.getn(name).toString()=="0")?Colors.black:Color(0xFF388E3C),
                badgeContent: Text(" "+pi.getn(name).toString()+" ",
                style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold
                ),
                ),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              child: Text(name,
              style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      );
  }

  Future getDocs() async {
    load=true;
    setState(() {});
    try{
      data = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock").get();
      arr=data.get("Arr");
      n=arr.length;
      pi=Piteam.getinstance();
      pi.clean();
      if(n==0)
      {
      Fluttertoast.showToast(msg: "No Data Found!");
      }
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