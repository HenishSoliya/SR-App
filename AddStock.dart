import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddStock extends StatefulWidget {
  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  int d=0,m=0,y=0;
  var data,sdata;
  String mdate="";
  String edate="";
  var color=Colors.blue[900];
  final processindicator=CircularProgressIndicator(color: Colors.black,);
  var process=false;
  var e1=false,e2=false,e3=false,e4=false,e5=false;
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();
  final c5 = TextEditingController();
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Stock"),
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
              //Enter Product Name----------------------------------------------------
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
                    errorText: (e1) ? "Please enter Product Name" : null,
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
                    hintText: 'Enter Product Name',
                  ),
                ),
              ),
              //Enter Price------------------------------------------------
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
                    errorText: (e2) ? "Please enter Price" : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(Icons.money),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Enter Price',
                  ),
                ),
              ),
              //Enter Quantity-------------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: c3,
                  onTap: () => {e3 = false, setState(() {})},
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e3) ? "Please enter Quantity" : null,
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
                    hintText: 'Enter Quantity',
                  ),
                ),
              ),
              
              //Manufacturing Date-----------------------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  readOnly: true,
                  controller: c4,
                  onTap: () => {
                    e4 = false, setState(() {}),
                    mdate="",
                    showCupertinoModalPopup<void>(
                      barrierDismissible: false,
                      builder: (BuildContext context) { 
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                                height: 200,
                                width: double.infinity,
                                margin: EdgeInsets.all(20),
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(30),
                                  color: Colors.white
                                ),
                                child: Column(
                                children:[
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: DateTime.now(),
                                    maximumDate: DateTime.now(),
                                    dateOrder: DatePickerDateOrder.dmy,
                                    onDateTimeChanged: (DateTime value) {
                                      mdate=value.day.toString()+"/"+value.month.toString()+"/"+value.year.toString();
                                    },),
                                ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("CANCLE",style: TextStyle(color: Colors.black),)),
                                    TextButton(onPressed: (){
                                      if(mdate=="")
                                      {
                                        mdate=DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString();
                                      }
                                      c4.text=mdate;
                                      setState(() {});
                                      Navigator.pop(context);
                                    }, child: Text("OK",style: TextStyle(color: Colors.black),)),
                                    SizedBox(width: 20,)
                                  ],)
                                ]
                                ) 
                          ),
                        );
                       }, 
                      context: context,
                    ),
                    },
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e4) ? "Please enter Manufacturing Date" : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Enter Manufacturing Date',
                  ),
                ),
              ),
              //Expiry Date---------------------------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  readOnly: true,
                  controller: c5,
                  onTap: () => {e5 = false, setState(() {}),
                    edate="",
                    showCupertinoModalPopup<void>(
                      barrierDismissible: false,
                      builder: (BuildContext context) { 
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                                height: 200,
                                width: double.infinity,
                                margin: EdgeInsets.all(20),
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(30),
                                  color: Colors.white
                                ),
                                child: Column(
                                children:[
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    minimumDate: DateTime.now(),
                                    dateOrder: DatePickerDateOrder.dmy,
                                    onDateTimeChanged: (DateTime value) {
                                      d=value.day;
                                      m=value.month;
                                      y=value.year;
                                      edate=d.toString()+"/"+m.toString()+"/"+y.toString();
                                    },),
                                ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("CANCLE",style: TextStyle(color: Colors.black),)),
                                    TextButton(onPressed: (){
                                      if(edate=="")
                                      {
                                        var value=DateTime.now();
                                        d=value.day;
                                        m=value.month;
                                        y=value.year;
                                        edate=d.toString()+"/"+m.toString()+"/"+y.toString();
                                      }
                                      c5.text=edate;
                                      setState(() {});
                                      Navigator.pop(context);
                                    }, child: Text("OK",style: TextStyle(color: Colors.black),)),
                                    SizedBox(width: 20,)
                                  ],)
                                ]
                                ) 
                          ),
                        );
                       }, 
                      context: context,
                    )
                  },
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e5) ? "Please enter Expiry Date" : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Enter Expiry Date',
                  ),
                ),
              ),
              //---------------------------------------------------
              (process)?processindicator:InkWell(
                    onTap: ()=>{
                    color=Colors.black,
                    setState((){}),
                    Timer(Duration(milliseconds: 300), ()=>{
                      color=Colors.blue[900],
                      setState((){})}),
                        if (c1.text == "") {e1 = true},
                        if (c2.text == "") {e2 = true},
                        if (c3.text == "") {e3 = true},
                        if (c4.text == "") {e4 = true},
                        if (c5.text == "") {e5 = true},
                        if (e1 == false &&
                            e2 == false &&
                            e3 == false &&
                            e4 == false &&
                            e5 == false)
                          {
                            c1.text=c1.text.toUpperCase(),
                            process = true,
                            addData()
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

  Map<String,dynamic> createMap()
  {
    Map<String,dynamic> map={
        "price":int.parse(c2.text),
        "qnt":int.parse(c3.text),
        "mfg":c4.text,
        "exp":c5.text,
        "d":d,
        "m":m,
        "y":y
      };
      return map;
  }

  int valid(var d)
  {
    var arr=d.get("Arr");
    var p=false;
    for(int i=0;i<arr.length;i++)
    {
      if(arr[i]==c1.text)
      {
        p=true;
      }
    }
    if(p)
    {
      var key=d.get(c1.text);
      for(int i=0;i<key.length;i++)
      {
        if(key[i]["price"].toString()==c2.text && 
           key[i]["mfg"]==c4.text &&
           key[i]["exp"]==c5.text
        )
        {
          return 0;
        }
      }
    }
    else{
      arr.add(c1.text);
      sdata.update({"Arr":arr});
      return 2;
    }
    return 1;
  }

  void addData()
  async {
    try{
    sdata=await db.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock");
    data=await db.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock").get();
    var v=valid(data);
    if(v==1)
    {
      var arr=data.get(c1.text);
      arr.add(createMap());
      sdata.update({c1.text:arr}).then((value) => {
        Fluttertoast.showToast(msg: "Saved")
      });
    }
    else if(v==2)
    {
      sdata.update({c1.text:[createMap()]}).then((value) => {
        Fluttertoast.showToast(msg: "Saved")
      });
    }
    else
    {
      Fluttertoast.showToast(msg: "Data already exists! Duplicate data not allowed!");
    }
    }catch(e)
    {
      onError();
    }
    Timer(Duration(seconds: 1), (){
      process = false;
      setState(() {});
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