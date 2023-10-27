import 'package:flutter/material.dart';
import 'package:blockchain_implementation/models/wallet.dart';
import 'package:provider/provider.dart';
import 'package:blockchain_implementation/providers/data_provider.dart';
import 'package:blockchain_implementation/utilities/hash_utility.dart';
import 'package:blockchain_implementation/widgets/custom_button.dart';
import 'package:blockchain_implementation/contanst.dart';
import 'package:crypton/crypton.dart';
import 'package:blockchain_implementation/models/wallet.dart';
import 'package:blockchain_implementation/models/block_model.dart';
import 'package:blockchain_implementation/models/transaction.dart';
import 'package:blockchain_implementation/widgets/wallet_ref.dart';
import 'package:toast/toast.dart';
import 'package:blockchain_implementation/widgets/custom_drawer.dart';

class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  String senderPrivateKey;
  String recieverAddress;
  String amount;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Pay Coins")),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          margin: EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              TextField(
                style: ktextStyle,
                decoration: customDecotation.copyWith(
                    labelText: "Enter Reciever Address"),
                onChanged: (String value) {
                  setState(() {
                    recieverAddress = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                style: ktextStyle,
                decoration:
                    customDecotation.copyWith(labelText: "Enter Amount "),
                onChanged: (String value) {
                  setState(() {
                    amount = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                style: ktextStyle,
                decoration: customDecotation.copyWith(
                    labelText: "Enter Your Private Key "),
                onChanged: (String value) {
                  setState(() {
                    senderPrivateKey = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              CustomButton(
                text: "Pay ",
                handleTap: () async {
                  print("---transaction started");
                  Wallet reciever =
                      provider.findWalletFromPublicAddress(recieverAddress);
                  Wallet sender =
                      provider.findWalletFromPrivateAddress(senderPrivateKey);

                  if (await provider.performTransaction(
                      "$senderPrivateKey + $recieverAddress + $amount",
                      sender,
                      reciever,
                      int.parse(amount))) {
                    Toast.show(
                        "Transaction Succesful, sent $amount from ${sender.name} to ${reciever.name}",
                        context,
                        duration: 10,
                        textColor: Colors.white,
                        backgroundColor: Colors.black,
                        gravity: Toast.CENTER);
                  } else {
                    Toast.show("Oops Something went Wrong!!", context,
                        duration: 5,
                        textColor: Colors.white,
                        backgroundColor: Colors.black,
                        gravity: Toast.CENTER);
                  }
                },
              ),
              Text(
                'Wallets Available for reference ',
                style: ktextStyle,
              ),
              SizedBox(
                height: 30.0,
              ),
              WalletRefernce()
            ],
          ),
        ),
      ),
    );
  }
}
