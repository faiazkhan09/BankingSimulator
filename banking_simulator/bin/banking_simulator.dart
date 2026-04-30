import 'dart:io';

double balance = 0;
void main() {
  bool input = false;

  while (input == false) {
    print('\n1. Deposit \n2. Withdraw \n3. Check Balance \n0. Exit Program \n');
    stdout.write('Enter the number of your choise:');
    String? choise = stdin.readLineSync();

    if (choise == '1') {
      bool depositConti = true;
      while (depositConti == true) {
        stdout.write('\nEnter the amount to deposit:');
        String? amountD = stdin.readLineSync();

        if (amountD != null) {
          double? amountDT = double.tryParse(
            amountD,
          ); //instead of using .Parse which would try to parse actual string into double, we can use tryParse,which would return null if it can't successfully parse.
          if (amountDT == null) {
            print('Invalid input! Please enter a numner');
            depositConti = true;
          } else if (amountDT > 0) {
            balance += amountDT;
            print('\nAmount Deposited');

            bool depositTransacConti = true;
            while (depositTransacConti == true) {
              stdout.write(
                '\nContinue Trancaction?(Y/n)',
              ); // enter to continue, type n to go back to home and anything else gives the massage invalid input and asks again
              String? conChoise = stdin.readLineSync();

              if (conChoise != null && conChoise == 'n') {
                depositTransacConti = false;
                depositConti = false;
              } else if (conChoise == '' ||
                  conChoise == 'Y' ||
                  conChoise == 'y') {
                depositConti = true;
                depositTransacConti = false;
              } else {
                print('Invalid input, please provide correct input!');
                depositTransacConti = true;
              }
            }
          } else if (amountDT < 0) {
            print('Enter amount greater than 0');
            depositConti = true;
          }
        } else {
          print('No iput provided!');
          depositConti = true;
        }
      }
    } else if (choise == '2') {
      bool withdrawConti = true;
      while (withdrawConti == true) {
        stdout.write('Enter amount to withdraw: ');
        String? amountW = stdin.readLineSync();

        if (amountW != null) {
          double? amountWW = double.tryParse(amountW);

          if (amountWW == null || amountWW < 0) {
            print('Invalid input. Please enter a positive amount');
            withdrawConti = true;
          } else if (amountWW > 0) {
            balance -= amountWW;
            print(
              '$amountWW amount withdrawn from account. Remaining balance: $balance',
            );

            bool withdrawTransacConti = true;
            while (withdrawTransacConti == true) {
              stdout.write(
                '\nContinue Trancaction?(Y/n)',
              ); // enter to continue, type n to go back to home and anything else gives the massage invalid input and asks again
              String? conChoise = stdin.readLineSync();

              if (conChoise != null && conChoise == 'n') {
                withdrawTransacConti = false;
                withdrawConti = false;
              } else if (conChoise == '' ||
                  conChoise == 'Y' ||
                  conChoise == 'y') {
                withdrawConti = true;
                withdrawTransacConti = false;
              } else {
                print('Invalid input, please provide correct input!');
                withdrawTransacConti = true;
              }
            }
          } else if (amountWW > balance) {
            print('Insufficient balance, account balance is: $balance');
          }
        } else {
          print('Invalid input');
          withdrawConti = true;
        }
      }
    } else if (choise == '3') {
      print('\nChecking Balance...');
      print('Balance available: $balance');
      input = false;
    } else if (choise == '0') {
      print('Exiting Program');
      input = true;
    } else {
      print('Whatever');
      input = false;
    }
  }
}
