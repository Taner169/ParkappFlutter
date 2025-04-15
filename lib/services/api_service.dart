import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/person.dart';
import '../models/vehicle.dart';
import '../models/parking.dart';
import '../models/parking_space.dart';

class ApiService {
  // OBS! Använd 10.0.2.2 för att nå din dator från en emulator/simulator
  static const String baseUrl = 'http://192.168.50.129:8080/api';

  // 👤 PERSONER
  static Future<List<Person>> getPersons() async {
    final response = await http.get(Uri.parse('$baseUrl/persons'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Person.fromJson(e)).toList();
    } else {
      throw Exception("Misslyckades att hämta personer");
    }
  }

  static Future<void> addPerson(Person person) async {
    final response = await http.post(
      Uri.parse('$baseUrl/persons'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(person.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Misslyckades att lägga till person");
    }
  }

  static Future<void> deletePerson(String personalNumber) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/persons/$personalNumber'));
    if (response.statusCode != 200) {
      throw Exception("Misslyckades att ta bort person");
    }
  }

  // 🚘 FORDON
  static Future<List<Vehicle>> getVehicles() async {
    final response = await http.get(Uri.parse('$baseUrl/vehicles'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Vehicle.fromJson(e)).toList();
    } else {
      throw Exception("Misslyckades att hämta fordon");
    }
  }

  static Future<void> addVehicle(Vehicle vehicle) async {
    final response = await http.post(
      Uri.parse('$baseUrl/vehicles'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(vehicle.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Misslyckades att lägga till fordon");
    }
  }

  static Future<void> deleteVehicle(String regNumber) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/vehicles/$regNumber'));
    if (response.statusCode != 200) {
      throw Exception("Misslyckades att ta bort fordon");
    }
  }

  // 🅿️ PARKERINGAR
  static Future<List<Parking>> getParkings() async {
    final response = await http.get(Uri.parse('$baseUrl/parkings'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Parking.fromJson(e)).toList();
    } else {
      throw Exception("Misslyckades att hämta parkeringar");
    }
  }

  static Future<void> addParking(Parking parking) async {
    final response = await http.post(
      Uri.parse('$baseUrl/parkings'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(parking.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Misslyckades att starta parkering");
    }
  }

  // 📍 PARKERINGSPLATSER
  static Future<List<ParkingSpace>> getParkingSpaces() async {
    final response = await http.get(Uri.parse('$baseUrl/parkingspaces'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => ParkingSpace.fromJson(e)).toList();
    } else {
      throw Exception("Misslyckades att hämta platser");
    }
  }

  static Future<void> addParkingSpace(ParkingSpace space) async {
    final response = await http.post(
      Uri.parse('$baseUrl/parkingspaces'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(space.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Misslyckades att lägga till plats");
    }
  }
}
