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

//Reads text file and returns a List containing Maps of user profiles
Future<List> readAccountInfo() async {
  final accountInfo = File('banking_simulator/data/accounts.txt');
  try {
    if (await accountInfo.exists()) {
      String content = await accountInfo.readAsString();

      if (content.trim().isEmpty) {
        return [];
      }
      List<Map<String, dynamic>> account = [];
      List<dynamic> decodedData = jsonDecode(content);

      account = decodedData.cast<Map<String, dynamic>>();

      return account;
    }
  } catch (e) {
    print('NO file');
    return [];
  }
  return [];
}

Future<void> compareAccount(String? accnum) async {
  final accountUpdate = AccountUpdate();
  var accountDetails = await readAccountInfo();
  List<Map<String, dynamic>> accountDetailsList = [];
  accountDetailsList = accountDetails.cast<Map<String, dynamic>>();
  for (var account in accountDetailsList) {
    if (account['accountnumber'] == accnum) {
      print('Account found $account');
      print('\n1. Deposti \n2. Withdraw');
      stdout.write('\nEnter the number of your choise:');
      String? choise = stdin.readLineSync();
      if (choise == '1') {
        double? deposit = getValidAmount('\nEnter amount to deposit: ');
        account['balance'] += deposit;
        print('$account');
        await accountUpdate.update(accountDetailsList);
      } else if (choise == '2') {
        double? withdraw = getValidAmount('Enter amount to withdraw: ');
        account['balance'] -= withdraw;
        print('$account');
        await accountUpdate.update(accountDetailsList);
      }
    }
  }
}
