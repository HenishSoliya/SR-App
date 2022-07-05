import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_retailer_application/MyDrawer.dart';
import '../data.dart';

class Stock extends StatefulWidget {
  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  var enable=false;
  final c1=TextEditingController();
  var load = false;
  var data, arr;
  var children = <Widget>[];
  @override
  void initState() {
    super.initState();
    getDocs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () {
                if(enable)
                {
                  setchildren();
                  enable=!enable;
                  setState(() {});
                }
                else
                {
                  children.clear();
                  children.add(SizedBox( height: 20,));
                  children.add(searchbox());
                  enable=!enable;
                  setState(() {});
                }
              },
              child: Icon(Icons.search,color: (enable)?Colors.black:Colors.white,)),
          SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () {
                getDocs();
              },
              child: Icon(Icons.refresh))
        ],
        title: Text("Stock Management"),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "addstock");
        },
        child: Icon(Icons.add),
        tooltip: "Add",
      ),
      body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue[100],
              child: (load)? Center(
                      child: CircularProgressIndicator(
                      color: Colors.black,
                    ))
                  : SingleChildScrollView(child: Column(children: children,))
            )
    );
  }

  Widget myContainer(String name) {
    return InkWell(
      onTap: () {
        Data d = Data.getinstance();
        d.setData(name, data.get(name), 0);
        Navigator.pushNamed(context, "viewlist");
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
        height: 50,
        child: Center(
            child: Text(
          name,
          style: TextStyle(fontSize: 20),
        )),
      ),
    );
  }

  Future getDocs() async {
    load = true;
    setState(() {});
    try {
      data = await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc("Stock")
          .get();
      arr = data.get("Arr");
      setchildren();
    } catch (e) {
      onError();
    }
    load = false;
    setState(() {});
  }

  setchildren(){
    children.clear();
    var n = arr.length;
      if (n == 0) {
        Fluttertoast.showToast(msg: "No Data Found!");
      }
      for (int i = 0; i < n; i++) {
        children.add(SizedBox(height: 20,));
        children.add(myContainer(arr[i]));
      }
      children.add(SizedBox( height: 20, ));
  }

  Widget searchbox() {
    return TextField(
      controller: c1,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        prefixIcon: InkWell(child: Icon(Icons.arrow_back),
        onTap: ()async{
          setchildren();
          enable=!enable;
          setState(() {});
        },
        ),
        suffixIcon: InkWell(
          onTap: (){
            children.clear();
            children.add(SizedBox( height: 20,));
            children.add(searchbox());
            var key = c1.text.toUpperCase();
            for (int i = 0; i < arr.length; i++) {
            if (arr[i].startsWith(key, 0)) {
            children.add(SizedBox(height: 20,));
            children.add(myContainer(arr[i]));
            }
          }
          c1.text="";
          setState(() {});
          },
          child: Icon(Icons.search)
          ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.blue),
        ),
        hintText: 'Search',
      ),
    );
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