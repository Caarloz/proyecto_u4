import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class consulta_facturas extends StatefulWidget {
  consulta_facturas({Key? key}) : super(key: key);

  @override
  State<consulta_facturas> createState() => _consulta_facturasState();
}

class _consulta_facturasState extends State<consulta_facturas> {
  String nomCliente = "";
  String nomMesero = "";
  String nomMesa = "";
  String nomPlatillo = "";
  String nomBebida = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        flexibleSpace: Container(
          color: Colors.black,
          child: Column(
            children: [campos()],
          ),
        ),
      ),
      bottomSheet: consulta(),
    );
  }

  Widget campos() {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Facturas Guardadas",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void buscarCliente(String codigo) async {
    var collection = FirebaseFirestore.instance.collection('clientes');
    var querySnapshot = await collection.get();

    var borrar = true;

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var nombre = data['nombre'];
      var apellido = data['apellido'];
      var id = data['id'];
      if (id == codigo) {
        nomCliente = nombre + " " + apellido;
        borrar = false;
      }
      if (borrar) {
        nomCliente = "";
      }
    }
  }

  void buscarMesero(String codigo) async {
    var collection = FirebaseFirestore.instance.collection('meseros');
    var querySnapshot = await collection.get();

    var borrar = true;

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var nombre = data['nombre'];
      var id = data['id'];
      if (id == codigo) {
        nomMesero = nombre;
        borrar = false;
      }
      if (borrar) {
        nomMesero = "";
      }
    }
  }

  void buscarMesa(String codigo) async {
    var collection = FirebaseFirestore.instance.collection('mesas');
    var querySnapshot = await collection.get();

    var borrar = true;

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var nombre = data['ubicacion'];
      var id = data['id'];
      if (id == codigo) {
        nomMesa = nombre;
        borrar = false;
      }
      if (borrar) {
        nomMesa = "";
      }
    }
  }

  void buscarPlatillo(String codigo) async {
    var collection = FirebaseFirestore.instance.collection('platillo');
    var querySnapshot = await collection.get();

    var borrar = true;

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var nombre = data['nombre'];
      var id = data['id'];
      if (id == codigo) {
        nomPlatillo = nombre;
        borrar = false;
      }
      if (borrar) {
        nomPlatillo = "";
      }
    }
  }

  void buscarBebida(String codigo) async {
    var collection = FirebaseFirestore.instance.collection('bebidas');
    var querySnapshot = await collection.get();

    var borrar = true;

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var nombre = data['nombre'];
      var id = data['id'];
      if (id == codigo) {
        nomBebida = nombre;
        borrar = false;
      }
      if (borrar) {
        nomBebida = "";
      }
    }
  }

  String cliente(String codigo) {
    buscarCliente(codigo);
    String doc = nomCliente;
    return doc;
  }

  String mesero(String codigo) {
    buscarMesero(codigo);
    String doc = nomMesero;
    return doc;
  }

  String mesa(String codigo) {
    buscarMesa(codigo);
    String doc = nomMesa;
    return doc;
  }

  String platillo(String codigo) {
    buscarPlatillo(codigo);
    String doc = nomPlatillo;
    return doc;
  }

  String bebida(String codigo) {
    buscarBebida(codigo);
    String doc = nomBebida;
    return doc;
  }

  Widget consulta() {
    return StreamBuilder<List<Doc>>(
      stream: leerDoc(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Algo no va bien ${snapshot}');
        } else if (snapshot.hasData) {
          final registros = snapshot.data!;
          return ListView(
            children: registros.map(buildRegistro).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildRegistro(Doc doc) => ListTile(
        leading: CircleAvatar(
          child: Text('${doc.id}'),
        ),
        //title: Text(cliente(doc.cliente) + ' ' + ' - Mesa: ${mesa(doc.mesa)}'),
        //subtitle: Text(
        //    'Platillo: ${platillo(doc.platillo)} - Bebida: ${bebida(doc.bebida)}'),
        title: Text('Cliente: ' + doc.cliente + ' ' + ' - Mesa: ${doc.mesa}'),
        subtitle: Text('Platillo: ${doc.platillo} - Bebida: ${doc.bebida}'),
      );

  Stream<List<Doc>> leerDoc() => FirebaseFirestore.instance
      .collection('facturas')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Doc.fromJson(doc.data())).toList());
}

class Doc {
  String id;
  final String fecha;
  final String cliente;
  final String mesero;
  final String mesa;
  final String platillo;
  final String bebida;

  Doc(
      {required this.id,
      required this.fecha,
      required this.cliente,
      required this.mesero,
      required this.mesa,
      required this.platillo,
      required this.bebida});

  static Doc fromJson(Map<String, dynamic> json) => Doc(
      id: json['id'],
      fecha: json['fecha'],
      cliente: json['cliente'],
      mesa: json['mesa'],
      mesero: json['mesero'],
      platillo: json['platillo'],
      bebida: json['bebida']);
}
