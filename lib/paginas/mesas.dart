import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class mesas extends StatefulWidget {
  mesas({Key? key}) : super(key: key);

  @override
  State<mesas> createState() => _mesasState();
}

class _mesasState extends State<mesas> {
  final controlCodigo = TextEditingController();
  final controlUbicacion = TextEditingController();
  final controlComensales = TextEditingController();

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
          "Gestion de mesas",
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
          controller: controlUbicacion,
          decoration: new InputDecoration(hintText: "Ubicacion"),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: controlComensales,
          decoration: new InputDecoration(hintText: "Numero de comensales"),
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
                    final mesa = Mesa(
                        id: controlCodigo.text,
                        ubicacion: controlUbicacion.text,
                        comensales: controlComensales.text);
                    crearMesa(mesa);
                    controlCodigo.text = "";
                    controlUbicacion.text = "";
                    controlComensales.text = "";
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
                    final docMesa = FirebaseFirestore.instance
                        .collection('mesas')
                        .doc(controlCodigo.text);

                    docMesa.delete();
                    controlCodigo.text = "";
                    controlUbicacion.text = "";
                    controlComensales.text = "";
                  },
                  child: Text(
                    "Eliminar",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget consulta() {
    return StreamBuilder<List<Mesa>>(
      stream: leerMesas(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Algo no va bien ${snapshot}');
        } else if (snapshot.hasData) {
          final mesas = snapshot.data!;

          return ListView(
            children: mesas.map(buildMesa).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildMesa(Mesa mesa) => ListTile(
        leading: CircleAvatar(
          child: Text('${mesa.id}'),
        ),
        title: Text(mesa.ubicacion),
        subtitle: Text('Comensales: ${mesa.comensales}'),
      );

  Stream<List<Mesa>> leerMesas() => FirebaseFirestore.instance
      .collection('mesas')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Mesa.fromJson(doc.data())).toList());

  Future crearMesa(Mesa mesa) async {
    final docMesa = FirebaseFirestore.instance.collection('mesas').doc(mesa.id);
    //plato.id = docPlato.id;

    final json = mesa.toJson();
    await docMesa.set(json);
  }
}

class Mesa {
  String id;
  final String ubicacion;
  final String comensales;

  Mesa({required this.id, required this.ubicacion, required this.comensales});

  Map<String, dynamic> toJson() =>
      {'id': id, 'ubicacion': ubicacion, 'comensales': comensales};

  static Mesa fromJson(Map<String, dynamic> json) => Mesa(
      id: json['id'],
      ubicacion: json['ubicacion'],
      comensales: json['comensales']);
}
