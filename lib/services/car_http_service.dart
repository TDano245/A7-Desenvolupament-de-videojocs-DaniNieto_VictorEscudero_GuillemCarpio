import 'package:http/http.dart' as http;
import '../model/car_model.dart';

class CarHttpService {
  final String _serverUrl = "https://car-data.p.rapidapi.com";
  final String _headerKey = "0aa89a0e18mshfe1020f889af6b6p11bd66jsnb1c2146a1a99";
  final String _headerHost = "car-data.p.rapidapi.com";

  Future<List<CarsModel>> getCars() async {
    var uri = Uri.parse("$_serverUrl/cars");

    var response = await http.get(
      uri,
      headers: {
        "x-rapidapi-key": _headerKey,
        "x-rapidapi-host": _headerHost,
      },
    );

    if (response.statusCode == 200) {
      return carsModelFromJson(response.body);
    } else {
      throw Exception(
          "Error al obtener la lista de coches: ${response.statusCode}");
    }
  }
}