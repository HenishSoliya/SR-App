import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_retailer_application/Bills/Piteam.dart';
import 'package:smart_retailer_application/data.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var children=<Widget>[];
  var load=false;
  int qnt=0;
  int price=0;
  var pi;
  @override
  void initState() {
    super.initState();
    loading();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:(load)?Container():
      FloatingActionButton.extended(
        onPressed: (){
          update();
        },
        icon: Icon(Icons.update),
        label: Text("Update Data",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
        
        ),
        backgroundColor: Colors.red[200],
      ),
      appBar: AppBar(
        title: Text("Generate Bills"),
      centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[100],
          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: (load)?Center(child: CircularProgressIndicator(color: Colors.black,))
          :SingleChildScrollView(child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: children,),
          ),),
          ),
    );
  }

  void update()
  async{
    load=true;
    setState(() {});
    try{
    var set=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock");
    var setgro=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Growth");
    for (var item in pi.list) {
      var db=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock").get();
      var gro=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Growth").get();
      var name=item.split("%")[0];
      var index=int.parse(item.split("%")[1]);
      var q=pi.get(name, index);
      var field=db.get(name);
      var map=field[index];
      bool present=false;
      if(q!=0)
      {
      for(int i=1;i<=gro.get("length");i++)
      {
        var gmap=gro.get(i.toString());
        if(gmap["name"]==name && gmap["price"]==map["price"])
        {
          present=true;
          gmap["sell"]=gmap["sell"]+q;
          setgro.update({i.toString():gmap});
        }
      }
      if(!present)
        {
          var l=gro.get("length");
          l++;
          setgro.update({l.toString():{
            "name":name,
            "price":map["price"],
            "sell":q
          }}).then((value) => {setgro.update({"length":l})});
        }
      map["qnt"]=map["qnt"]-q;
      field[index]=map;
      set.update({name:field});
      }
    }
      pi.clean();
      Data.getinstance().setData("", price, 0);
      Navigator.popUntil(context, (route) => false);
      Navigator.pushNamed(context, "prepayment");
    }catch(e){
      onError();
    }
  }

  void Containermaker(String name,int qn,int pr)
  {
    final style=TextStyle(
    fontSize: 20,
    );
    children.add(
          Row(children: [
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
        ],),
    );
    price=price+(qn*pr);
    qnt=qnt+qn;
  }

  void heading()
  {
    final hstyle=TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold
    );
    children.add(
          Row(children: [
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
            child: Text("Quantity",style: hstyle,),
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
        ],),
    );
  }

  void total()
  {
    final hstyle=TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold
    );
    children.add(
          Row(children: [
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
            child: Text(qnt.toString(),style: hstyle,),
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
            child: Text(price.toString(),style: hstyle,)
            ),
        ],),
    );
  }

  Future loading()
  async{
    load=true;
    setState(() {});
    try{
    var db=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Stock").get();
    pi=Piteam.getinstance();
    children.clear();
    children.add(SizedBox(height: 20,));
    heading();
    for (var item in pi.list) {
      var name=item.split("%")[0];
      var index=int.parse(item.split("%")[1]);
      var p=db.get(name)[index]["price"];
      var q=pi.get(name, index);
      if(q!=0)
      {
        Containermaker(name, q, p);
      }}
      total();
      children.add(SizedBox(height: 20,));
    }
    catch(e)
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