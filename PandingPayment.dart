import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_retailer_application/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smart_retailer_application/MyDrawer.dart';

class PandingPayment extends StatefulWidget {
  @override
  State<PandingPayment> createState() => _PandingPayment();
}

class _PandingPayment extends State<PandingPayment> {
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
      drawer: MyDrawer(),
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

  Widget myContainer(int a,Map<String,dynamic> o)
  {
    return Slidable(
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(onPressed: (context){
            deleteStock(a);
          },
          autoClose: true,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          ),
          SlidableAction(onPressed: (context){
            Data.getinstance().setData("", null, a);
            Navigator.pushNamed(context, "ppupdate");
          },
          autoClose: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          icon: Icons.edit,
          ),
          SlidableAction(onPressed: (context)async {
            await launch("tel:"+o["mo"]);
          },
          autoClose: true,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icons.phone,
          ),
          SlidableAction(onPressed: (context){},
          autoClose: true,
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          icon: Icons.cancel,
          )
        ],
      ),
      child: InkWell(
        onTap: (){
          Data.getinstance().setData("", o, a);
          Navigator.pushNamed(context, "ppinfo");
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
        ),
      ),
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
     children.add(myContainer(i,await data.get(i.toString())));
    }
    children.add(SizedBox(height: 20,));
    }catch(e)
    {
      onError();
    }
    load=false;
    setState(() {});
}

void deleteStock(int i)
async {
  load=true;
  setState(() {});
  try{
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
    Timer(Duration(seconds: 1), (){
    getDocs();
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