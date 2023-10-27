import 'dart:developer';
import 'dart:typed_data';
import 'package:blockchain_implementation/contanst.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:crypton/crypton.dart';
import 'package:blockchain_implementation/models/wallet.dart';
import 'package:blockchain_implementation/models/transaction.dart';
import 'package:blockchain_implementation/models/block_model.dart';

class Utility {
  static Future<String> generateHash(String message) async {
    var bytes1 = utf8.encode(message); // data being hashed
    var digest1 = sha256.convert(bytes1); // Hashing Process
    print("Digest as bytes: ${digest1.bytes}"); // Print Bytes
    print("Digest as hex string: $digest1");
    return "$digest1";
  }

  static Future<List> mine(String data) async {
    bool mined = false;
    int counter = 0;
    while (!mined) {
      String hash = await generateHash(data + counter.toString());
      print("with noince as $counter hash generated is $hash");
      if (hash.startsWith("0")) {
        mined = !mined;
        return [hash, counter];
      }
      counter += 1;
    }
  }

  static bool verifySignature(
      Uint8List message, Uint8List signature, ECPublicKey key) {
    return key.verifySHA256Signature(message, signature);
  }

  static Uint8List generateSignature(String message, ECPrivateKey key) {
    final encodedMessage = utf8.encode(message);
    final signature = key.createSHA256Signature(encodedMessage as Uint8List);
    print('Signature generated -> ${utf8.decode(signature)}');
    return signature;
  }

  static Future<bool> generateAndVerifySignature(
      String message, Wallet sender, Wallet reciever, int amount) async {
    String hash = await generateHash(message);
    print(sender.privateKey);
    Uint8List signature =
        generateSignature(hash, ECPrivateKey.fromString(sender.privateKey));

    return verifySignature(
        utf8.encode(hash), signature, ECPublicKey.fromString(sender.publicKey));
  }
}
