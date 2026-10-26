class User{
  final String name;
  final int? age;
  String? email;

  User({required this.name, this.age, this.email});

  String getDisplayAge() =>
        age == null ? 'Age not specified' : '$age';
}