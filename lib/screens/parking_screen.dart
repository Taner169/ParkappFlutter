import 'package:flutter/material.dart';
import '../models/parking.dart';
import '../services/api_service.dart';

class ParkingScreen extends StatefulWidget {
  @override
  _ParkingScreenState createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  final vehicleController = TextEditingController();
  final spaceController = TextEditingController();
  List<Parking> parkings = [];

  @override
  void initState() {
    super.initState();
    loadParkings();
  }

  Future<void> loadParkings() async {
    parkings = await ApiService.getParkings();
    setState(() {});
  }

  Future<void> startParking() async {
    final vehicle = vehicleController.text;
    final space = spaceController.text;

    if (vehicle.isNotEmpty && space.isNotEmpty) {
      final parking = Parking(
          vehicle: vehicle,
          space: space,
          startTime: DateTime.now().toIso8601String());
      await ApiService.addParking(parking);
      vehicleController.clear();
      spaceController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Parkering startad")));
      await loadParkings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Starta parkering", style: TextStyle(fontSize: 18)),
        TextField(
            controller: vehicleController,
            decoration: const InputDecoration(labelText: "Fordon")),
        TextField(
            controller: spaceController,
            decoration: const InputDecoration(labelText: "Parkeringsplats")),
        ElevatedButton(onPressed: startParking, child: const Text("Starta")),
        const Divider(),
        const Text("Historik", style: TextStyle(fontSize: 18)),
        ...parkings.map((p) => ListTile(
              title: Text("Fordon: ${p.vehicle}"),
              subtitle: Text("Plats: ${p.space}\nTid: ${p.startTime}"),
            )),
      ],
    );
  }
}
