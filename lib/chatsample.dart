import 'package:custom_clippers/custom_clippers.dart';
import 'package:e_konsul/models/message.dart';
import 'package:flutter/material.dart';

class ChatSample extends StatelessWidget {
  final List<Message> listMessage;
  ChatSample(this.listMessage);

  List<Widget> widgetListMessage(context) {
    List<Widget> l = [];
    for (var message in listMessage) {
        if(message.isDoctor == true) {
          l.add(Padding(
            padding: EdgeInsets.only(right: 80),
            child: ClipPath(
              clipper: UpperNipMessageClipper(MessageType.receive),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFE1E1E2),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsetsDirectional.only(bottom: 4),
                          child: Text(
                            "${message.value}",
                            style: TextStyle(fontSize: 17),
                          )
                      ),
                      Text(
                        "${message.createdAt}",
                        style: TextStyle(fontSize: 12, color: Colors.black45),
                      ),
                    ],
                )
              ),
            ),
          ));
        } else {
          l.add(Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 80),
              child: ClipPath(
                clipper: LowerNipMessageClipper(MessageType.send),
                child: Container(
                  padding:
                  EdgeInsets.only(left: 20, top: 10, bottom: 25, right: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFF113953),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            margin: EdgeInsetsDirectional.only(bottom: 4),
                            child: Text(
                              "${message.value}",
                              style: TextStyle(fontSize: 17, color: Colors.white),
                            )
                        ),
                        Text(
                          "${message.createdAt}",
                          style: TextStyle(fontSize: 12, color: Colors.white54),
                        ),
                      ])
                ),
              ),
            ),
          ));
        }
    }

    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgetListMessage(context),
      // children: [
      //   Padding(
      //     padding: EdgeInsets.only(right: 80),
      //     child: ClipPath(
      //       clipper: UpperNipMessageClipper(MessageType.receive),
      //       child: Container(
      //         padding: EdgeInsets.all(20),
      //         decoration: BoxDecoration(
      //           color: Color(0xFFE1E1E2),
      //         ),
      //         child: Text(
      //           "Hi, Can I Help You?",
      //           style: TextStyle(fontSize: 16),
      //         ),
      //       ),
      //     ),
      //   ),
      //   Container(
      //     alignment: Alignment.centerRight,
      //     child: Padding(
      //       padding: EdgeInsets.only(top: 20, left: 80),
      //       child: ClipPath(
      //         clipper: LowerNipMessageClipper(MessageType.send),
      //         child: Container(
      //           padding:
      //               EdgeInsets.only(left: 20, top: 10, bottom: 25, right: 20),
      //           decoration: BoxDecoration(
      //             color: Color(0xFF113953),
      //           ),
      //           child: Text(
      //             "Yes,Please",
      //             style: TextStyle(fontSize: 16, color: Colors.white),
      //           ),
      //         ),
      //       ),
      //     ),
      //   )
      // ],
    );
  }
}
