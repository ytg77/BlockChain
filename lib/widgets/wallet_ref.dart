import 'package:flutter/material.dart';
import 'package:blockchain_implementation/models/wallet.dart';
import 'package:blockchain_implementation/contanst.dart';
import 'package:provider/provider.dart';
import 'package:blockchain_implementation/providers/data_provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:clipboard/clipboard.dart';
import 'package:toast/toast.dart';

class WalletRefernce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    return Container(
        padding: EdgeInsets.all(10.0),
        height: 350,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.wallets.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                padding: EdgeInsets.all(20.0),
                width: 600,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          " ${provider.wallets[index].name}",
                          style: ktextStyle,
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        CLipBoardHolder(
                          function: () {
                            FlutterClipboard.copy(
                                    provider.wallets[index].bitcoinAddress)
                                .then((value) => Toast.show(
                                    "Address Copied to clipboard", context,
                                    duration: 5,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    gravity: Toast.BOTTOM));
                          },
                          text: "Copy public Address",
                        ),
                        CLipBoardHolder(
                          function: () {
                            FlutterClipboard.copy(
                                    provider.wallets[index].privateKey)
                                .then((value) => Toast.show(
                                    "Address Copied to clipboard", context,
                                    duration: 5,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    gravity: Toast.BOTTOM));
                          },
                          text: "Copy Private Key",
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     FlutterClipboard.copy(
                        //             provider.wallets[index].privateKey)
                        //         .then((value) => Toast.show(
                        //             "Address Copied to clipboard", context,
                        //             duration: 5,
                        //             textColor: Colors.white,
                        //             backgroundColor: Colors.black,
                        //             gravity: Toast.BOTTOM));
                        //   },
                        //   child: Container(
                        //     child: Text("Copy PrivateKey"),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "public Address->${provider.wallets[index].bitcoinAddress}",
                      style: ktextStyle,
                      maxLines: 10,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Private Key->${provider.wallets[index].privateKey}",
                      style: ktextStyle,
                    )
                  ],
                ),
              );
            }));
  }
}

class CLipBoardHolder extends StatelessWidget {
  String text;
  Function function;
  CLipBoardHolder({this.function, this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Text(
          text,
          style: ktextStyle.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
