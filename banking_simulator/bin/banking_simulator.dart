import 'dart:io';
import 'package:banking_simulator/account_class_file.dart';
import 'package:banking_simulator/banking_simulator.dart';

double balance = 100.0;
//final List<String> _transaction = [];
void main() async {
  bool input = false;

  while (input == false) {
    print('\n1. Create account \n2. Log into account \n0. Exit Program \n');
    stdout.write('Enter the number of your choise:');
    String? choise = stdin.readLineSync();

    if (choise == '1') {
      try {
        final account = createAccount();
        final storage = AccountStorage();

        await storage.save(account);
        print('\nAccount created');
      } catch (e) {
        print('Could not create your account! Please try again');
      }
    } else if (choise == '2') {
      stdout.write('Enter account number:');
      String? accnum = stdin.readLineSync();
      await compareAccount(accnum);
    } else if (choise == '0') {
      print('\nExiting Program');
      input = true;
    } else {
      print('\nPlease select which servise you want-');
      input = false;
    }
  }
}
