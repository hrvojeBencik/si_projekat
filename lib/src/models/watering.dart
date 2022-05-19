List<Watering> getWateringsFromJson(Iterable data) {
  return List<Watering>.from(data.map((model) => Watering.fromJson(model)));
}

class Watering {
  final String? id;
  final String plotId;
  final String userFirebaseId;
  final DateTime date;
  final String quantity;
  final String type;
  final String? comment;

  Watering({
    this.id,
    required this.plotId,
    required this.userFirebaseId,
    required this.date,
    required this.quantity,
    required this.type,
    this.comment,
  });

  factory Watering.fromJson(Map<String, dynamic> data) {
    return Watering(
      id: data['_id'],
      plotId: data['plotId'],
      userFirebaseId: data['userId'],
      date: DateTime.parse(data['date']),
      quantity: data['quantity'],
      type: data['type'],
      comment: data['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plotId': plotId,
      'userId': userFirebaseId,
      'date': date.toIso8601String(),
      'quantity': quantity,
      'type': type,
      'comment': comment,
    };
  }
}
