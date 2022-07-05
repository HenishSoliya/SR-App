import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_retailer_application/MyDrawer.dart';
import '../data.dart';
import 'package:connectivity/connectivity.dart';

class Alert extends StatefulWidget {
  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  var load=false;
  List<Widget> children1=[],children2=[];
  @override
  void initState() {
    super.initState();
    getDocs();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      drawer: MyDrawer(),
        appBar:AppBar(
          actions: [
            InkWell(child: Icon(Icons.settings),
            onTap: (){
              Navigator.pushNamed(context, "alertset");
            },)
          ],
          title: Text("Alert"),centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(child: Text("Exp. Date",style: TextStyle(fontSize: 15),)),
            Tab(child: Text("Stock",style: TextStyle(fontSize: 15)))
          ],),
          ),
        body: TabBarView(
          children: [
            Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue[100],
            child:
            (load)?Center(child: CircularProgressIndicator(color: Colors.black,))
            :SingleChildScrollView(child: Column(children: children1,))
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue[100],
            child:
            (load)?Center(child: CircularProgressIndicator(color: Colors.black,))
            :SingleChildScrollView(child: Column(children: children2,))
          ),
          ]
        ),
      ),
    );
  }

  mycontainer(String n,int d,int i,String key,var o,int index)
  {
      return InkWell(
        onTap: (){
          Data d=Data.getinstance();
          d.setData(n, o,index);
          Navigator.pushNamed(context, "info");
        },
        child: Container(
          child: ListTile(
            subtitle: Row(children: [
                Text("Price : "+o["price"].toString(),),
                Spacer(flex: 1,),
                Text("Exp. : "+o["exp"].toString()),
                Spacer(flex: 1,),
            ],),
            leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  child: Text(i.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
            title:(key=="exp")?
                    Text(n+" is Expired in "+d.toString()+" Days.",style: TextStyle(fontSize: 20),):
                    Text(n+" : Only "+d.toString()+" left in stock.",style: TextStyle(fontSize: 20),),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ),
          decoration: BoxDecoration(
            color: Colors.red[50],
            border: Border(bottom: BorderSide(color: Colors.black))
            ),
            ),
      );
  }

  int exp(var d)
  {
    var today = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
    var expdate=DateTime(d["y"],d["m"],d["d"]);
    var difference = expdate.difference(today);
    return difference.inDays;
  }

  Future getDocs() async {
    load=true;
    setState(() {});
    try{
      var data = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock").get();
      var info = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Info").get();
      var infod=info.get("d");
      var infos=info.get("s");
      var arr=data.get("Arr");
      var n=arr.length;
      var c1=0,c2=0;
      children1.clear();
      children2.clear();
      for(int i=0;i<n;i++)
      {
        var name=arr[i];
        var key=data.get(name);
        for(int j=0;j<key.length;j++)
        {
          var d=exp(key[j]);
          if(d<=infod)
          {
            c1++;
            children1.add(mycontainer(name, d, c1,"exp",key[j],j));
          }
          if(key[j]["qnt"]<=infos)
          {
            c2++;
            children2.add(mycontainer(name, key[j]["qnt"], c2,"stock",key[j],j));
          }
        }
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