import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_retailer_application/data.dart';

class UpdateStock extends StatefulWidget {
  @override
  State<UpdateStock> createState() => _UpdateStockState();
}

class _UpdateStockState extends State<UpdateStock> {
  var oname,oprice,oqnt,omfg,oexp;
  var sdata,data;
  String uname="";
  int uindex=0;
  int d=0,m=0,y=0;
  String mdate="";
  String edate="";
  var color=Colors.blue[900];
  final processindicator=CircularProgressIndicator(color: Colors.black,);
  var process=false,load=false;
  var e1=false,e2=false,e3=false,e4=false,e5=false;
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();
  final c5 = TextEditingController();
  @override
  void initState() {
    super.initState();
    setData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Stock"),
        centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[100],
        child: (load)?Center(child: processindicator)
        :SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              //Enter Product Name----------------------------------------------------
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Text(oname,style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]
                    ),)),
              ),
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
                    suffixIcon: InkWell(
                      child: Icon(Icons.downloading),
                      onTap: () {
                        c1.text=oname;
                      },
                      ),
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Text(oprice,style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]
                    ),)),
              ),
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
                    suffixIcon: InkWell(
                      child: Icon(Icons.downloading),
                      onTap: () {
                        c2.text=oprice;
                      },
                      ),
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Text(oqnt,style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]
                    ),)),
              ),
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
                    suffixIcon: InkWell(
                      child: Icon(Icons.downloading),
                      onTap: () {
                        c3.text=oqnt;
                      },
                      ),
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Text(omfg,style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]
                    ),)),
              ),
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
                    suffixIcon: InkWell(
                      child: Icon(Icons.downloading),
                      onTap: () {
                        c4.text=omfg;
                      },
                      ),
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Text(oexp,style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]
                    ),)),
              ),
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
                    suffixIcon: InkWell(
                      child: Icon(Icons.downloading),
                      onTap: () {
                        c5.text=oexp;
                      },
                      ),
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
              (process)?CircularProgressIndicator(color: Colors.black,)
              :InkWell(
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
                            updateData()
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
                    child: Center(child: Text("Update",
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

  Future setData()
  async {
    load=true;
    setState(() {});
    try{
    sdata=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock");
    data=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock").get();
    Data di=Data.getinstance();
    uindex=di.getIndex();
    uname=di.getName();
    var old=data.get(uname)[uindex];
    oname=uname;
    oprice=old["price"].toString();
    oqnt=old["qnt"].toString();
    omfg=old["mfg"];
    oexp=old["exp"];
    d=old["d"];
    m=old["m"];
    y=old["y"];
    }
    catch(e)
    {
      onError();
    }
    load=false;
    setState(() {});
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
        if(i==uindex && c1.text==uname)
        {
          continue;
        }
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

  void updateData()
  async {
    try{
    sdata=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock");
    data=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock").get();
    var v=valid(data);
    if(v==1)
    {
      var arr=data.get(c1.text);
      arr.add(createMap());
      sdata.update({c1.text:arr}).then((value) => {
        Timer(Duration(seconds: 1),(){deleteStock();})
      });
      
    }
    else if(v==2)
    {
      sdata.update({c1.text:[createMap()]}).then((value) => {
        Timer(Duration(seconds: 1),(){deleteStock();})
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
    process = false;
    setState(() {});
  }


  void deleteStock()
  async {
  try{
    sdata=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock");
    data=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock").get();
    var arr=data.get("Arr");
    var field=data.get(uname);
    field.removeAt(uindex);
    sdata.update({uname:field});
    if(field.length==0)
    {
      sdata.update({uname:FieldValue.delete()});
      arr.remove(uname);
      sdata.update({"Arr":arr});
    }
    Fluttertoast.showToast(msg: "Update Successful");
     Timer(Duration(seconds: 1), (){
      process = false;
      setState(() {});
      Navigator.popUntil(context, (route) => false);
      Navigator.pushNamed(context, "stock");
    });
  }catch(e)
  {
    onError();
  }
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