List<Tillage> getTillagesFromJson(Iterable data) {
  return List<Tillage>.from(data.map((model) => Tillage.fromJson(model)));
}

class Tillage {
  final String? id;
  final String plotId;
  final String userFirebaseId;
  final DateTime date;
  final String quantity;
  final String type;
  final String? comment;

  Tillage({
    this.id,
    required this.plotId,
    required this.userFirebaseId,
    required this.date,
    required this.quantity,
    required this.type,
    this.comment,
  });

  factory Tillage.fromJson(Map<String, dynamic> data) {
    return Tillage(
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
