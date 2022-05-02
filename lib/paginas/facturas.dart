import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:proyecto_u4/paginas/consulta_facturas.dart';

import 'package:intl/intl.dart';

class facturas extends StatefulWidget {
  facturas({Key? key}) : super(key: key);

  @override
  State<facturas> createState() => _facturasState();
}

class _facturasState extends State<facturas> {
  @override
  void initState() {
    super.initState();

    controlCliente.addListener(buscarCliente);
    _focusCliente.addListener(buscarCliente);

    controlMesero.addListener(buscarMesero);
    _focusMesero.addListener(buscarMesero);

    controlMesa.addListener(buscarMesa);
    _focusMesa.addListener(buscarMesa);

    controlPlatillo.addListener(buscarPlatillo);
    _focusPlatillo.addListener(buscarPlatillo);

    controlBebida.addListener(buscarBebida);
    _focusBebida.addListener(buscarBebida);
  }

  final controlCodigo = TextEditingController();
  final controlFecha = TextEditingController();
  final controlCliente = TextEditingController();
  final controlNomCliente = TextEditingController();
  final controlMesero = TextEditingController();
  final controlNomMesero = TextEditingController();
  final controlMesa = TextEditingController();
  final controlNomMesa = TextEditingController();
  final controlPlatillo = TextEditingController();
  final controlNomPlatillo = TextEditingController();
  final controlBebida = TextEditingController();
  final controlNomBebida = TextEditingController();

