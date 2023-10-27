import 'package:flutter/material.dart';
import 'package:blockchain_implementation/models/wallet.dart';
import 'package:flutter/material.dart';
import 'package:blockchain_implementation/screens/wallet_screen.dart';
import 'package:crypton/crypton.dart';
import 'package:blockchain_implementation/utilities/hash_utility.dart';
import 'package:blockchain_implementation/screens/create_coins_screen.dart';
import 'package:blockchain_implementation/widgets/custom_button.dart';
import 'package:blockchain_implementation/screens/pay_screen.dart';
import 'package:blockchain_implementation/screens/blockchain.dart';
import 'package:blockchain_implementation/screens/utxo_screen.dart';
import 'package:blockchain_implementation/contanst.dart';
import 'package:provider/provider.dart';
import 'package:blockchain_implementation/providers/data_provider.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String name;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    return Container(
      width: 600,
      child: Drawer(
        child: ListView(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300.0,
                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                      style: ktextStyle,
                      decoration: customDecotation.copyWith(
                          labelText: "Enter Name (For Reference)"),
                      onChanged: (String value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  MaterialButton(
                      color: Colors.blue,
                      child: Container(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "💰",
                            style: ktextStyle,
                          )),
                      onPressed: () async {
                        final ecKeypair = ECKeypair.fromRandom();
                        String privateKeyString =
                            ecKeypair.privateKey.toString();
                        String publicKeyString = ecKeypair.publicKey.toString();
                        String publicAddress =
                            await Utility.generateHash("$publicKeyString");
                        final x = ECPrivateKey.fromString(privateKeyString);
                        // print(x.runtimeType);
                        // print(
                        //     'key genererated from string in string format ${x.toString()}');
                        // print('Your Private Key\n $privateKeyString\n---');
                        // print("key generated from lib 1st $privateKeyString");
                        // print("$publicKeyString");
                        // print("$publicAddress");
                        provider.addWallet(Wallet(
                            privateKey: privateKeyString,
                            publicKey: publicKeyString,
                            bitcoinAddress: publicAddress,
                            name: name));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalletScreen()));
                      })
                ],
              ),
            ),
            CustomButton(
              handleTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatreCoinsScreen()));
              },
              text: "Create Coins",
            ),
            CustomButton(
              handleTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PayScreen()));
              },
              text: "Make a Transaction (pay coins)",
            ),
            CustomButton(
              handleTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlockchainScreen()));
              },
              text: "view the blockchain",
            ),
            CustomButton(
              handleTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UTXOScreen()));
              },
              text: "view the UTXO",
            ),
          ],
        ),
      ),
    );
  }
}
