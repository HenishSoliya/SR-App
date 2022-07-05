import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Alert/AlertSet.dart';
import 'Bills/Bill.dart';
import 'Bills/Cart.dart';
import 'Bills/Payment.dart';
import 'Bills/ViewListB.dart';
import 'Growth/Growth.dart';
import 'HomeScreen.dart';
import 'PandingPayment/PPInfo.dart';
import 'PandingPayment/PPUpdate.dart';
import 'PandingPayment/PandingPayment.dart';
import 'PandingPayment/View.dart';
import 'Alert/Alert.dart';
import 'Bills/PrePayment.dart';
import 'Growth/GrowthSet.dart';
import 'Stock/ViewList.dart';
import 'stock/AddStock.dart';
import 'stock/UpdateStock.dart';
import 'stock/Info.dart';
import 'stock/Stock.dart';
import 'loginlogout/Load.dart';
import 'loginlogout/ForgotPass.dart';
import 'loginlogout/Login.dart';
import 'loginlogout/Register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SRApp',
      routes: {        
        "load":(context)=>Load(),
        "login":(context)=>Login(),
        "register":(context)=>Register(),
        "forgotpass":(context)=>ForgotPass(),
        "homescreen":(context)=>HomeScreen(),
        "stock":(context)=>Stock(),
        "viewlist":(context)=>ViewList(),
        "info":(context)=>Info(),
        "addstock":(context)=>AddStock(),
        "updatestock":(context)=>UpdateStock(),
        "bill":(context)=>Bill(),
        "viewlistb":(context)=>ViewListB(),
        "cart":(context)=>Cart(),
        "prepayment":(context)=>PrePayment(),
        "payment":(context)=>Payment(),
        "view":(context)=>View(),
        "ppp":(context)=>PPPInfo(),
        "pp":(context)=>PandingPayment(),
        "ppinfo":(context)=>PPInfo(),
        "ppupdate":(context)=>PPUpdate(),
        "growth":(context)=>Growth(),
        "growthset":(context)=>GrowthSet(),
        "alert":(context)=>Alert(),
        "alertset":(context)=>AlertSet(),
      },
      initialRoute: "load",
    );
  }
}