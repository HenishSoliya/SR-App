import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data.dart';
import 'Piteam.dart';

class ViewListB extends StatefulWidget {
  @override
  State<ViewListB> createState() => _ViewListBState();
}

class _ViewListBState extends State<ViewListB>{
  var view;
  String viewname="";
  int n=0;
  var pi;
  @override
  void initState() {
    super.initState();
    Data d=Data.getinstance();
    pi=Piteam.getinstance();
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
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child:ListView.builder(
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
    return Container(
      child: Row(children: [
        Badge(
          badgeContent: Text(" "+pi.get(viewname,i).toString()+" ",
                style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold
                ),
                ),
          child: InkWell(
            onTap: () {
              if(pi.get(viewname,i)>0)
              {
                pi.remove(viewname,i);
              }
              else
              {
                Fluttertoast.showToast(msg: "Iteam count is already 0");
              }
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.elliptical(100,100),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.elliptical(100,100),
                      )
                  ),
                  padding: EdgeInsets.all(10),
                  child: Center(child: Text("-",
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  )),
                  ),
          ),
        ),
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
              InkWell(
                onTap: () {
                  if(pi.get(viewname,i)<view[i]["qnt"])
                  {
                    pi.add(viewname,i);
                  }
                  else
                  {
                    Fluttertoast.showToast(msg: "Iteam is out of Stock");
                  }
                  setState(() {});
                },
                child: Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(100,100),
                    topRight: Radius.zero,
                    bottomLeft: Radius.elliptical(100,100),
                    bottomRight: Radius.zero,
                    )
                ),
                padding: EdgeInsets.all(10),
                child: Center(child: Text("+",
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                )),
                ),
              ),
      ],),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black))
        ),
        );
    }
}