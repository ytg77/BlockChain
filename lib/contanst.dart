import 'package:flutter/material.dart';
import 'package:blockchain_implementation/models/wallet.dart';
import 'package:blockchain_implementation/models/index.dart';

String creatorPrivate =
    "d3efa99082aa31915602279a3be5f2f87e2f00ad0542a9ef75d383c63f0e0091";
// "MIHFAgEAMA0GCSqGSIb3DQEBAQUABIGwMIGtAgEAAiECRR0dwna0uj1YzwwLZJHUkF/vfhyY1528SQGIZZ0zpn8CAwEAAQIhAXXScCV71XEFK88tcVrF0RUJGaColOG/93qbsONmj0GBAhEBo0pqbEB3NkYYgnmF1B9TPwIRAWLNRtP8bbWZFtiaQYvFHMECEQCKqk+r4V4Lmv78F4iE8J8tAhEAm6awrukr/CIIGsg5fybfQQIRAW2+IaHNQzOCytEpefLiuE4=";
String creatorPublic = "AiPff19nGiaQGJUAff7g8gfWyLM0IF1DNuOKpQ97oDgV";
// "MDwwDQYJKoZIhvcNAQEBBQADKwAwKAIhAkUdHcJ2tLo9WM8MC2SR1JBf734cmNedvEkBiGWdM6Z/AgMBAAE=";
String creatorPublicAddress =
    "081ab176be48a5a1ea4cd4d77aeb1f560de85e05c717690d78aed888cb9775df";
// "ede240f275fe44a00ff86f362db5e1ff8d215d5069c9ace51c8215db8f29bf4b";

Wallet creatorWallet = Wallet(
    privateKey: creatorPrivate,
    publicKey: creatorPublic,
    bitcoinAddress: creatorPublicAddress,
    name: "creator");

InputDecoration customDecotation = InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Enter Reciever Address',
    labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold));

TextStyle ktextStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

enum Users { Creator, others }

List<Index> index = [
  Index(
    title: "Block Number",
    color: Color(0xFFA2D2FF),
  ),
  Index(
    title: "TimeStamp",
    color: Color(0xFFFEF9EF),
  ),
  Index(
    title: "noince",
    color: Color(0xFFFF865E),
  ),
  Index(title: "Data", color: Color(0xFF916BBF)),
  Index(title: "previous Hash", color: Color(0xFFFFC898)),
  Index(title: "current block", color: Color(0xFF5C7AEA))
];

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
