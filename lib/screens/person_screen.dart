import 'package:flutter/material.dart';
import '../models/person.dart';
import '../services/api_service.dart';

class PersonScreen extends StatefulWidget {
  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  final nameController = TextEditingController();
  final personalNumberController = TextEditingController();

  List<Person> persons = [];

  @override
  void initState() {
    super.initState();
    loadPersons();
  }

  Future<void> loadPersons() async {
    persons = await ApiService.getPersons();
    setState(() {});
  }

  Future<void> addPerson() async {
    final name = nameController.text;
    final pn = personalNumberController.text;
    if (name.isNotEmpty && pn.isNotEmpty) {
      final person = Person(name: name, personalNumber: pn);
      await ApiService.addPerson(person);
      nameController.clear();
      personalNumberController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Person tillagd")));
      await loadPersons();
    }
  }

  Future<void> deletePerson(String personalNumber) async {
    await ApiService.deletePerson(personalNumber);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Person raderad")));
    await loadPersons();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Lägg till ny person", style: TextStyle(fontSize: 18)),
        TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Namn")),
        TextField(
            controller: personalNumberController,
            decoration: const InputDecoration(labelText: "Personnummer")),
        ElevatedButton(onPressed: addPerson, child: const Text("Lägg till")),
        const Divider(),
        const Text("Alla personer", style: TextStyle(fontSize: 18)),
        ...persons.map((p) => ListTile(
              title: Text(p.name),
              subtitle: Text(p.personalNumber),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deletePerson(p.personalNumber),
              ),
            )),
      ],
    );
  }
}
