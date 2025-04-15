import 'package:flutter/material.dart';
import '../models/parking_space.dart';
import '../services/api_service.dart';
import '../widgets/snackbar_popup.dart';

class ParkingSpaceScreen extends StatefulWidget {
  @override
  _ParkingSpaceScreenState createState() => _ParkingSpaceScreenState();
}

class _ParkingSpaceScreenState extends State<ParkingSpaceScreen> {
  final idController = TextEditingController();
  final addressController = TextEditingController();
  final priceController = TextEditingController();
  List<ParkingSpace> spaces = [];

  @override
  void initState() {
    super.initState();
    loadSpaces();
  }

  Future<void> loadSpaces() async {
    final loadedSpaces = await ApiService.getParkingSpaces();
    setState(() {
      spaces = loadedSpaces;
    });
  }

  Future<void> addParkingSpace() async {
    String id = idController.text.trim();
    String address = addressController.text.trim();
    String price = priceController.text.trim();

    if (id.isNotEmpty && address.isNotEmpty && price.isNotEmpty) {
      final space = ParkingSpace(
        id: id,
        address: address,
        pricePerHour: double.tryParse(price) ?? 0.0,
      );
      await ApiService.addParkingSpace(space);
      idController.clear();
      addressController.clear();
      priceController.clear();
      showSnackbar(context, "Parkeringsplats tillagd");
      await loadSpaces();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "🅿️ Hantera parkeringsplatser",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: idController,
            decoration: const InputDecoration(labelText: "ID"),
          ),
          TextField(
            controller: addressController,
            decoration: const InputDecoration(labelText: "Adress"),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: "Pris per timme"),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: addParkingSpace,
            child: const Text("Lägg till parkeringsplats"),
          ),
          const Divider(),
          ...spaces.map((space) => ListTile(
                title: Text(space.address),
                subtitle:
                    Text("Pris: ${space.pricePerHour.toStringAsFixed(2)} kr/h"),
              )),
        ],
      ),
    );
  }
}
