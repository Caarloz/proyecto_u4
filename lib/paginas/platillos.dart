import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class platillos extends StatefulWidget {
  platillos({Key? key}) : super(key: key);

  @override
  State<platillos> createState() => _platillosState();
}

class _platillosState extends State<platillos> {
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
          "Gestion de platillos",
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
          keyboardType: TextInputType.number,
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
                    final plato = Plato(
                        id: controlCodigo.text,
                        nombre: controlNombre.text,
                        importe: int.parse(controlImporte.text));
                    crearPlatillo(plato);
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
                    final docPlato = FirebaseFirestore.instance
                        .collection('platillo')
                        .doc(controlCodigo.text);

                    docPlato.delete();
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
    return StreamBuilder<List<Plato>>(
      stream: leerPlatillos(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Algo no va bien ${snapshot}');
        } else if (snapshot.hasData) {
          final platillos = snapshot.data!;

          return ListView(
            children: platillos.map(buildPlato).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildPlato(Plato plato) => ListTile(
        leading: CircleAvatar(
          child: Text('${plato.id}'),
        ),
        title: Text(plato.nombre),
        subtitle: Text('Importe: ${plato.importe}'),
      );

  Stream<List<Plato>> leerPlatillos() => FirebaseFirestore.instance
      .collection('platillo')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Plato.fromJson(doc.data())).toList());

  Future crearPlatillo(Plato plato) async {
    final docPlato =
        FirebaseFirestore.instance.collection('platillo').doc(plato.id);
    //plato.id = docPlato.id;

    final json = plato.toJson();
    await docPlato.set(json);
  }
}

class Plato {
  String id;
  final String nombre;
  final int importe;

  Plato({required this.id, required this.nombre, required this.importe});

  Map<String, dynamic> toJson() =>
      {'id': id, 'nombre': nombre, 'importe': importe};

  static Plato fromJson(Map<String, dynamic> json) =>
      Plato(id: json['id'], nombre: json['nombre'], importe: json['importe']);
}
