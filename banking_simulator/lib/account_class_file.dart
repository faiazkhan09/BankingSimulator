abstract class PersonRequirements {
  String get name;
  String get accountnumber;
  double get balance;
}

class Persons extends PersonRequirements {
  @override
  final String name;
  @override
  final String accountnumber;
  @override
  final double balance;

  Persons(this.name, this.accountnumber, this.balance);
}
