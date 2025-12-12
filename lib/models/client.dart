

class Client {
  final int id;
  final String name;
  final String phone;
  final String lastVisit;
  final String lensesType;
  final String price;
  final String notes;
  final int age;

  Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.lastVisit,
    required this.lensesType,
    required this.age,
    required this.price,
    required this.notes,
  });


  // 1. Convert Object to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'lastVisit': lastVisit,
      'lensesType': lensesType,
      'age': age,
      'price': price,
      'notes': notes,
    };
  }

  // 2. Convert JSON (Map) to Object
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      lastVisit: json['lastVisit'] ?? '',
      lensesType: json['lensesType'] ?? '',
      age: json['age'] ?? 0,
      price: json['price'] ?? '',
      notes: json['notes'] ?? '',
    );
  }
}
