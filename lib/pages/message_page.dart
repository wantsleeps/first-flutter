import 'package:flutter/material.dart';
import '../models/companion_model.dart';
import 'chat_page.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatCompanions = MockData.companions
        .take(3)
        .toList(); // Mock active chats

    return Scaffold(
      appBar: AppBar(
        title: const Text("消息", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: chatCompanions.length,
        separatorBuilder: (ctx, i) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final companion = chatCompanions[index];
          final lastMsg = MockData.getMessages(companion.id).last;

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(companion.avatarUrl),
            ),
            title: Text(
              companion.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              lastMsg.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Text(
              _formatTime(lastMsg.timestamp),
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(companion: companion),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}
