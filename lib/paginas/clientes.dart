import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class clientes extends StatefulWidget {
  clientes({Key? key}) : super(key: key);

  @override
  State<clientes> createState() => _clientesState();
}

class _clientesState extends State<clientes> {
  final controlCodigo = TextEditingController();
  final controlNombre = TextEditingController();
  final controlApellido = TextEditingController();
  final controlObservacion = TextEditingController();

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
          "Gestion de Clientes",
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
          controller: controlApellido,
          decoration: new InputDecoration(hintText: "Apellidos"),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: controlObservacion,
          decoration: new InputDecoration(hintText: "Observaciones"),
        ),
        SizedBox(
          height: 5,
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
                        apellido: controlApellido.text,
                        observacion: controlObservacion.text);
                    crearDoc(doc);
                    controlCodigo.text = "";
                    controlNombre.text = "";
                    controlApellido.text = "";
                    controlObservacion.text = "";
                  },
                  child: Text(
                    "Guardar",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 40,
              width: 150,
              child: ElevatedButton(
                  onPressed: () {
                    final doc = FirebaseFirestore.instance
                        .collection('clientes')
                        .doc(controlCodigo.text);

                    doc.delete();
                    controlCodigo.text = "";
                    controlNombre.text = "";
                    controlApellido.text = "";
                    controlObservacion.text = "";
                  },
                  child: Text(
                    "Eliminar",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ],
        ),
        //Boton eliminar
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
        title: Text(mesero.nombre + ' ' + mesero.apellido),
        subtitle: Text(mesero.observacion),
      );

  Stream<List<Doc>> leerDoc() => FirebaseFirestore.instance
      .collection('clientes')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Doc.fromJson(doc.data())).toList());

  Future crearDoc(Doc registro) async {
    final doc =
        FirebaseFirestore.instance.collection('clientes').doc(registro.id);
    //plato.id = docPlato.id;

    final json = registro.toJson();
    await doc.set(json);
  }
}

class Doc {
  String id;
  final String nombre;
  final String apellido;
  final String observacion;

  Doc(
      {required this.id,
      required this.nombre,
      required this.apellido,
      required this.observacion});

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'apellido': apellido,
        'observacion': observacion
      };

  static Doc fromJson(Map<String, dynamic> json) => Doc(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      observacion: json['observacion']);
}
