class Contact {
  int? id;
  String name;
  String phone;

  Contact({this.id, required this.name, required this.phone});

  factory Contact.fromMap(Map<String, dynamic> opi) =>
      Contact(id: opi["id"], name: opi['name'], phone: opi['phone']);
  Map<String, dynamic> toMap() => {"id": id, "name": name, "phone": phone};
}
