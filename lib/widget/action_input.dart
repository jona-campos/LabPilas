import 'package:flutter/material.dart';

class ActionInput extends StatelessWidget {

  final TextEditingController controller;
  final VoidCallback onAdd;

  const ActionInput({
    super.key,
    required this.controller,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: const TextStyle(fontSize: 16, color: Colors.white),
          controller: controller,
          decoration: const InputDecoration(
            labelText: "Nueva acción",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onAdd,
          child: const Text("Registrar acción"),
        ),
      ],
    );
  }
}