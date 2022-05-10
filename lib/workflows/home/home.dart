import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeStateWidget();
}

class _HomeStateWidget extends State<Home> {
  late SmsQuery query;
  late List<SmsMessage> allMessages;

  @override
  void initState() {
    query = SmsQuery();
    allMessages = List.empty();
    super.initState();
  }

  Future<void> getAllMessages(int count) async {
    List<SmsMessage> messages =
        await query.querySms(kinds: [SmsQueryKind.inbox], count: count);
    setState(() {
      allMessages = messages;
    });
  }

  Future<void> checkMessage() async {
    await getAllMessages(1000);
    List<SmsMessage> bankMessages = allMessages
        .where((element) => element.body?.contains("HDFC") ?? false)
        .toList();
    if (kDebugMode) {
      print(bankMessages.map((e) => '${e.body} \n'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            onPressed: checkMessage,
            child: const Text('Disabled'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
