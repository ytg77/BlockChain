import 'package:blockchain_implementation/contanst.dart';
import 'package:flutter/foundation.dart';
import 'package:blockchain_implementation/models/wallet.dart';
import 'package:blockchain_implementation/models/block_model.dart';
import 'package:blockchain_implementation/models/transaction.dart';
import 'package:blockchain_implementation/utilities/hash_utility.dart';
import 'package:blockchain_implementation/models/utxo.dart';

class DataProvider extends ChangeNotifier {
  List<Wallet> wallets = [];
  List<Block> blocks = [];

  List<Transaction> utxosList = [];

  Wallet findWalletFromPublicAddress(String publicAddress) {
    //or verifying the digital signature signed by the sender
    for (Wallet wallet in wallets) {
      if (wallet.bitcoinAddress == publicAddress) {
        return wallet;
      }
    }
  }

  Wallet findWalletFromPrivateAddress(String privateKey) {
    for (Wallet wallet in wallets) {
      if (wallet.privateKey == privateKey) {
        return wallet;
      }
    }
  }

  // bool checkSenderUTXO(Wallet sender, Wallet reciever, int amount) {
  //   int unspentAmount = 0;
  //   int iterator = -1;
  //   bool hasEnough = false;

  //   //traverse through all utxos of the sender
  //   for (Transaction transaction
  //       in utxos[findUTXOFRomWallet(sender)].utxosList) {
  //     iterator += 1;
  //     unspentAmount += transaction.amount;
  //     if (unspentAmount >= amount) {
  //       hasEnough = true;
  //       //remove all the utxos from the sender mathcing to the amount
  //       for (int x = 0; x <= iterator; x += 1) {
  //         utxos[findUTXOFRomWallet(sender)].utxosList.removeAt(x);
  //       }
  //       //the remaining amount , sender sends toh himself
  //       int balance = unspentAmount - amount;
  //       if (balance > 0) {
  //         utxos[findUTXOFRomWallet(sender)].utxosList.add(
  //             Transaction(sender: sender, reciever: sender, amount: balance));
  //       }

  //       break;
  //     }
  //   }

  //   notifyListeners();
  //   return hasEnough;
  // }

  void printUtxos() {
    utxosList.forEach((element) {
      print(
          "${element.sender.name} -> ${element.reciever.name} :${element.amount}");
    });
  }

  bool checkSenderUTXO(Wallet sender, Wallet reciever, int amount) {
    int spent = 0;
    int gained = 0;

    for (Transaction transaction in utxosList) {
      if (transaction.sender.bitcoinAddress == sender.bitcoinAddress) {
        spent += transaction.amount;
      }
      if (transaction.reciever.bitcoinAddress == sender.bitcoinAddress) {
        gained += transaction.amount;
      }
    }
    print("Total spent ${spent}");
    print("total unspent ${gained}");
    //double spending detected
    if (gained < amount) {
      print("double spend detected");
      return false;
    }
    //the sender has enough balance
    else {
      int unspent = 0;
      List<int> transactionIndex = [];
      print("before");
      // print("lentgh of utxo is ${utxosList.length}");
      for (Transaction transaction in utxosList) {
        if (transaction.reciever.bitcoinAddress == sender.bitcoinAddress) {
          //calculate total unspent
          unspent += transaction.amount;
          print("unspent is ${unspent}");
          //save the index of the utxo to delete it late
          print("lentgh of utxo is ${utxosList.length}");

          print("------------->>${utxosList.indexOf(transaction)}");
          transactionIndex.add(utxosList.indexOf(transaction));
          if (unspent >= amount) {
            int counter = 0;
            int difference = unspent - amount;
            transactionIndex.forEach((index) {
              utxosList.removeAt(index - counter);
              notifyListeners();
              counter += 1;
            });
            utxosList.add(Transaction(
                sender: sender, reciever: reciever, amount: amount));
            notifyListeners();
            utxosList.add(Transaction(
                sender: sender, reciever: sender, amount: difference));
            notifyListeners();

            return true;
          }
        }
      }
      return true;
    }
  }

  Future<bool> performTransaction(
      String message, Wallet sender, Wallet reciever, int amount) async {
    //Signature Verification
    if (await Utility.generateAndVerifySignature(
        message, sender, reciever, amount)) {
      print("sgnature verified");
      //---Check Sender UTXO
      if (sender.bitcoinAddress != creatorWallet.bitcoinAddress) {
        //if the sender is not the creatot,then check if the sender has enough  to send
        if (!checkSenderUTXO(sender, reciever, amount)) {
          //if the sender does not have enough balance or double spend
          return false;
        }
      } else {
        //if the sender is creator then just add in reciever
        print("creator is sending");
        utxosList.add(
            Transaction(amount: amount, sender: sender, reciever: reciever));
        // updateRecieverUTXO(sender, reciever, amount);
        notifyListeners();
      }
      List result = await Utility.mine(await Utility.generateHash(message));
      Transaction transaction =
          Transaction(sender: sender, reciever: reciever, amount: amount);
      Block block = Block(
        currentBlockHash: result[0],
        noince: result[1],
        data: transaction,
      );
      addBlock(block);
      print("utxo after transaction");
      printUtxos();
      return true;
    } else {
      print("signature verification failed");
      return false;
    }
  }

  // int findUTXOFRomWallet(Wallet wallet) {
  //   for (UTXO utxo in utxos) {
  //     if (utxo.wallet.bitcoinAddress == wallet.bitcoinAddress) {
  //       return utxos.indexOf(utxo);
  //     }
  //   }
  // }

  // void updateRecieverUTXO(Wallet sender, Wallet reciever, int amount) {
  //   // int senderUtxoIndex = findUTXOFRomWallet(sender);
  //   print("-----started");
  //   int recieverUtxoIndex = findUTXOFRomWallet(reciever);
  //   print("-----ended $recieverUtxoIndex");
  //   //remove the transactions from the sender , and add sender->sender if a difference is there.
  //   utxos[recieverUtxoIndex]
  //       .utxosList
  //       .add(Transaction(sender: sender, reciever: reciever, amount: amount));
  //   print("updated");
  //   notifyListeners();
  // }

  void addBlock(Block block) {
    if (blocks.length == 0) {
      //genesis block
      block.blockNumber = 0;
      block.previousHash = "0";
      block.timestamp = "${DateTime.now().microsecondsSinceEpoch}";
    } else {
      block.previousHash = blocks[blocks.length - 1].currentBlockHash;
      block.blockNumber = blocks[blocks.length - 1].blockNumber + 1;
      block.timestamp = "${DateTime.now().microsecondsSinceEpoch}";
    }
    blocks.add(block);
    notifyListeners();
    blocks.forEach((block) {
      print('---------------block data--------');
      print(block.blockNumber);
      print(block.currentBlockHash);
      print(block.data.sender.bitcoinAddress);
      print(block.data.reciever.bitcoinAddress);
      print(block.timestamp);
      print(block.previousHash);
      print(block.noince);
    });
  }

  void addWallet(Wallet wallet) {
    wallets.add(wallet);
    print(wallets.length);
    // utxos.add(UTXO(wallet: wallet, utxosList: []));
    notifyListeners();
    wallets.forEach((element) {
      print(element.bitcoinAddress);
      print(element.name);
      print(element.privateKey);
      print(element.publicKey);
    });
  }
}
