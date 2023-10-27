import 'transaction.dart';

class Block {
  int blockNumber;
  String timestamp;
  int noince;
  String previousHash;
  String currentBlockHash;
  Transaction data;
  Block({
    this.blockNumber,
    this.currentBlockHash,
    this.noince,
    this.previousHash,
    this.timestamp,
    this.data,
  });
}
