import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../services/api_service.dart';

class VehicleScreen extends StatefulWidget {
  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final regNumController = TextEditingController();
  final typeController = TextEditingController();
  final ownerController = TextEditingController();
  List<Vehicle> vehicles = [];

  @override
  void initState() {
    super.initState();
    loadVehicles();
  }

  Future<void> loadVehicles() async {
    vehicles = await ApiService.getVehicles();
    setState(() {});
  }

  Future<void> addVehicle() async {
    final reg = regNumController.text;
    final type = typeController.text;
    final owner = ownerController.text;

    if (reg.isNotEmpty && type.isNotEmpty && owner.isNotEmpty) {
      final v = Vehicle(registrationNumber: reg, type: type, owner: owner);
      await ApiService.addVehicle(v);
      regNumController.clear();
      typeController.clear();
      ownerController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fordon tillagt")));
      await loadVehicles();
    }
  }

  Future<void> deleteVehicle(String regNum) async {
    await ApiService.deleteVehicle(regNum);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Fordon raderat")));
    await loadVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Lägg till fordon", style: TextStyle(fontSize: 18)),
        TextField(
            controller: regNumController,
            decoration:
                const InputDecoration(labelText: "Registreringsnummer")),
        TextField(
            controller: typeController,
            decoration: const InputDecoration(labelText: "Typ")),
        TextField(
            controller: ownerController,
            decoration:
                const InputDecoration(labelText: "Personnummer på ägaren")),
        ElevatedButton(onPressed: addVehicle, child: const Text("Lägg till")),
        const Divider(),
        const Text("Alla fordon", style: TextStyle(fontSize: 18)),
        ...vehicles.map((v) => ListTile(
              title: Text(v.registrationNumber),
              subtitle: Text("${v.type} • Ägare: ${v.owner}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteVehicle(v.registrationNumber),
              ),
            )),
      ],
    );
  }
}
