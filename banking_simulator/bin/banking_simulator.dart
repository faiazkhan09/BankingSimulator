import 'dart:io';
import 'package:banking_simulator/banking_simulator.dart';

double balance = 100.0;
final List<String> _transaction = [];
void main() async {
  bool input = false;

  while (input == false) {
    print(
      '\n1. Create account \n2. Deposit \n3. Withdraw \n4. Check Balance \n5. View Transaction History \n0. Exit Program \n',
    );
    stdout.write('Enter the number of your choise:');
    String? choise = stdin.readLineSync();

    if (choise == '1') {
      final file = File(r'..\lib\raccount_details.txt');

      // try{
      //   await file.wri;
      // }
    }

    if (choise == '2') {
      bool depositContinue = true;
      while (depositContinue == true) {
        double? deposit = getValidAmount('Enter amount to deposit: ');
        balance += deposit;
        print('$deposit deposited into account. Current balance is: $balance');
        _transaction.add('Deposited: $deposit');

        depositContinue = continueTransaction();
      }
    } else if (choise == '3') {
      bool withdrawContinue = true;
      while (withdrawContinue == true) {
        double? withdraw = getValidAmount('Enter amount to withdraw: ');
        if (withdraw > balance) {
          print('Insufficient balance. Current account balance: $balance');
          withdrawContinue = true;
        } else {
          balance -= withdraw;
          _transaction.add('Withdrawn: $withdraw');
          print(
            '$withdraw taka withdrawn from account. Balance remaining: $balance',
          );
          withdrawContinue = continueTransaction();
        }
      }
    } else if (choise == '4') {
      print('\nChecking Balance...');
      print('\nBalance available: $balance');
      input = false;
    } else if (choise == '5') {
      for (var t in _transaction) {
        print(t);
      }
    } else if (choise == '0') {
      print('\nExiting Program');
      input = true;
    } else {
      print('\nPlease select which servise you want-');
      input = false;
    }
  }
}
