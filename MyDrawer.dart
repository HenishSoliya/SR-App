import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.blue[50],
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, "homescreen");
                },
                child: Container(
                  child:Image.asset("assets/images/drawer.png"),
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Text("Menu",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30),),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, "stock");
                },
                child: Container(
                  child: Center(child: Text("Stocks",style: TextStyle(fontSize: 20),)),
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[400]),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, "bill");
                },
                child: Container(
                  child: Center(child: Text("Bills",style: TextStyle(fontSize: 20),)),
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[400]),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, "pp");
                },
                child: Container(
                  child: Center(child: Text("Pending Payments",style: TextStyle(fontSize: 20),)),
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[400]),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, "alert");
                },
                child: Container(
                  child: Center(child: Text("Alert",style: TextStyle(fontSize: 20),)),
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[400]),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, "growth");
                },
                child: Container(
                  child: Center(child: Text("Growth",style: TextStyle(fontSize: 20),)),
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[400]),
                ),
              ),
              InkWell(
                onTap: () async {
                  FirebaseAuth.instance.signOut();
                  final p=await SharedPreferences.getInstance();
                  p.clear();
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, "register");
                },
                child: Container(
                  child: Center(child: Text("LogOut",style: TextStyle(fontSize: 20),)),
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[400]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}