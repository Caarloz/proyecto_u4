import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_u4/paginas/principal.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(cruds());
}

class cruds extends StatefulWidget {
  cruds({Key? key}) : super(key: key);

  @override
  State<cruds> createState() => _crudsState();
}

class _crudsState extends State<cruds> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Principal(),
    );
  }
}
