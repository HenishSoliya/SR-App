import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_retailer_application/MyDrawer.dart';

class Growth extends StatefulWidget {
  @override
  State<Growth> createState() => _Growth();
}

class _Growth extends State<Growth> {
  var load=false;
  var data;
  int n=0;
  var predata;
  int pren=0;
  int sell=0;
  int price=0;
  int priceb=0;
  var children=<Widget>[];
  var prechildren=<Widget>[];
  @override
  void initState() {
    super.initState();
    loading();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, "growthset");
              },
              child: Icon(Icons.settings))],
              bottom: TabBar(tabs: [
            Tab(child: Text("Current month",style: TextStyle(fontSize: 15),)),
            Tab(child: Text("Previous month",style: TextStyle(fontSize: 15)))
          ],),
          title: Text("Growth"),
        centerTitle: true,
        ),
        body: TabBarView(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue[100],
              child: (load)?Center(child: CircularProgressIndicator(color: Colors.black,))
              :SingleChildScrollView(child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: children,),
              ),),
              ),
              Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue[100],
              child: (load)?Center(child: CircularProgressIndicator(color: Colors.black,))
              :SingleChildScrollView(child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: prechildren,),
              ),),
              ),
          ]),
      ),
    );
  }

  Widget Containermaker(String name,int qn,int pr,bool d)
  {
    //d==true then % enable
    final style=TextStyle(
    fontSize: 20,
    );
    price=price+(qn*pr);
    sell=sell+qn;
    return Row(children: [
            //container    1     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            width: 250,
            height: 60,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text(name,style: style,),
            ),
            //container    2     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            width: 120,
            height: 60,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text(qn.toString(),style: style,),
            ),
            //container    3     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            height: 60,
            width: 120,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text(pr.toString(),style: style,)
            ),
            //container     4        
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            height: 60,
            width: 120,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text((qn*pr).toString(),style: style,)
            ),
            (d)?
            //container     5        
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            height: 60,
            width: 120,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: percentage(name, pr, qn)
            )
            :Container()
        ],);
  }

  Widget percentage(String n,int p,int s)
  {
    for(int i=1;i<=pren;i++)
    {
      if(n.compareTo(predata.get(i.toString())["name"])==0)
      {
        if(p==predata.get(i.toString())["price"])
        {
          int temp=predata.get(i.toString())["sell"];
          s=s-temp;
          s=s*100;
          double ans=s/temp;
          String aerrow="↑";
          Color color=Colors.green;
          if(s<0)
          {
            aerrow="↓";
            color=Colors.red;
            ans=ans*(-1);
          }
          return Text(aerrow+ans.toStringAsFixed(2)+"%",style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 20,),);
        }
      }
    }
    return Text("-",style: TextStyle(
            color: Colors.blue[900],
            fontWeight: FontWeight.bold,
            fontSize: 20,),);
  }


  Widget totalPercentage()
  {
    int p=price;
    p=p-priceb;
    p=p*100;
    double ans=p/priceb;
    String aerrow="↑";
    Color color=Colors.green;
    if(p<0)
    {
      aerrow="↓";
      color=Colors.red;
      ans=ans*(-1);
    }
    if(priceb==0)
    {
      return Text("-",
      style: TextStyle(
            color: Colors.blue[900],
            fontWeight: FontWeight.bold,
            fontSize: 20,),);
    }
    return Text(aerrow+ans.toStringAsFixed(2)+"%",
    style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 20,),);
  }

  
  Widget heading(bool d)
  {
    final hstyle=TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold
    );
    return Row(children: [
            //container    1     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            width: 250,
            height: 60,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text("Name",style: hstyle,),
            ),
            //container    2     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            width: 120,
            height: 60,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text("Sell",style: hstyle,),
            ),
            //container    3     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            height: 60,
            width: 120,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text("Price",style: hstyle,)
            ),
            //container    4     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            height: 60,
            width: 120,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text("Total",style: hstyle,)
            ),
            (d)?
            //container    5     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            height: 60,
            width: 120,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text("Growth",style: hstyle,)
            )
            :Container()
        ],);
  }

  Widget total(bool d)
  {
    final hstyle=TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold
    );
    return  Row(children: [
            //container    1     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            width: 250,
            height: 60,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text("Total",style: hstyle,),
            ),
            //container    2     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            width: 120,
            height: 60,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text(sell.toString(),style: hstyle,),
            ),
            //container    3     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            height: 60,
            width: 120,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text("-",style: hstyle,)
            ),
            //container    4     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            height: 60,
            width: 120,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: Text(price.toString(),style: hstyle,)
            ),
            (d)?
            //container    5     
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            height: 60,
            width: 120,
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
            ),
            child: totalPercentage()
            ):Container()
        ],);
  }

  Future loading()
  async{
    load=true;
    setState(() {});
    try{
    data=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Growth").get();
    n=await data.get("length");
    predata=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("PGrowth").get();
    pren=await predata.get("length");
    children.clear();
    prechildren.clear();
    children.add(SizedBox(height: 20,));
    prechildren.add(SizedBox(height: 20,));
    children.add(heading(true));
    prechildren.add(heading(false));
    sell=0;
    price=0;
    for (int i=1;i<=pren;i++) {
      var p= predata.get(i.toString())["price"];
      var n= predata.get(i.toString())["name"];
      var s= predata.get(i.toString())["sell"];
      prechildren.add(Containermaker(n, s, p,false));
    }
    prechildren.add(total(false));
    prechildren.add(SizedBox(height: 20,));
    //--------------------------------------------
    priceb=price;
    sell=0;
    price=0;
    for (int i=1;i<=n;i++) {
      var p= data.get(i.toString())["price"];
      var n= data.get(i.toString())["name"];
      var s= data.get(i.toString())["sell"];
      children.add(Containermaker(n, s, p,true));
    }
    children.add(total(true));
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