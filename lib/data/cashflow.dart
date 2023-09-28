class CashFlow {
  final int id;
  final int user_id;
  final String date;
  final int nominal;
  final String description;
  final String status;

  CashFlow({
    required this.id,
    required this.user_id,
    required this.date,
    required this.nominal,
    required this.description,
    required this.status,
  });

  factory CashFlow.fromJson(Map<String, dynamic> json) {
    return CashFlow(
      id: json['id'],
      user_id: json['user_id'],
      date: json['date'],
      nominal: json['nominal'],
      description: json['description'],
      status: json['status'], // Konversi dari integer ke boolean
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'date': date,
      'nominal': nominal,
      'description': description,
      'status': status, // Konversi dari boolean ke integer
    };
  }
}
