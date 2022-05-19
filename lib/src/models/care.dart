List<Care> getCaresFromJson(Iterable data) {
  return List<Care>.from(data.map((model) => Care.fromJson(model)));
}

class Care {
  final String? id;
  final String plotId;
  final String userFirebaseId;
  final DateTime date;
  final String quantity;
  final String type;
  final String? comment;

  Care({
    this.id,
    required this.plotId,
    required this.userFirebaseId,
    required this.date,
    required this.quantity,
    required this.type,
    this.comment,
  });

  factory Care.fromJson(Map<String, dynamic> data) {
    return Care(
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
