import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessage {
  final String sender;
  final String message;

  ChatMessage({required this.sender, required this.message});
}

class ChatController extends GetxController {
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final ScrollController scrollController = ScrollController();

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messages.add(ChatMessage(sender: 'User', message: message));
      // Desplazar al último mensaje cuando se agrega uno nuevo
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }
}

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController textController = TextEditingController();

  void _sendMessage() {
    chatController.sendMessage(textController.text.trim());
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true, // Mostrar mensajes desde la parte inferior
              child: Column(
                children: [
                  Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: chatController.messages.length,
                      itemBuilder: (context, index) {
                        final message = chatController.messages[index];
                        return ChatBubble(
                          sender: message.sender,
                          message: message.message,
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
          InputBar(textController: textController, onSendMessage: _sendMessage),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String sender;
  final String message;

  ChatBubble({required this.sender, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          sender == 'User' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: sender == 'User'
              ? Colors.green
              : const Color.fromARGB(255, 251, 2, 2),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(message),
      ),
    );
  }
}

class InputBar extends StatelessWidget {
  final TextEditingController textController;
  final Function() onSendMessage;

  InputBar({required this.textController, required this.onSendMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Escribe un mensaje...',
                border: InputBorder.none,
              ),
              onSubmitted: (_) => onSendMessage(),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.blue,
            ),
            onPressed: onSendMessage,
          ),
        ],
      ),
    );
  }
}
