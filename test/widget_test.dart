import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hello_world/services/car_http_service.dart';

void main() {
  group('Car API Test', () {
    test('Get cars from API', () async {
      final carHttpService = CarHttpService();

      final cars = await carHttpService.getCars();

      // 1. Comprobar que la lista no está vacía
      expect(cars.isNotEmpty, true);

      // 2. Comprobar que tiene elementos
      expect(cars.length, greaterThan(0));

      // 3. Comprobar que el primer coche tiene datos válidos
      expect(cars.first.id, isNotNull);
      expect(cars.first.make, isNotEmpty);
      expect(cars.first.model, isNotEmpty);

      // 4. Comprobar que todos los coches tienen año válido
      for (var car in cars) {
        expect(car.year, greaterThan(1900));
      }
    });
  });
}