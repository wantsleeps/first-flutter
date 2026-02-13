import 'package:flutter/material.dart';
import '../models/companion_model.dart';
import '../widgets/glass_scaffold.dart'; // 导入
import '../utils/style.dart'; // 导入
import 'dart:ui'; // 用于 ImageFilter

class ChatPage extends StatefulWidget {
  final Companion companion;

  const ChatPage({super.key, required this.companion});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = MockData.getMessages(widget.companion.id);
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().toString(),
          senderId: "me",
          text: _controller.text,
          timestamp: DateTime.now(),
          isMe: true,
        ),
      );
      _controller.clear();
    });

    // 模拟回复
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add(
            ChatMessage(
              id: DateTime.now().toString(),
              senderId: widget.companion.id,
              text: "好的，没问题！我们现在就开始吧。",
              timestamp: DateTime.now(),
              isMe: false,
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      body: Column(
        children: [
          // 毛玻璃 AppBar
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  bottom: 10,
                  left: 16,
                  right: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.glassWhite,
                  border: const Border(
                    bottom: BorderSide(color: AppColors.glassBorder),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textBlack,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.companion.avatarUrl),
                      radius: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.companion.name,
                      style: AppTextStyles.header.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 消息列表
          Expanded(
            child: ListView.builder(
              reverse: true, // 从底部开始
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                // 因为设置了 reverse: true，所以索引 0 是最底部的项。
                // 如果 _messages 是按 [最旧, ..., 最新] 排序，
                // 我们希望索引 0 是最新的。
                // 所以索引 0 映射到 _messages.length - 1。
                final msg = _messages[_messages.length - 1 - index];
                return Align(
                  alignment: msg.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12, // 更多留白
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      gradient: msg.isMe ? AppGradients.primaryGradient : null,
                      color: msg.isMe ? null : AppColors.glassWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: msg.isMe
                            ? const Radius.circular(20)
                            : Radius.zero,
                        bottomRight: msg.isMe
                            ? Radius.zero
                            : const Radius.circular(20),
                      ),
                      boxShadow: msg.isMe
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [], // 接收到的毛玻璃消息没有阴影，或者稍微加一点？
                      border: msg.isMe
                          ? null
                          : Border.all(color: AppColors.glassBorder),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: msg.isMe ? Colors.white : AppColors.textBlack,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 输入区域
          Container(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              MediaQuery.of(context).padding.bottom + 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.glassWhiteHigh, // 输入框透明度较低
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              border: const Border(
                top: BorderSide(color: AppColors.glassBorder),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        hintText: "输入消息...",
                        hintStyle: TextStyle(color: AppColors.textGrey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppGradients.primaryGradient,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
