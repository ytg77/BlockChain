import 'package:blockchain_implementation/contanst.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:blockchain_implementation/models/block_model.dart';
import 'package:blockchain_implementation/providers/data_provider.dart';
import 'package:blockchain_implementation/models/transaction.dart';
import 'package:blockchain_implementation/models/index.dart';
import 'landing_screen.dart';
import 'package:blockchain_implementation/widgets/custom_drawer.dart';

class BlockchainScreen extends StatelessWidget {
  // List<Block> blocks = [
  //   Block(
  //       noince: 2,
  //       blockNumber: 1,
  //       timestamp:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //       data: Transaction(
  //           amount: 50,
  //           senderPublicAddress:
  //               "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //           recieverPublicAddress:
  //               "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15"),
  //       previousHash:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //       currentBlockHash:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15"),
  //   Block(
  //       noince: 2,
  //       blockNumber: 3,
  //       timestamp:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //       data: Transaction(
  //           amount: 50,
  //           senderPublicAddress:
  //               "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //           recieverPublicAddress:
  //               "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15"),
  //       previousHash:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //       currentBlockHash:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15"),
  //   Block(
  //       noince: 2,
  //       blockNumber: 3,
  //       timestamp:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //       data: Transaction(
  //           amount: 50,
  //           senderPublicAddress:
  //               "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //           recieverPublicAddress:
  //               "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15"),
  //       previousHash:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //       currentBlockHash:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15"),
  //   Block(
  //       noince: 2,
  //       blockNumber: 3,
  //       timestamp:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //       data: Transaction(
  //           amount: 50,
  //           senderPublicAddress:
  //               "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //           recieverPublicAddress:
  //               "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15"),
  //       previousHash:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //       currentBlockHash:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15"),
  //   Block(
  //       noince: 2,
  //       blockNumber: 3,
  //       timestamp:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //       data: Transaction(
  //           amount: 50,
  //           senderPublicAddress:
  //               "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //           recieverPublicAddress:
  //               "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15"),
  //       previousHash:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15",
  //       currentBlockHash:
  //           "0a908bb546a8313a53a6c57df0b0bc71fa4f4812d196a1cb8449adad53344c15"),
  // ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("View Blockchain")),
      drawer: CustomDrawer(),
      body: Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('BlockChain'),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
                flex: 1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: index.length,
                    itemBuilder: (context, i) {
                      return IndexHolder(
                        text: index[i].title,
                        color: index[i].color,
                      );
                    })),
            Expanded(
              flex: 3,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.blocks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      // width: 400.0,
                      // height: 600.0,
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          BlockCard(
                            text: "${provider.blocks[index].blockNumber}",
                            color: Color(0xFFA2D2FF),
                          ),
                          BlockCard(
                            text: "${provider.blocks[index].timestamp}",
                            color: Color(0xFFFEF9EF),
                          ),
                          BlockCard(
                            text: "${provider.blocks[index].noince}",
                            color: Color(0xFFFF865E),
                          ),
                          // Container(
                          //   width: 400,
                          //   padding: EdgeInsets.all(20.0),
                          //   decoration: BoxDecoration(
                          //       color: Color(0xFF916BBF),
                          //       border:
                          //           Border.all(color: Colors.black, width: 2)),
                          //   child: Column(
                          //     children: [
                          //       DataHolder(
                          //         text: blocks[index].data.senderPublicAddress,
                          //       ),
                          //       Center(
                          //         child: Container(
                          //           width: 400,
                          //           child: Text(
                          //             "To",
                          //             textAlign: TextAlign.center,
                          //           ),
                          //         ),
                          //       ),
                          //       DataHolder(
                          //         text:
                          //             blocks[index].data.recieverPublicAddress,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          BlockCard(
                            text:
                                "${provider.blocks[index].data.sender.name} ----->  ${provider.blocks[index].data.reciever.name} : ${provider.blocks[index].data.amount}",
                            color: Color(0xFF916BBF),
                          ),
                          BlockCard(
                            text: " ${provider.blocks[index].previousHash}",
                            color: Color(0xFFFFC898),
                          ),
                          BlockCard(
                            text: " ${provider.blocks[index].currentBlockHash}",
                            color: Color(0xFF5C7AEA),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class DataHolder extends StatelessWidget {
  String text;
  DataHolder({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Text(
        "$text",
        style: ktextStyle,
      ),
    );
  }
}

class IndexHolder extends StatelessWidget {
  String text;
  Color color;

  IndexHolder({this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                color: color, border: Border.all(color: Colors.black)),
            height: 40,
            width: 50,
            child: Text("  "),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            "$text",
            style: ktextStyle,
          ),
        ],
      ),
    );
  }
}

class BlockCard extends StatelessWidget {
  String text;
  Color color;
  BlockCard({this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, border: Border.all(color: Colors.black, width: 2.0)),
      padding: EdgeInsets.all(12.0),
      width: 400,
      child: Text(
        text,
        maxLines: 10,
        style: ktextStyle.copyWith(fontSize: 18),
      ),
    );
  }
}
