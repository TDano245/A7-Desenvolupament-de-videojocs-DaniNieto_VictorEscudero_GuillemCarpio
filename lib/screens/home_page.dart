import 'package:flutter/material.dart';
import '../services/car_http_service.dart';
import '../model/car_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final carService = CarHttpService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cars API"),
      ),
      body: FutureBuilder<List<CarsModel>>(
        future: carService.getCars(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay coches"));
          }

          final cars = snapshot.data!;

          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: Text("${car.make} ${car.model}"),
                  subtitle: Text("Year: ${car.year}"),
                  trailing: Text(car.type),
                ),
              );
            },
          );
        },
      ),
    );
  }
}