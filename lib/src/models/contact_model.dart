class ContactModel {
  String firstName;
  String lastName;
  int age;
  int phoneNumber;
  String? email;
  int? id;

  ContactModel({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.phoneNumber,
    this.email,
    this.id,
  });

  ContactModel copyWith({
    String? firstName,
    String? lastName,
    int? age,
    int? phoneNumber,
    String? email,
    int? id,
  }) {
    return ContactModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }
}
