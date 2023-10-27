import 'wallet.dart';

class Transaction {
  Wallet sender;
  Wallet reciever;
  int amount;
  Transaction({this.amount, this.sender, this.reciever});
}
