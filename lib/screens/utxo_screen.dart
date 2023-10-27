import 'package:blockchain_implementation/contanst.dart';
import 'package:flutter/material.dart';
import 'package:blockchain_implementation/models/block_model.dart';
import 'package:blockchain_implementation/models/index.dart';
import 'package:blockchain_implementation/models/block_model.dart';
import 'package:blockchain_implementation/models/transaction.dart';
import 'package:blockchain_implementation/models/utxo.dart';
import 'package:blockchain_implementation/models/wallet.dart';
import 'package:blockchain_implementation/models/wallet.dart';
import 'package:provider/provider.dart';
import 'package:blockchain_implementation/providers/data_provider.dart';
import 'landing_screen.dart';
import 'package:blockchain_implementation/widgets/custom_drawer.dart';

class UTXOScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    // List<Transaction> tempUtox = [
    //   Transaction(
    //     sender: creatorWallet,
    //     reciever: creatorWallet,
    //     amount: 50,
    //   ),
    //   Transaction(sender: creatorWallet, reciever: creatorWallet, amount: 50),
    //   Transaction(sender: creatorWallet, reciever: creatorWallet, amount: 50)
    // ];

    return Scaffold(
      appBar: AppBar(title: Text("View UTXOs")),
      drawer: CustomDrawer(),
      body: Container(
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(20.0),
        height: 600,
        width: double.infinity,
        child: Column(children: [
          Text(
            "UTXOS",
            style: ktextStyle,
          ),
          SizedBox(
            height: 30.0,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: provider.utxosList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.blue[100]),
                        width: double.infinity,
                        child: SelectableText(
                          "${provider.utxosList[index].sender.name}   --> ${provider.utxosList[index].reciever.name}  : ${provider.utxosList[index].amount}",
                          style: ktextStyle,
                          textAlign: TextAlign.center,
                        ));
                  }))
        ]),
      ),
    );
  }
}
