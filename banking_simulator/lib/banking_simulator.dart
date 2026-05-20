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
  String? uName;
  String? uPassword;
  while ((uName == null || uName == '') ||
      (uPassword == null || uPassword == '')) {
    stdout.write('Enter user name: ');
    uName = stdin.readLineSync() ?? '';
    stdout.write('Enter password: ');
    uPassword = stdin.readLineSync() ?? '';
    if (uName == '' || uPassword == '') {
      print('Error with Username or Password');
    }
  }
  String aNumber = randomString;
  double balance = 0;
  List transactions = [];
  return Persons(uName, aNumber, uPassword, balance, transactions);
}

//Reads text file and returns a List containing Maps of user profiles
Future<List<Map<String, dynamic>>> readAccountInfo() async {
  final accountInfo = File('banking_simulator/data/accounts.txt');
  try {
    if (await accountInfo.exists()) {
      String content = await accountInfo
          .readAsString(); //file reading happens here

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
  for (var account1 in accountDetails) {
    if (account1['accountnumber'] == accnum) {
      bool correctPass = false;
      while (correctPass == false) {
        stdout.write('Enter password:');
        String? pass = stdin.readLineSync() ?? ' ';
        if (account1['password'] == pass) {
          print(
            '\nAccount found-- \nName: ${account1['name']}\nAccount Number: ${account1['accountnumber']}\nBalance: ${account1['balance']}',
          );
          bool continueViewAccount = true;
          while (continueViewAccount == true) {
            print(
              '\n1. Deposit \n2. Withdraw \n3. View transactions \n4. Transfer to another account \n0. Exit',
            );
            stdout.write('\nEnter the number of your choise:');
            String? choise = stdin.readLineSync();
            if (choise == '1') {
              depositIntoAccount(account1);
              await accountUpdate.update(accountDetails);
              continueViewAccount = true;
            } else if (choise == '2') {
              withdrawFromAccount(account1);
              await accountUpdate.update(accountDetails);
              continueViewAccount = true;
            } else if (choise == '3') {
              print('\n${account1['transactions']}');
              continueViewAccount = true;
            } else if (choise == '4') {
              stdout.write('Enter account number: ');
              String? accnum2 = stdin.readLineSync();
              for (var account2 in accountDetails) {
                if (account2['accountnumber'] == accnum2) {
                  transferBalance(account1, account2);
                  await accountUpdate.update(accountDetails);
                }
              }
            } else if (choise == '0') {
              continueViewAccount = false;
            } else {
              print('\nPlease enter a valid choise.');
              continueViewAccount = true;
            }
          }
          correctPass = true;
        } else if (account1['password'] == 'x' || account1['password'] == '0') {
          correctPass = true; // needs to be fixed
          break;
        } else {
          print('Incorrect password. Please enter correct passowrd!');
          correctPass = false;
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

void transferBalance(
  Map<String, dynamic> account1,
  Map<String, dynamic> account2,
) {
  bool transferContinue = true;
  while (transferContinue == true) {
    double? transfer = getValidAmount('\nEnter amount to deposit: ');
    if (account1['balance'] > transfer) {
      account1['balance'] -= transfer;
      account2['balance'] += transfer;
      account1['transactions'].add(
        'Transfered $transfer to account: ${account2['accountnumber']}, ${account2['name']}',
      );
      account2['transactions'].add(
        'Recieved $transfer from account: ${account1['accountnumber']}, ${account1['name']}',
      );
      transferContinue = continueTransaction();
    } else {
      print(
        '\nInsufficient balance. Current account balance: ${account1['balance']}',
      );
      transferContinue = true;
    }
  }
}
