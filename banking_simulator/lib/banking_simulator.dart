import 'dart:io';
import 'package:banking_simulator/account_class_file.dart';

double getValidAmount(String message) {
  while (true) {
    stdout.write(message);
    String? amountRecieved = stdin.readLineSync();

    double? amount = double.tryParse(amountRecieved ?? '');
    if (amount == null || amount < 0) {
      print('Invalid input. Please enter a positive number');
      continue;
    }
    return amount;
  }
}

bool continueTransaction() {
  late bool continueTranc;
  while (true) {
    stdout.write('Continue Transcation?(Y/n): ');
    String? userChoise = stdin.readLineSync();

    if (userChoise != null && (userChoise == 'n' || userChoise == 'N')) {
      continueTranc = false;
    } else if (userChoise == '' || userChoise == 'y' || userChoise == 'Y') {
      continueTranc = true;
    } else {
      print('Invalid input,please choose if you want to continue');
      continue;
    }
    return continueTranc;
  }
}

Persons createAccount() {
  stdout.write('Enter user name: ');
  String uName = stdin.readLineSync() ?? '';
  stdout.write('Enter account number: ');
  String aNumber = stdin.readLineSync() ?? '';
  double balance = 0;
  return Persons(uName, aNumber, balance);
}
