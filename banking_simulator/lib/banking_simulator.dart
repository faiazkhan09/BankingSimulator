import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
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

Future<List> readAccountInfo() async {
  final accountInfo = File('banking_simulator/data/accounts.txt');
  try {
    if (await accountInfo.exists()) {
      String accountDetails = await accountInfo
          .readAsString(); //Json data is saved as String
      List<String> lines = accountDetails.split('\n'); //
      List<Map<String, dynamic>> userDetails = [];
      for (var line in lines) {
        if (line.trim().isEmpty) continue;
        var map = jsonDecode(line);
        userDetails.add(map);
      }
      return userDetails;
    } else {
      return [];
    }
  } catch (e) {
    print('NO file');
    return [];
  }
}

Future<void> compareAccount(String? accnum) async {
  var accountDetails = await readAccountInfo();
  for (var account in accountDetails) {
    if (account['accountnumber'] == accnum) {
      print('Account found $account');
      print('\n1. Deposti \n2. Withdraw');
      stdout.write('\nEnter the number of your choise:');
      String? choise = stdin.readLineSync();
      if (choise == '1') {
        double? deposit = getValidAmount('\nEnter amount to deposit: ');
        account['balance'] += deposit;
        print('$account');
      } else if (choise == '2') {
        double? withdraw = getValidAmount('Enter amount to withdraw: ');
        account['balance'] -= withdraw;
        print('$account');
      }
    }
  }
}