  FocusNode _focusCliente = new FocusNode();
  FocusNode _focusMesero = new FocusNode();
  FocusNode _focusMesa = new FocusNode();
  FocusNode _focusPlatillo = new FocusNode();
  FocusNode _focusBebida = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        flexibleSpace: Container(
          color: Colors.black,
        ),
      ),
      bottomSheet: campos(),
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
              "Gestion de Facturas",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  child: TextField(
                    controller: controlCodigo,
                    decoration: new InputDecoration(hintText: "Factura"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 115,
                  child: DateTimeField(
                    decoration: new InputDecoration(hintText: "Fecha"),
                    controller: controlFecha,
                    format: DateFormat("yyyy-MM-dd HH:mm"),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  child: TextField(
                    controller: controlCliente,
                    focusNode: _focusCliente,
                    decoration: new InputDecoration(hintText: "Cod Cliente"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 115,
                  child: TextField(
                    enabled: false,
                    controller: controlNomCliente,
                    decoration: new InputDecoration(hintText: ""),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  child: TextField(
                    controller: controlMesero,
                    focusNode: _focusMesero,
                    decoration: new InputDecoration(hintText: "Cod Mesero"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 115,
                  child: TextField(
                    enabled: false,
                    controller: controlNomMesero,
                    decoration: new InputDecoration(hintText: ""),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  child: TextField(
                    controller: controlMesa,
                    focusNode: _focusMesa,
                    decoration: new InputDecoration(hintText: "Cod Mesa"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 115,
                  child: TextField(
                    enabled: false,
                    controller: controlNomMesa,
                    decoration: new InputDecoration(hintText: ""),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  child: TextField(
                    controller: controlPlatillo,
                    focusNode: _focusPlatillo,
                    decoration: new InputDecoration(hintText: "Cod Plato"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 115,
                  child: TextField(
                    enabled: false,
                    controller: controlNomPlatillo,
                    decoration: new InputDecoration(hintText: ""),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  child: TextField(
                    controller: controlBebida,
                    focusNode: _focusBebida,
                    decoration: new InputDecoration(hintText: "Cod Bebida"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 115,
                  child: TextField(
                    enabled: false,
                    controller: controlNomBebida,
                    decoration: new InputDecoration(hintText: ""),
                  ),
                ),
              ],
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
                            fecha: controlFecha.text,
                            cliente: controlCliente.text,
                            mesero: controlMesero.text,
                            mesa: controlMesa.text,
                            platillo: controlPlatillo.text,
                            bebida: controlBebida.text);
                        crearDoc(doc);
                        controlCodigo.text = "";
                        controlFecha.text = "";
                        controlCliente.text = "";
                        controlMesero.text = "";
                        controlMesa.text = "";
                        controlPlatillo.text = "";
                        controlBebida.text = "";
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
                            .collection('facturas')
                            .doc(controlCodigo.text);

                        doc.delete();
                        controlCodigo.text = "";
                        controlFecha.text = "";
                        controlCliente.text = "";
                        controlMesero.text = "";
                        controlMesa.text = "";
                        controlPlatillo.text = "";
                        controlBebida.text = "";
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
            SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            child: consulta_facturas(),
                            type: PageTransitionType.scale));
                  },
                  child: Text(
                    "Registros",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            //Boton eliminar
          ],
        ),
      ),
    );
  }

  void buscarCliente() async {
    String text = controlCodigo.text;
    bool hasFocus = _focusCliente.hasFocus;

    var collection = FirebaseFirestore.instance.collection('clientes');
    var querySnapshot = await collection.get();

    var borrar = true;

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var nombre = data['nombre'];
      var id = data['id'];
      if (id == controlCliente.text) {
        controlNomCliente.text = nombre;
        borrar = false;
      }
      if (borrar) {
        controlNomCliente.text = "";
      }
    }
  }

  void buscarMesero() async {
    String text = controlCodigo.text;
    bool hasFocus = _focusCliente.hasFocus;

    var collection = FirebaseFirestore.instance.collection('meseros');
    var querySnapshot = await collection.get();

    var borrar = true;

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var nombre = data['nombre'];
      var id = data['id'];
      if (id == controlMesero.text) {
        controlNomMesero.text = nombre;
        borrar = false;
      }
      if (borrar) {
        controlNomMesero.text = "";
      }
    }
  }

  void buscarMesa() async {
    String text = controlCodigo.text;
    bool hasFocus = _focusCliente.hasFocus;

    var collection = FirebaseFirestore.instance.collection('mesas');
    var querySnapshot = await collection.get();

    var borrar = true;

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var nombre = data['ubicacion'];
      var id = data['id'];
      if (id == controlMesa.text) {
        controlNomMesa.text = nombre;
        borrar = false;
      }
      if (borrar) {
        controlNomMesa.text = "";
      }
    }
  }

  void buscarPlatillo() async {
    String text = controlCodigo.text;
    bool hasFocus = _focusCliente.hasFocus;

    var collection = FirebaseFirestore.instance.collection('platillo');
    var querySnapshot = await collection.get();

    var borrar = true;

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var nombre = data['nombre'];
      var id = data['id'];
      if (id == controlPlatillo.text) {
        controlNomPlatillo.text = nombre;
        borrar = false;
      }
      if (borrar) {
        controlNomPlatillo.text = "";
      }
    }
  }

  void buscarBebida() async {
    String text = controlCodigo.text;
    bool hasFocus = _focusCliente.hasFocus;

    var collection = FirebaseFirestore.instance.collection('bebidas');
    var querySnapshot = await collection.get();

    var borrar = true;

    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var nombre = data['nombre'];
      var id = data['id'];
      if (id == controlBebida.text) {
        controlNomBebida.text = nombre;
        borrar = false;
      }
      if (borrar) {
        controlNomBebida.text = "";
      }
    }
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
        title: Text(doc.fecha + ' ' + doc.cliente),
        subtitle: Text(doc.mesero),
      );

  Stream<List<Doc>> leerDoc() => FirebaseFirestore.instance
      .collection('facturas')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Doc.fromJson(doc.data())).toList());

  Future crearDoc(Doc registro) async {
    final doc =
        FirebaseFirestore.instance.collection('facturas').doc(registro.id);
    //plato.id = docPlato.id;

    final json = registro.toJson();
    await doc.set(json);
  }
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'fecha': fecha,
        'cliente': cliente,
        'mesero': mesero,
        'mesa': mesa,
        'platillo': platillo,
        'bebida': bebida
      };

  static Doc fromJson(Map<String, dynamic> json) => Doc(
      id: json['id'],
      fecha: json['fecha'],
      cliente: json['cliente'],
      mesa: json['mesa'],
      mesero: json['mesero'],
      platillo: json['platillo'],
      bebida: json['bebida']);
}
