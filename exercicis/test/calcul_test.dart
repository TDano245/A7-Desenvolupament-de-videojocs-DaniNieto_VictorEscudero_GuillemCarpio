import 'package:flutter_test/flutter_test.dart';
import '../lib/calcul.dart';

void main() {
  group('calculaPreuSamarretes', () {
    test('Calcul correcte per talla S', () {
      expect(calculaPreuSamarretes(3, "S"), 30.0);
    });

    test('Calcul correcte per talla M', () {
      expect(calculaPreuSamarretes(2, "M"), 24.0);
    });

    test('Calcul correcte per talla L', () {
      expect(calculaPreuSamarretes(4, "L"), 60.0);
    });
  });

  group('calculaDescompte', () {
    test('Descompte 10%', () {
      expect(calculaDescompte(100, 1), 10.0);
    });

    test('Descompte 20€ si supera 100€', () {
      expect(calculaDescompte(150, 2), 20.0);
    });

    test('NO descompte 20€ si no arriba a 100€', () {
      expect(calculaDescompte(80, 2), 0.0);
    });

    test('Sense descompte', () {
      expect(calculaDescompte(100, 0), 0.0);
    });
  });

  group('preuDefinitiu', () {
    test('Sense descompte', () {
      expect(preuDefinitiu(5, "S", 0), 50.0);
    });

    test('Amb descompte 10%', () {
      expect(preuDefinitiu(10, "M", 1), 108.0);
    });

    test('Amb descompte 20€ aplicat', () {
      expect(preuDefinitiu(10, "L", 2), 130.0);
    });

    test('Amb descompte 20€ NO aplicat', () {
      expect(preuDefinitiu(5, "L", 2), 75.0);
    });
  });
}