import 'package:flutter/material.dart';

class ChatMiniWidget extends StatefulWidget {
  const ChatMiniWidget({super.key});

  @override
  State<ChatMiniWidget> createState() => _ChatMiniWidgetState();
}

class _ChatMiniWidgetState extends State<ChatMiniWidget> {
  bool isExpanded = false;
  Offset position = Offset.zero;
  Offset initialPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      setState(() {
        position = Offset(screenWidth - 85, 110);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onLongPress: () {
                initialPosition = position;
            },
            onLongPressMoveUpdate: (details) {
              setState(() {
                position = initialPosition + details.offsetFromOrigin;
              });
            },
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: _buildChatIcon(),
          ),
        ),

        if (isExpanded)
          Positioned(
            left: 20,
            top: 20,
            child: _buildExpandedChat(),
          ),
      ],
    );
  }

  Widget _buildChatIcon() {
    return Container(
      height: 57,
      width: 57,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Color.fromARGB(170, 17, 63, 180),
      ),
      child: Icon(Icons.chat, color: Colors.white,),
    );
  }

  Widget _buildExpandedChat() {
    return Padding(
      padding: EdgeInsets.only(top: 28, left: 28, right: 28),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hỗ trợ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        isExpanded = false;
                      });
                    },
                  )
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: Center(child: Text("Nội dung chat ở đây...")),
            )
          ],
        ),
      ),
    );
  }
}
