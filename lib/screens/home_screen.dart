import 'package:flutter/material.dart';
import '../models/pilas.dart';
import '../widget/action_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

            ActionInput(
              controller: controller,
              onAdd: registrar,
            ),

            const SizedBox(height: 20),

            Text(
              "Última acción: ${ultima?.descripcion ?? "Sin acciones"}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),
            if(historial.isNotEmpty)
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
            return SizedBox(
              width: 150,
              height: 80,
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              historial[index].descripcion,
              style: const TextStyle(fontSize: 16),
          ),
        ),
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