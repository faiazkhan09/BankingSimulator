import 'dart:io';

int balance = 0;
void main(){

  bool input = false;
  

  while(input == false){
    print('1. Deposit \n2. Withdraw \n3. Check Balance \n0. Exit Program \n');
    stdout.write('Enter the number of your choise:');
    String? choise = stdin.readLineSync();
    
    if(choise == '1'){
      stdout.write('Enter the amount to deposit:');
      String? amountD = stdin.readLineSync();

      if(amountD != null){
        int amountDT = int.parse(amountD);
        if(amountDT > 0){
          balance += amountDT;
          print('Amount Deposited');
          stdout.write('Continue Trancaction?(Y/n)');// enter to continue, type n to go back to home and anything else gives the massage invalid input and asks again
          String? conChoise = stdin.readLineSync();
          if(conChoise != null && conChoise == 'n'){
            input = true;
          }
          else{
            input = true;
          }
        }
      }
      else{
        print('No number provided. Going back to home page.');
        input = false;
      }
    }
    
    else if(choise == '2'){
      print('checking Withdrawal');
      input = true;
    }
    else if(choise == '3'){
      print('Checking Balance');
      input = true;
    }
    else if(choise == '0'){
      print('Exiting Program');
      input = true;
    }
    else{
      print('Whatever');
      input = false;
    }
  }
}
