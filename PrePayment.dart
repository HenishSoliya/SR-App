import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_retailer_application/data.dart';

class PrePayment extends StatefulWidget {
  @override
  State<PrePayment> createState() => _PrePaymentState();
}

class _PrePaymentState extends State<PrePayment> {
  var billAmount;
  var pacolor=Colors.blue[900];
  var pa="None";
  var color=Colors.blue[900];
  var enable=false;
  var e1=false,e2=false;
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    Data d=Data.getinstance();
    billAmount=d.getObj();
    c2.text="0";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: (){
          Navigator.pushNamed(context, "view");
        },
        icon: Icon(Icons.person),
        label: Text("View PendingPayment",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
        
        ),
        backgroundColor: Colors.red[200],
      ),
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[100],
        child: SingleChildScrollView(
          child: Column(
            children: [
              //info      1----------------------------
              Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[200]),
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.all(30),
                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bill Amount : ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      billAmount.toString(),
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),),
              ),
              //info      2----------------------------
              Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[200]),
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pending Amount : ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      pa.toString(),
                      style: TextStyle(
                        color: pacolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),),
              ),
              //Received Amount----------------------------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: c1,
                  onTap: () => {enable=false,e1 = false, setState(() {})},
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e1) ? "Please enter valid value" : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Received Amount',
                  ),
                ),
              ),
              //Change------------------------------------------------
              Container(
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: c2,
                  onTap: () => {enable=false,e2 = false, setState(() {})},
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: (e2) ? "Please enter valid value" : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Change',
                  ),
                ),
              ),
              InkWell(
                    onTap: ()=>{
                    color=Colors.black,
                    setState((){}),
                    Timer(Duration(milliseconds: 300), ()=>{
                      color=Colors.blue[900],
                      setState((){})}),
                        if (c1.text == "") {e1 = true},
                        if (c2.text == "") {e2 = true},
                        if (e1 == false &&
                            e2 == false)
                          {
                            calculate()
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
                    child: Center(child: Text("Ok",
                    style: TextStyle(fontSize: 30,
                    color: Colors.white
                    ),))),
                ),
                SizedBox(height: 30,),
                //--------------------------------------------------------
                (enable)?ElevatedButton(onPressed: (){
                  if(int.parse(pa)==0)
                  {
                    Navigator.popUntil(context, (route) => false);
                    Navigator.pushNamed(context, "homescreen");
                  }
                  else{
                  showDialog(
                    barrierDismissible: false,
                    context: context, builder: (_)=>AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        title: Row(
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              color: Colors.blue,
                              size: 50,
                            ),
                            Text("Add Customer Details"),
                          ],
                        ),
                        content: Text(
                            "Pending Amount is not Zero so Add Customer Details."),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Data.getinstance().setData("", pa, 0);
                                Navigator.popUntil(context, (route) => false);
                                Navigator.pushNamed(context, "payment");
                              },
                              child: Text("OK"))
                        ],
                  ));}
                },
                child: Container(
                  width: 150,
                  height: 55,
                  alignment: Alignment.center,
                  child: Text("Next",
                  style: TextStyle(fontSize: 30,
                      color: Colors.white
                      )),
                ),
                ):Container()
            ],
          ),
        ),
      ),
    );
  }

  void calculate()
  {
    var recive=int.parse(c1.text);
    var give=int.parse(c2.text);
    var c=recive-billAmount-give;
    pa=c.toString();
    if(c<0)
    {
      pacolor=Colors.red;
    }
    else if(0<c)
    {
      pacolor=Colors.green;
    }
    else{
      pacolor=Colors.blue[900];
    }
    enable=true;
    setState(() {});
  }
}