import 'package:flutter/material.dart';
import 'package:food_spotlight/constant/api_keys.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:typewritertext/typewritertext.dart';

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
  final firstAIAnswer ='Hi, I am your Personal Health Assistant. What would you like to know?';
  final List<Message> messages = [];

  final model = GenerativeModel(
    model: 'gemini-1.0-pro', // replace with your model
    apiKey: geminiAPIKey, // replace with your API key
    generationConfig: GenerationConfig(
      maxOutputTokens: 8192,
      topP: 0.98,
      topK: 0,
      temperature: 1,
    ),
  );

Future<String> _startChat({question}) async {

  String contextText ='''
        '${widget.contextText}'
        'above is all the information you need to know about health and nutrition.'
        'And the name of Product is ${widget.productName}'
        'if product name is provides then you have to answer the question based on the product name.'
        'Based on the information provided and your knowledge about that product by product name, you have to answer my questions.'
        'Hello AI, I’m seeking advice and information on health and nutrition. Could you provide guidance on a balanced diet, nutritional needs, and how to maintain a healthy lifestyle?'
        
        'Assume you are an Health and Nutrition Expert. Answer the following question with reference to the above text context, using a concise and informative style. Provide more detail only when explicitly asked.'
    ''';

  try {

    // Initialize the chat
    final chat = model.startChat(history: [
      Content.text(contextText),
      Content.model([TextPart(firstAIAnswer)])
    ]);
    var content = Content.text(question);
    var response = await chat.sendMessage(content);
    String answer = response.text ?? 'No response found. Please try again.';
    return answer;
  } catch (error) {
    throw Exception('Error generating AI response: $error');
  }
}

  void _handleSubmitted(String text) async {
    FocusScopeNode currentFocus =
        FocusScope.of(context); // get the current focus node

    if (!currentFocus.hasPrimaryFocus) {
      // prevent Flutter from throwing an exception
      currentFocus
          .unfocus(); // unfocus from current focus, so that keyboard will dismiss
    }

    if (isLoading) {
      return;
    }

    _textController.clear();
    setState(() {
      isLoading = true;
      messages.add(Message(authorId: 0, content: text));
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add(Message(authorId: 1, content: ''));
      });
    });

    String answer = await _startChat(question: text);
    setState(() {
      messages.removeLast();
      messages.add(Message(authorId: 1, content: answer));
      isLoading = false;
    });
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).hintColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.secondary,
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: "Ask me anything...",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
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
        title: const Text("Ask food related queries"),
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
                color: Colors.black12,
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
                    message.content == ''
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
                        : TypeWriterText(
                            text: Text(message.content),
                            duration: const Duration(milliseconds: 10),
                          ),
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
  final String content;

  Message({required this.authorId, required this.content});
}
