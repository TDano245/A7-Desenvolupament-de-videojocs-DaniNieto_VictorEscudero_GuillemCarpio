import 'package:flutter/material.dart';
import 'calcul.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SamarretesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SamarretesPage extends StatefulWidget {
  const SamarretesPage({super.key});

  @override
  State<SamarretesPage> createState() => _SamarretesPageState();
}

class _SamarretesPageState extends State<SamarretesPage> {
  int? numero;
  String? talla;
  int tipusDescompte = 0;

  bool get mostrarPreu => numero != null && talla != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Botiga de samarretes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // INPUT NÚMERO
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Número de samarretes",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  numero = int.tryParse(value);
                });
              },
            ),

            const SizedBox(height: 20),

            // RADIO BUTTONS
            const Text("Selecciona talla:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            RadioListTile(
              title: const Text("S (10€)"),
              value: "S",
              groupValue: talla,
              onChanged: (value) {
                setState(() {
                  talla = value.toString();
                });
              },
            ),
            RadioListTile(
              title: const Text("M (12€)"),
              value: "M",
              groupValue: talla,
              onChanged: (value) {
                setState(() {
                  talla = value.toString();
                });
              },
            ),
            RadioListTile(
              title: const Text("L (15€)"),
              value: "L",
              groupValue: talla,
              onChanged: (value) {
                setState(() {
                  talla = value.toString();
                });
              },
            ),

            const SizedBox(height: 20),

            // DROPDOWN DESCOMPTE
            const Text("Codi promocional:"),

            DropdownButton<int>(
              value: tipusDescompte,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 0, child: Text("Cap descompte")),
                DropdownMenuItem(value: 1, child: Text("10% descompte")),
                DropdownMenuItem(value: 2, child: Text("20€ (>100€)")),
              ],
              onChanged: (value) {
                setState(() {
                  tipusDescompte = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            // RESULTAT
            if (mostrarPreu)
              Builder(
                builder: (context) {
                  double preuBase =
                      calculaPreuSamarretes(numero!, talla!);
                  double descompte =
                      calculaDescompte(preuBase, tipusDescompte);
                  double total =
                      preuDefinitiu(numero!, talla!, tipusDescompte);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Preu base: ${preuBase.toStringAsFixed(2)} €"),
                      Text("Descompte: -${descompte.toStringAsFixed(2)} €"),
                      const SizedBox(height: 10),
                      Text(
                        "TOTAL: ${total.toStringAsFixed(2)} €",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
} 