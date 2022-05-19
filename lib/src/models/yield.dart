List<Yield> getYieldsFromJson(Iterable data) {
  return List<Yield>.from(data.map((model) => Yield.fromJson(model)));
}

enum YieldType {
  income,
  expense,
}

class Yield {
  final String? id;
  final String plotId;
  final String userFirebaseId;
  final DateTime date;
  final String amount;
  final String income;
  final String expense;
  final String? comment;

  Yield({
    this.id,
    required this.plotId,
    required this.userFirebaseId,
    required this.date,
    required this.amount,
    required this.income,
    required this.expense,
    this.comment,
  });

  factory Yield.fromJson(Map<String, dynamic> data) {
    return Yield(
      id: data['_id'],
      plotId: data['plotId'],
      userFirebaseId: data['userId'],
      date: DateTime.parse(data['date']),
      amount: data['amount'],
      income: data['income'],
      expense: data['expense'],
      comment: data['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plotId': plotId,
      'userId': userFirebaseId,
      'date': date.toIso8601String(),
      'amount': amount,
      'income': income,
      'expense': expense,
      'comment': comment,
    };
  }
}
