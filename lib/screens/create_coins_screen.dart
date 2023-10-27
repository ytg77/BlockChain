import 'package:blockchain_implementation/models/wallet.dart';
import 'package:flutter/material.dart';
import 'package:blockchain_implementation/contanst.dart';
import 'package:blockchain_implementation/widgets/custom_button.dart';
import 'package:blockchain_implementation/utilities/hash_utility.dart';
import 'package:crypton/crypton.dart';
import 'package:provider/provider.dart';
import 'package:blockchain_implementation/providers/data_provider.dart';
import 'package:blockchain_implementation/models/wallet.dart';
import 'package:blockchain_implementation/widgets/wallet_ref.dart';
import 'package:toast/toast.dart';
import 'landing_screen.dart';
import 'package:blockchain_implementation/widgets/custom_drawer.dart';

class CreatreCoinsScreen extends StatefulWidget {
  @override
  _CreatreCoinsScreenState createState() => _CreatreCoinsScreenState();
}

class _CreatreCoinsScreenState extends State<CreatreCoinsScreen> {
  bool isProcessing = false;
  String recieverAddress;
  String amount;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Createa Coins")),
      drawer: CustomDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        margin: EdgeInsets.only(top: 10.0),
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
              decoration: customDecotation.copyWith(labelText: "Enter Amount "),
              onChanged: (String value) {
                setState(() {
                  amount = value;
                });
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            CustomButton(
                text: isProcessing ? "transaction Started" : "Pay ",
                handleTap: () async {
                  setState(() {
                    isProcessing = !isProcessing;
                  });
                  print("---transaction started");
                  Wallet recieverWallet =
                      provider.findWalletFromPublicAddress(recieverAddress);
                  if (await provider.performTransaction(
                      "${creatorWallet.privateKey} + $recieverAddress + $amount",
                      creatorWallet,
                      recieverWallet,
                      int.parse(amount))) {
                    Toast.show(
                        "Transaction Succesful, sent $amount from Creator to ${recieverWallet.name}",
                        context,
                        duration: 5,
                        textColor: Colors.white,
                        backgroundColor: Colors.black,
                        gravity: Toast.CENTER);

                    print("transaction completed---");
                  } else {
                    Toast.show("Oops something went Wring!", context,
                        duration: 7, gravity: Toast.CENTER);

                    print("transaction failed---");
                  }
                  setState(() {
                    isProcessing = !isProcessing;
                  });
                }),
            SizedBox(
              height: 30.0,
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
    );
  }
}
