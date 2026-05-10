import 'dart:io';
import 'dart:convert';
import 'dart:math';
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
  int min = 100000;
  int randomint = min + Random().nextInt(899999);
  String randomString = randomint.toString();
  stdout.write('Enter user name: ');
  String uName = stdin.readLineSync() ?? '';
  String aNumber = randomString;
  double balance = 0;
  List transactions = [];
  return Persons(uName, aNumber, balance, transactions);
}

//Reads text file and returns a List containing Maps of user profiles
Future<List<Map<String, dynamic>>> readAccountInfo() async {
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
  for (var account in accountDetails) {
    if (account['accountnumber'] == accnum) {
      print('\nAccount found $account');
      bool continueViewAccount = true;
      while (continueViewAccount == true) {
        print('\n1. Deposit \n2. Withdraw \n0. Exit');
        stdout.write('\nEnter the number of your choise:');
        String? choise = stdin.readLineSync();
        if (choise == '1') {
          depositIntoAccount(account);
          await accountUpdate.update(accountDetails);
          continueViewAccount = true;
        } else if (choise == '2') {
          withdrawFromAccount(account);
          await accountUpdate.update(accountDetails);
          continueViewAccount = true;
        } else if (choise == '3') {
          print('\n${account['transactions']}');
          continueViewAccount = true;
        } else if (choise == '0') {
          continueViewAccount = false;
        } else {
          print('\nPlease enter a valid choise.');
          continueViewAccount = true;
        }
      }
    }
  }
}

void depositIntoAccount(Map<String, dynamic> account) {
  bool depositContinue = true;
  while (depositContinue == true) {
    double? deposit = getValidAmount('\nEnter amount to deposit: ');
    account['balance'] += deposit;
    print(account);
    account['transactions'].add('Deposited: $deposit');
    depositContinue = continueTransaction();
  }
}

void withdrawFromAccount(Map<String, dynamic> account) {
  bool withdrawContinue = true;
  while (withdrawContinue == true) {
    double? withdraw = getValidAmount('\nEnter amount to withdraw: ');
    if (withdraw > account['balance']) {
      print(
        '\nInsufficient balance. Current account balance: ${account['balance']}',
      );
      withdrawContinue = true;
    } else {
      account['balance'] -= withdraw;
      print(
        'Taka $withdraw has been withdrawn from ${account['accountnumber']}. Remaining balance ${account['balance']}',
      );
      account['transactions'].add('Deposited: $withdraw');

      withdrawContinue = continueTransaction();
    }
  }
}
