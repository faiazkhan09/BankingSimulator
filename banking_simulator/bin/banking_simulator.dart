import 'dart:io';
import 'package:banking_simulator/banking_simulator.dart';

double balance = 100.0;
void main() {
  bool input = false;

  while (input == false) {
    print('\n1. Deposit \n2. Withdraw \n3. Check Balance \n0. Exit Program \n');
    stdout.write('Enter the number of your choise:');
    String? choise = stdin.readLineSync();

    if (choise == '1') {
      bool depositContinue = true;
      while (depositContinue == true) {
        double? deposit = getValidAmount('Enter amount to deposit: ');
        balance += deposit;

        depositContinue = continueTransaction();
      }
    } else if (choise == '2') {
      bool withdrawContinue = true;
      while (withdrawContinue == true) {
        double? withdraw = getValidAmount('Enter amount to withdraw: ');
        if (withdraw > balance) {
          print('Insufficient balance. Current account balance: $balance');
          withdrawContinue = true;
        } else {
          balance -= withdraw;
          print(
            '$withdraw taka withdrawn from account. Balance remaining: $balance',
          );
          withdrawContinue = continueTransaction();
        }
      }
    } else if (choise == '3') {
      print('\nChecking Balance...');
      print('\nBalance available: $balance');
      input = false;
    } else if (choise == '0') {
      print('\nExiting Program');
      input = true;
    } else {
      print('\nPlease select which servise you want-');
      input = false;
    }
  }
}
