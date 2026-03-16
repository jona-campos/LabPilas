import 'package:flutter/material.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {

  List<String> pila = [];
  TextEditingController accionController = TextEditingController();

  void registrarAccion() {
    if (accionController.text.isNotEmpty) {
      setState(() {
        pila.add(accionController.text);
        accionController.clear();
      });
    }
  }

  void deshacerAccion() {
    if (pila.isNotEmpty) {
      setState(() {
        pila.removeLast();
      });
    }
  }

  void vaciarHistorial() {
    setState(() {
      pila.clear();
    });
  }

  String mostrarUltimaAccion() {
    if (pila.isEmpty) {
      return "No hay acciones";
    }
    return pila.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestor de Historial"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: accionController,
              decoration: InputDecoration(
                labelText: "Nueva acción",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: registrarAccion,
              child: Text("Registrar acción"),
            ),

            SizedBox(height: 20),

            Text(
              "Última acción: ${mostrarUltimaAccion()}",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: deshacerAccion,
                  child: Text("Deshacer"),
                ),
                ElevatedButton(
                  onPressed: vaciarHistorial,
                  child: Text("Vaciar historial"),
                ),
              ],
            ),

            SizedBox(height: 20),

            Text(
              "Historial:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: pila.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(pila[pila.length - 1 - index]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}