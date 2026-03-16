import 'package:flutter/material.dart';
import '../models/pilas.dart';
import '../widget/action_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ── Paleta ────────────────────────────────────────────────────
  static const _bg       = Color(0xFF0D0D0D);
  static const _surface  = Color(0xFF1A1A1A);
  static const _card     = Color(0xFF222222);
  static const _accent   = Color(0xFF4FC3F7);
  static const _danger   = Color(0xFFEF5350);
  static const _textPri  = Color(0xFFEEEEEE);
  static const _textSec  = Color(0xFF888888);

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

  void deshacer() => setState(() => pila.pop());
  void limpiar()  => setState(() => pila.clear());

  @override
  Widget build(BuildContext context) {
    final historial = pila.historial();
    final ultima    = pila.peek();

    return Scaffold(
      backgroundColor: _bg,

      // ── AppBar ────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: _surface,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "HISTORIAL",
          style: TextStyle(
            color: _accent,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 4,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: _accent.withOpacity(0.2)),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ── Input ──────────────────────────────────────────
            ActionInput(controller: controller, onAdd: registrar),

            const SizedBox(height: 16),

            // ── Última acción ──────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _accent.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _accent.withOpacity(0.25)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.bolt_rounded, color: _accent, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      ultima?.descripcion ?? "Sin acciones registradas",
                      style: const TextStyle(
                        color: _accent,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Botones (solo si hay elementos) ────────────────
            if (historial.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: _DarkButton(
                      label: "Deshacer",
                      icon: Icons.undo_rounded,
                      color: _accent,
                      onPressed: deshacer,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _DarkButton(
                      label: "Vaciar",
                      icon: Icons.delete_sweep_rounded,
                      color: _danger,
                      onPressed: limpiar,
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 24),

            // ── Header sección ─────────────────────────────────
            Row(
              children: [
                const Text(
                  "PILA",
                  style: TextStyle(
                    color: _textSec,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: Container(height: 1, color: _surface)),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _textSec.withOpacity(0.3)),
                  ),
                  child: Text(
                    "${historial.length} items",
                    style: const TextStyle(color: _textSec, fontSize: 11),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ── ListView ───────────────────────────────────────
            Expanded(
              child: historial.isEmpty
                  ? const _EmptyState()
                  : ListView.builder(
                      itemCount: historial.length,
                      itemBuilder: (context, index) {
                        final esElTope = index == 0;
                        final posicion = historial.length - index;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: esElTope
                                ? _accent.withOpacity(0.1)
                                : _card,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: esElTope
                                  ? _accent.withOpacity(0.4)
                                  : Colors.white.withOpacity(0.05),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Número
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: esElTope ? _accent : _surface,
                                  border: Border.all(
                                    color: esElTope
                                        ? _accent
                                        : _textSec.withOpacity(0.2),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '$posicion',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: esElTope ? _bg : _textSec,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Descripción
                              Expanded(
                                child: Text(
                                  historial[index].descripcion,
                                  style: TextStyle(
                                    color: esElTope ? _accent : _textPri,
                                    fontWeight: esElTope
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              // Badge tope
                              if (esElTope)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: _accent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "TOPE",
                                    style: TextStyle(
                                      color: _bg,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                )
                              else
                                Text(
                                  "#$posicion",
                                  style: const TextStyle(
                                      color: _textSec, fontSize: 12),
                                ),
                            ],
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

// ── Botón oscuro ───────────────────────────────────────────────────
class _DarkButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _DarkButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.12),
        foregroundColor: color,
        elevation: 0,
        side: BorderSide(color: color.withOpacity(0.35)),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle:
            const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// ── Estado vacío ───────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.layers_clear_rounded,
              color: Color(0xFF2A2A2A), size: 52),
          SizedBox(height: 12),
          Text("La pila está vacía",
              style: TextStyle(color: Color(0xFF555555), fontSize: 14)),
          SizedBox(height: 4),
          Text("Registra una acción para comenzar",
              style: TextStyle(color: Color(0xFF3A3A3A), fontSize: 12)),
        ],
      ),
    );
  }
}