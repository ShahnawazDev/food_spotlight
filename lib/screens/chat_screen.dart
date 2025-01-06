// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:food_spotlight/api/network_service.dart';

class ChatScreen extends StatefulWidget {
  final String? productName;
  final String contextText;

  const ChatScreen({super.key, required this.contextText, this.productName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  bool isLoading = false;
  final firstAIAnswer =
      '''Hi, I am your Personal Health Assistant. What would you like to know'''
      ''' about your food?''';

  final List<Message> messages = [];

  final NetworkService networkService = NetworkService();

  void _handleSubmitted(String text) async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    if (isLoading) {
      return;
    }

    _textController.clear();
    setState(() {
      isLoading = true;
      messages.add(Message(authorId: 0, content: text));
      messages.add(Message(authorId: 1, content: ''));
    });

    String contextText = '''
      ${widget.contextText}
      above is all the information you need to know about health and nutrition.
      And the name of Product is ${widget.productName}.
      If the product name is provided, then you have to answer the question based on the product name.
      Based on the information provided and your knowledge about that product by product name, you have to answer my questions.
      i will ask question such as Hello AI, I’m seeking advice and information on health and nutrition. Could you provide guidance on a balanced diet, nutritional needs, and how to maintain a healthy lifestyle?
      
      Assume you are a Health and Nutrition Expert. Answer the question that i will ask with reference to the above text context, using a very concise and informative style. Provide more detail only when explicitly asked otherise keep it short and simple.
    ''';
    //old implementation
    // Stream<String> responseStream =
    //     networkService.generateAIQueryResponse(contextText, text);
    
    //new implementation
    Stream<String> responseStream =
        networkService.generateAzureFunctionQueryResponse(contextText, text);

    StringBuffer fullResponse = StringBuffer();
    responseStream.listen((chunk) {
      fullResponse.write(chunk);
      setState(() {
        messages[messages.length - 1].content = fullResponse.toString();
      });
    }, onDone: () {
      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      setState(() {
        isLoading = false;
        messages[messages.length - 1].content =
            'Error: Unable to fetch response.';
      });
      print('Stream Error: $error');
    });
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).hintColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 40 *
                        (const TextField().maxLines!.toDouble() +
                            2), // Maximum height for 4 lines
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: TextField(
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.white,
                      ),
                      maxLines: null, // Unlimited max lines initially
                      controller: _textController,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Ask me anything...",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12, bottom: 12),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.green,
                size: 26,
              ),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    messages.add(Message(authorId: 1, content: firstAIAnswer));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Ask food related queries",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        // alignment: Alignment.bottomCenter,
        children: <Widget>[
          //listview builder inside a expanded widget
          Expanded(
            child: ListView.builder(
              //item count is the number of messages in the chat
              itemCount: messages.length,
              //item builder builds each message
              itemBuilder: (BuildContext context, int index) {
                Message message = messages[index];
                return MessageItem(message: message);
              },
            ),
          ),
          _buildTextComposer(),
        ],
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Icon(
              (message.authorId == 0) ? Icons.person : Icons.computer,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Container(
              alignment: Alignment.centerLeft,
              // margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message.authorId == 0 ? 'You' : 'Health Assistant',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    message.authorId == 1 && message.content.isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Your Food Assistant is thinking...'),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                width: 100,
                                child: const LoadingIndicator(
                                    indicatorType: Indicator.ballGridBeat),
                              ),
                            ],
                          )
                        : message.authorId == 1
                            ? TypeWriterText(
                                maintainSize: false,
                                key: ValueKey(message.hashCode),
                                text: Text(message.content),
                                duration: const Duration(milliseconds: 20),
                              )
                            : Text(message.content),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final int authorId;
  String content; // Changed from 'final String content;'

  Message({required this.authorId, required this.content});
}
