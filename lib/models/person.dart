class Person {
  final String name;
  final String personalNumber;

  Person({required this.name, required this.personalNumber});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      personalNumber: json['personalNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'personalNumber': personalNumber,
    };
  }
}
