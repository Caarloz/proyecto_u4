import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class meseros extends StatefulWidget {
  meseros({Key? key}) : super(key: key);

  @override
  State<meseros> createState() => _meserosState();
}

class _meserosState extends State<meseros> {
  final controlCodigo = TextEditingController();
  final controlNombre = TextEditingController();
  final controlApellido1 = TextEditingController();
  final controlApellido2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 320,
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
          "Gestion de Meseros",
          style: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controlCodigo,
          decoration: new InputDecoration(hintText: "Codigo"),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: controlNombre,
          decoration: new InputDecoration(hintText: "Nombre"),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: controlApellido1,
          decoration: new InputDecoration(hintText: "Primer Apellido"),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: controlApellido2,
          decoration: new InputDecoration(hintText: "Segundo Apellido"),
        ),
        SizedBox(
          height: 10,
        ),
        //Boton guardar
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              width: 150,
              child: ElevatedButton(
                  onPressed: () {
                    final doc = Doc(
                        id: controlCodigo.text,
                        nombre: controlNombre.text,
                        apellido1: controlApellido1.text,
                        apellido2: controlApellido2.text);
                    crearDoc(doc);
                    controlCodigo.text = "";
                    controlNombre.text = "";
                    controlApellido1.text = "";
                    controlApellido2.text = "";
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
              height: 40,
              width: 150,
              child: ElevatedButton(
                  onPressed: () {
                    final doc = FirebaseFirestore.instance
                        .collection('meseros')
                        .doc(controlCodigo.text);

                    doc.delete();
                    controlCodigo.text = "";
                    controlNombre.text = "";
                    controlApellido1.text = "";
                    controlApellido2.text = "";
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

  Widget buildRegistro(Doc mesero) => ListTile(
        leading: CircleAvatar(
          child: Text('${mesero.id}'),
        ),
        title: Text(
            mesero.nombre + ' ' + mesero.apellido1 + ' ' + mesero.apellido2),
      );

  Stream<List<Doc>> leerDoc() => FirebaseFirestore.instance
      .collection('meseros')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Doc.fromJson(doc.data())).toList());

  Future crearDoc(Doc registro) async {
    final doc =
        FirebaseFirestore.instance.collection('meseros').doc(registro.id);
    //plato.id = docPlato.id;

    final json = registro.toJson();
    await doc.set(json);
  }
}

class Doc {
  String id;
  final String nombre;
  final String apellido1;
  final String apellido2;

  Doc(
      {required this.id,
      required this.nombre,
      required this.apellido1,
      required this.apellido2});

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'apellido1': apellido1,
        'apellido2': apellido2
      };

  static Doc fromJson(Map<String, dynamic> json) => Doc(
      id: json['id'],
      nombre: json['nombre'],
      apellido1: json['apellido1'],
      apellido2: json['apellido2']);
}
