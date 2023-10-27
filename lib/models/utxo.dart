import 'transaction.dart';
import 'wallet.dart';

class UTXO {
  Wallet wallet;
  List<Transaction> utxosList;
  UTXO({this.utxosList, this.wallet});
}
