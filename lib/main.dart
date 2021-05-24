import 'package:agenda/pages/login.dart';
import 'package:agenda/pages/signIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:agenda/view/home.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseFirestore.instance.collection("tarefa").doc("2").set({"titulo": "fazer comida", "descricao": " todos os dias", "concluido": "false", "excluido":"false"});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: login.tag,
      routes: {
        Home.tag: (context) => Home(),
        login.tag: (context) => login(),
        signIn.tag: (context) => signIn()
      },
    );
  }
}