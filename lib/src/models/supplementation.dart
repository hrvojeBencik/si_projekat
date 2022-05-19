List<Supplementation> getSupplementationsFromJson(Iterable data) {
  return List<Supplementation>.from(data.map((model) => Supplementation.fromJson(model)));
}

class Supplementation {
  final String? id;
  final String plotId;
  final String userFirebaseId;
  final DateTime date;
  final String quantity;
  final String type;
  final String? comment;

  Supplementation({
    this.id,
    required this.plotId,
    required this.userFirebaseId,
    required this.date,
    required this.quantity,
    required this.type,
    this.comment,
  });

  factory Supplementation.fromJson(Map<String, dynamic> data) {
    return Supplementation(
      id: data['_id'],
      plotId: data['plotId'],
      userFirebaseId: data['userId'],
      date: DateTime.parse(data['date']),
      quantity: data['amount'],
      type: data['type'],
      comment: data['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plotId': plotId,
      'userId': userFirebaseId,
      'date': date.toIso8601String(),
      'amount': quantity,
      'type': type,
      'comment': comment,
    };
  }
}
