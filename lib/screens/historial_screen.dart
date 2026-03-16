import 'dart:math';

import 'package:flutter/material.dart';
import '../models/pilas.dart';
import '../widget/action_input.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  final PilaService pila = PilaService();
  final TextEditingController controller = TextEditingController();

  void registrar() {
    if (controller.text.isNotEmpty) {
      setState(() {
        pila.push(controller.text);
        controller.clear();
      });
    }
  }

  void deshacer() {
    setState(() {
      pila.pop();
    });
  }

  void limpiar() {
    setState(() {
      pila.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final historial = pila.historial();
    final ultima = pila.peek();

    return Scaffold(
      appBar: AppBar(title: const Text("Gestor de Historial")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          
          children: [
            ActionInput(controller: controller, onAdd: registrar),

            const SizedBox(height: 20),

            Text(
              "Última acción: ${ultima?.descripcion ?? "Sin acciones"}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),
            if (historial.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: deshacer,
                    child: const Text("Deshacer"),
                  ),
                  ElevatedButton(
                    onPressed: limpiar,
                    child: const Text("Vaciar historial"),
                  ),
                ],
              ),

            const SizedBox(height: 20),

            const Text(
              "Historial",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: historial.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "${index + 1}. ${historial[index].descripcion}",
                      style: TextStyle(
                        fontSize: 20,
                        backgroundColor: Color.fromARGB(
                          Random().nextInt(255),
                          Random().nextInt(255),
                          Random().nextInt(255),
                          Random().nextInt(255),
                        ),
                      ),
                      strutStyle: const StrutStyle(height: 1.5, leading: 0.5),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
