import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data.dart';

class ViewList extends StatefulWidget {
  @override
  State<ViewList> createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {
  var load=false;
  var view;
  String viewname="";
  int n=0;
  @override
  void initState() {
    super.initState();
    Data d=Data.getinstance();
    view=d.getObj();
    viewname=d.getName();
    n=view.length;
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar:AppBar(title: Text(viewname),centerTitle: true,),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue[100],
        child:(load)?Center(child: CircularProgressIndicator(color: Colors.black,),)
        :ListView.builder(
          itemCount: n,
          itemBuilder: (BuildContext context, int index) {
            return myContainer(index);
          },
        ),
      ),
    );
  }
  myContainer(var i)
  {
    return Slidable(
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(onPressed: (context){
            deleteStock(viewname,i);
          },
          autoClose: true,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          ),
          SlidableAction(onPressed: (context){
            Data d=Data.getinstance();
            d.setData(viewname, null,i);
            Navigator.pushNamed(context, "updatestock");
          },
          autoClose: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          icon: Icons.edit,
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
            Data d=Data.getinstance();
            d.setData(viewname, view[i],i);
            Navigator.pushNamed(context, "info");
        },
        child: Container(
          child: Row(children: [
            Spacer(flex: 1,),
            Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(30)
                  ),
                  height: 50,
                  child: Center(child: Text("Price : "+view[i]["price"].toString(),
                  style: TextStyle(fontSize: 20),
                  )),
                  ),
                  Spacer(flex: 1,),
            Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(30)
                  ),
                  height: 50,
                  child: Center(child: Text("Exp. : "+view[i]["exp"].toString(),
                  style: TextStyle(fontSize: 20),
                  )),
                  ),
                  Spacer(flex: 1,),
          ],),
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.black))
            ),
            ),
      ),
    );
    }

  void deleteStock(String name, int i)
  async {
    load=true;
    setState(() {});
  try{
    var data = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock").get();
    var arr=data.get("Arr");
    var o=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock");
    var field=data.get(name);
    field.removeAt(i);
    o.update({name:field});
    if(field.length==0)
    {
      o.update({name:FieldValue.delete()});
      arr.remove(name);
      o.update({"Arr":arr});
    }
    Fluttertoast.showToast(msg: "Delete Successful");
  }catch(e)
  {
    Fluttertoast.showToast(msg: "Delete Fail");
    onError();
  }
  Timer(Duration(seconds: 1), (){
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