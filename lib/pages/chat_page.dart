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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            // 毛玻璃 AppBar
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    bottom: 4,
                    left: 8,
                    right: 8,
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
                        backgroundImage: NetworkImage(
                          widget.companion.avatarUrl,
                        ),
                        radius: 16,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        widget.companion.name,
                        style: AppTextStyles.header.copyWith(fontSize: 16),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
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
                        horizontal: 12,
                        vertical: 8, // 更多留白
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        gradient: msg.isMe
                            ? AppGradients.primaryGradient
                            : null,
                        color: msg.isMe ? null : AppColors.glassWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft: msg.isMe
                              ? const Radius.circular(12)
                              : Radius.zero,
                          bottomRight: msg.isMe
                              ? Radius.zero
                              : const Radius.circular(12),
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
                          fontSize: 13,
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
                8,
                8,
                8,
                MediaQuery.of(context).padding.bottom + 10,
              ),
              decoration: BoxDecoration(
                color: AppColors.glassWhiteHigh, // 输入框透明度较低
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
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
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: TextField(
                        controller: _controller,
                        cursorHeight: 16, // Reduce cursor height
                        cursorWidth: 1.5, // Reduce cursor width
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          isDense: true,
                          hintText: "输入消息...",
                          hintStyle: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 60,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: AppGradients.primaryGradient,
                      ),
                      child: const Text(
                        "发送",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
