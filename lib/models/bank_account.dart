class BankAccount {
  late final String accountNumber;
  final String holderName;
  double balance = 0.0;
  String? bankBranch;
  

  BankAccount({required this.holderName, this.bankBranch});

  void initializeAccount(String number){
      accountNumber=number;
  }

  bool isAccNumSet() {
    try {
      accountNumber; 
      return true;   
    } catch (e) {
      return false; 
    }
  }
}