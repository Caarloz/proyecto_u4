import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class bebidas extends StatefulWidget {
  bebidas({Key? key}) : super(key: key);

  @override
  State<bebidas> createState() => _bebidasState();
}

class _bebidasState extends State<bebidas> {
  final controlCodigo = TextEditingController();
  final controlNombre = TextEditingController();
  final controlImporte = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 310,
        flexibleSpace: Container(
          color: Colors.white,
          child: Column(
            children: [campos()],
          ),
        ),
      ),
      bottomSheet: consulta(),
    );
  }

  Widget campos() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Gestion de bebidas",
          style: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controlCodigo,
          decoration: new InputDecoration(hintText: "Codigo"),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: controlNombre,
          decoration: new InputDecoration(hintText: "Nombre"),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: controlImporte,
          decoration: new InputDecoration(hintText: "Importe"),
        ),
        SizedBox(
          height: 20,
        ),
        //Boton guardar
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                  onPressed: () {
                    final bebida = Bebida(
                        id: controlCodigo.text,
                        nombre: controlNombre.text,
                        importe: controlImporte.text);
                    crearBebida(bebida);
                    controlCodigo.text = "";
                    controlNombre.text = "";
                    controlImporte.text = "";
                  },
                  child: Text(
                    "Guardar",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            //Boton eliminar
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                  onPressed: () {
                    final docBebida = FirebaseFirestore.instance
                        .collection('bebidas')
                        .doc(controlCodigo.text);

                    docBebida.delete();
                    controlCodigo.text = "";
                    controlNombre.text = "";
                    controlImporte.text = "";
                  },
                  child: Text(
                    "Eliminar",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Widget consulta() {
    return StreamBuilder<List<Bebida>>(
      stream: leerBebidas(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Algo no va bien ${snapshot}');
        } else if (snapshot.hasData) {
          final bebidas = snapshot.data!;

          return ListView(
            children: bebidas.map(buildBebida).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildBebida(Bebida bebida) => ListTile(
        leading: CircleAvatar(
          child: Text('${bebida.id}'),
        ),
        title: Text(bebida.nombre),
        subtitle: Text('Importe: ${bebida.importe}'),
      );

  Stream<List<Bebida>> leerBebidas() => FirebaseFirestore.instance
      .collection('bebidas')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Bebida.fromJson(doc.data())).toList());

  Future crearBebida(Bebida bebida) async {
    final docBebida =
        FirebaseFirestore.instance.collection('bebidas').doc(bebida.id);
    //plato.id = docPlato.id;

    final json = bebida.toJson();
    await docBebida.set(json);
  }
}

class Bebida {
  String id;
  final String nombre;
  final String importe;

  Bebida({required this.id, required this.nombre, required this.importe});

  Map<String, dynamic> toJson() =>
      {'id': id, 'nombre': nombre, 'importe': importe};

  static Bebida fromJson(Map<String, dynamic> json) =>
      Bebida(id: json['id'], nombre: json['nombre'], importe: json['importe']);
}
