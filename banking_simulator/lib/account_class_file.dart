import 'dart:convert';
import 'dart:io';

abstract class PersonRequirements {
  String? get name;
  String get accountnumber;
  String? get password;
  double get balance;
  List get transactions;
}

class Persons extends PersonRequirements {
  @override
  final String? name;
  @override
  final String accountnumber;
  @override
  final String? password;
  @override
  final double balance;
  @override
  final List transactions;

  Persons(
    this.name,
    this.accountnumber,
    this.password,
    this.balance,
    this.transactions,
  );

  Map<String, dynamic> toJson() => {
    //this is a function called toJson() whcih converts class objects to Map data type
    'name': name,
    'accountnumber': accountnumber,
    'password': password,
    'balance': balance,
    'transactions': transactions,
  };
}

class AccountStorage {
  final File file = File('banking_simulator/data/accounts.txt');

  Future<void> save(Persons person) async {
    List<Map<String, dynamic>> account = [];

    if (await file.exists()) {
      String content = await file.readAsString(); //file is created here

      if (content.trim().isNotEmpty) {
        List<dynamic> decodedData = jsonDecode(content);

        account = decodedData.cast<Map<String, dynamic>>();
      }
    }
    account.add(person.toJson());
    await file.writeAsString(jsonEncode(account));
  }
}

class AccountUpdate {
  final File file = File('banking_simulator/data/accounts.txt');
  Future<void> update(List<Map<String, dynamic>> update) async {
    await file.writeAsString(jsonEncode(update));
  }
}
