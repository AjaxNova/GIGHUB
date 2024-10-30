import 'dart:developer';

import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/controller/provider/auth_provider.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/utils/colors/colors.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProviderData>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: SpecialAppbar(
            context: context,
            onTap: () {
              Navigator.of(context).pop();
            },
            appBarTitle: "chat"),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .where('users', arrayContains: prov.getUserModel.uid)
              .snapshots(),
          builder: (context, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return const Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              );
            } else {
              if (chatSnapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("No chats yet"),
                      )
                    ],
                  ),
                );
              } else {
                // dynamic data = chatSnapshot.data!.docs[0]['users'];

                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1.5,
                        color: Colors.grey,
                        thickness: 1.5,
                      );
                    },
                    itemCount: chatSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      List<dynamic> users =
                          chatSnapshot.data!.docs[index]['users'];
                      users.remove(prov.getUserModel.uid);
                      final docId = chatSnapshot.data!.docs[index].id;
                      log("this is ----------------------------- $docId");

                      // final data =
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(users.first)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            final userData = UserModel.fromSnap(
                                userSnapshot.data as DocumentSnapshot<Object?>);

                            return Card(
                              color: test7,
                              elevation: 7,
                              child: ListTile(
                                onTap: () {
                                  Utils().navigateMe(
                                      context: context,
                                      page: SinglechatPage(
                                        recieverUid: users[0],
                                        docId: docId,
                                        senderUid: prov.getUserModel.uid,
                                        directChat: true,
                                      ));
                                },
                                title: Text(userData.username),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userData.photoUrl),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class SinglechatPage extends StatefulWidget {
  const SinglechatPage({
    super.key,
    this.directChat = false,
    this.isApplied = false,
    required this.senderUid,
    required this.recieverUid,
    this.docId,
  });

  final String senderUid;
  final String recieverUid;
  final String? docId;
  final bool? directChat;
  final bool isApplied;

  @override
  State<SinglechatPage> createState() => _SinglechatPageState();
}

class _SinglechatPageState extends State<SinglechatPage> {
  final ScrollController _scrollController = ScrollController();

  String? docIdd;

  @override
  void initState() {
    super.initState();

    _initDocid();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _initDocid() async {
    if (widget.docId == null) {
      final QuerySnapshot chatDocuments = await FirebaseFirestore.instance
          .collection('chat')
          .where('users', arrayContainsAny: [
        widget.senderUid,
      ]).get();

      if (chatDocuments.docs.isNotEmpty) {
        for (var doc in chatDocuments.docs) {
          List<dynamic> users = doc['users'];
          if (users.contains(widget.senderUid) &&
              users.contains(widget.recieverUid)) {
            setState(() {
              docIdd = doc.id;
            });
          }
        }
        if (docIdd == null) {
          String chatId = const Uuid().v1();

          await FirebaseFirestore.instance.collection('chat').doc(chatId).set({
            "users": [widget.senderUid, widget.recieverUid]
          });
          setState(() {
            docIdd = chatId;
          });
        }
      } else {
        log("im empty");
        String chatId = const Uuid().v1();

        await FirebaseFirestore.instance.collection('chat').doc(chatId).set({
          "users": [widget.senderUid, widget.recieverUid]
        });
        setState(() {
          docIdd = chatId;
        });
      }
    } else {
      setState(() {
        docIdd = widget.docId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log("this is the sender user:'${widget.senderUid}' and this is the poster : ${widget.recieverUid}' ");
    final prov = Provider.of<AuthProviderData>(context, listen: false);
    return SafeArea(
        child: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.recieverUid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final selectedUserMod =
              UserModel.fromSnap(snapshot.data as DocumentSnapshot<Object?>);

          return Scaffold(
            // bottomNavigationBar: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SizedBox(
            //       height: 65,
            //       child: MessageBar(
            //         onSend: (p0) async {
            //           final CommentModel model = CommentModel(
            //               message: p0,
            //               recieverId: selectedUserMod.uid,
            //               senderId: prov.getUserModel.uid,
            //               sentTime: DateTime.now());

            //           // await FirebaseFirestore.instance
            //           //     .collection('chat')
            //           //     .doc(docIdd)
            //           //     .set({
            //           //   'users': [widget.theUser, widget.selecteduser]
            //           // });

            //           await FirebaseFirestore.instance
            //               .collection('chat')
            //               .doc(docIdd)
            //               .collection('messages')
            //               .add(model.toJson());
            //         },
            //       ),),
            // ),
            appBar: SpecialAppbar(
                isChat: true,
                photoUrl: selectedUserMod.photoUrl,
                context: context,
                onTap: () {
                  Navigator.of(context).pop();
                },
                appBarTitle: selectedUserMod.username),
            body: Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
              child: Column(
                children: [
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('chat')
                          .doc(docIdd)
                          .collection('messages')
                          .orderBy('sentTime', descending: false)
                          .snapshots(),
                      builder: (context, chatSnapshot) {
                        if (chatSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Column(
                            children: [
                              Center(
                                child: CircularProgressIndicator(),
                              )
                            ],
                          );
                        } else {
                          if (!chatSnapshot.hasData) {
                            return const SizedBox(
                              child: Center(
                                child: Text("adfbahdfsj"),
                              ),
                            );
                          } else {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent +
                                      100);
                            });
                            return ListView.builder(
                              controller: _scrollController,
                              itemCount: chatSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final data = CommentModel.fromsnap(
                                    chatSnapshot.data!.docs[index]);
                                // log("this is datataaa ${data.toString()}");
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      BubbleNormal(
                                        text: data.message,
                                        isSender: data.senderId !=
                                            prov.getUserModel.uid,
                                        color: data.senderId !=
                                                prov.getUserModel.uid
                                            ? Colors.blue
                                            : test1,
                                      ),
                                      BubbleNormal(
                                        isSender: data.senderId !=
                                            prov.getUserModel.uid,
                                        tail: false,
                                        text: DateFormat.jm()
                                            .format(data.sentTime),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );

                            // final ref = chatSnapshot.data!.docs[0].id;

                            // final CommentModel comMod =
                            //     CommentModel.fromsnap(data['messages']);
                            // log(comMod.message);
                            // log(chatSnapshot.data!.docs.length.toString());
                            // return StreamBuilder(
                            //   stream: FirebaseFirestore.instance
                            //       .collection('chat')
                            //       .doc("ashkdhas")
                            //       .collection('messages')
                            //       .snapshots(),
                            //   builder: (context, messageSnapshot) {
                            //     if (messageSnapshot.connectionState ==
                            //         ConnectionState.waiting) {
                            //       return const Column(
                            //         children: [
                            //           Center(
                            //             child: CircularProgressIndicator(),
                            //           )
                            //         ],
                            //       );
                            //     } else {
                            //       if (messageSnapshot.hasData) {

                            //       } else {
                            //         return const Center(
                            //           child: Column(
                            //             children: [
                            //               CircularProgressIndicator()
                            //             ],
                            //           ),
                            //         );
                            //       }
                            //     }
                            //   },
                            // );
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    child: MessageBar(
                      onSend: (p0) async {
                        final CommentModel model = CommentModel(
                            message: p0,
                            recieverId: selectedUserMod.uid,
                            senderId: prov.getUserModel.uid,
                            sentTime: DateTime.now());

                        // await FirebaseFirestore.instance
                        //     .collection('chat')
                        //     .doc(docIdd)
                        //     .set({
                        //   'users': [widget.theUser, widget.selecteduser]
                        // });

                        await FirebaseFirestore.instance
                            .collection('chat')
                            .doc(docIdd)
                            .collection('messages')
                            .add(model.toJson());
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    ));
  }
}
