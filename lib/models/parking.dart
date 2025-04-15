class Parking {
  final String vehicle;
  final String space;
  final String startTime;

  Parking({
    required this.vehicle,
    required this.space,
    required this.startTime,
  });

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      vehicle: json['vehicle'],
      space: json['space'],
      startTime: json['startTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle': vehicle,
      'space': space,
      'startTime': startTime,
    };
  }
}
