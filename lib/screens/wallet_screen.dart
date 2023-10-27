import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crypton/crypton.dart';
import 'package:blockchain_implementation/utilities/hash_utility.dart';
import 'package:blockchain_implementation/models/wallet.dart';
import 'package:provider/provider.dart';
import 'package:blockchain_implementation/providers/data_provider.dart';
import 'package:blockchain_implementation/contanst.dart';
import 'package:blockchain_implementation/widgets/custom_drawer.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String publicKeyString;
  String privateKeyString;
  String publicAddress;
  String name;
  // void addKeys() {}

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Wallet ")),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Wallet created Succesfully with name  ${provider.wallets[provider.wallets.length - 1].name} for reference",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KeyCard(
                      title: "Private Key",
                      text: provider
                          .wallets[provider.wallets.length - 1].privateKey,
                    ),
                    KeyCard(
                      title: "Public Key",
                      text: provider
                          .wallets[provider.wallets.length - 1].publicKey,
                    ),
                    KeyCard(
                      title: "Public Address",
                      text: provider
                          .wallets[provider.wallets.length - 1].bitcoinAddress,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KeyCard extends StatelessWidget {
  final String text;
  final String title;
  KeyCard({this.text, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0))),
            padding: EdgeInsets.all(20.0),
            child: SelectableText(
              "$title",
              style: ktextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
            padding: EdgeInsets.all(20.0),
            child: SelectableText(
              '$text',
              style: ktextStyle,
            ),
          )
        ],
      ),
    );
  }
}
