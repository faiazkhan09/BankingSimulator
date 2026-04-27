import 'dart:io';
void main(){

  bool input = false;

  while(input == false){
    print('1. Deposit \n2. Withdraw \n3. Check Balance \n0. Exit Program \nEnter the number of your choise:');
    String? choise = stdin.readLineSync();
     if(choise == '1'){
    print('Checking Deposit');
    input = true;
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
