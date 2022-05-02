import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_u4/paginas/Meseros.dart';
import 'package:proyecto_u4/paginas/clientes.dart';
import 'package:proyecto_u4/paginas/platillos.dart';
import 'package:proyecto_u4/paginas/bebidas.dart';
import 'package:proyecto_u4/paginas/mesas.dart';

class Principal extends StatefulWidget {
  Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: cuerpo());
  }

  Widget cuerpo() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            child: platillos(),
                            type: PageTransitionType.scale));
                  },
                  child: Text(
                    "Platillos",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            child: bebidas(),
                            type: PageTransitionType.scale));
                  },
                  child: Text(
                    "Bebidas",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            child: mesas(),
                            type: PageTransitionType.scale));
                  },
                  child: Text(
                    "Mesas",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            child: meseros(),
                            type: PageTransitionType.scale));
                  },
                  child: Text(
                    "Meseros",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            child: clientes(),
                            type: PageTransitionType.scale));
                  },
                  child: Text(
                    "Clientes",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            child: meseros(),
                            type: PageTransitionType.scale));
                  },
                  child: Text(
                    "Facturas",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
