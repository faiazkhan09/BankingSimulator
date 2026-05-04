import 'dart:convert';
import 'dart:io';

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

  Map<String, dynamic> toJson() => {
    'name': name,
    'accountnumber': accountnumber,
    'balance': balance,
  };
}

class AccountStorage {
  final File file = File('banking_simulator/data/accounts.txt');

  Future<void> save(Persons person) async {
    await file.writeAsString(
      '${jsonEncode(person.toJson())}\n',
      mode: FileMode.append,
    );
  }
}
