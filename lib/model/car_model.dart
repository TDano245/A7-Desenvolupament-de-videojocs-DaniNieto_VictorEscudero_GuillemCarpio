import 'dart:convert';

class CarsModel {
  final int id;
  final int year;
  final String make;
  final String model;
  final String type;

  CarsModel({
    required this.id,
    required this.year,
    required this.make,
    required this.model,
    required this.type,
  });

  // Crear objeto desde Map
  factory CarsModel.fromMapToCarObject(Map<String, dynamic> json) =>
      CarsModel(
        id: json["id"],
        year: json["year"],
        make: json["make"],
        model: json["model"],
        type: json["type"],
      );

  // Convertir objeto a Map
  Map<String, dynamic> fromObjectToMap() => {
        "id": id,
        "year": year,
        "make": make,
        "model": model,
        "type": type,
      };
}

// Convertir JSON string a lista de CarsModel
List<CarsModel> carsModelFromJson(String str) =>
    List<CarsModel>.from(
        json.decode(str).map((x) => CarsModel.fromMapToCarObject(x)));

// Convertir lista de CarsModel a JSON string
String carsModelToJson(List<CarsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.fromObjectToMap())));