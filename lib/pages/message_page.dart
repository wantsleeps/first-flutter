import 'package:flutter/material.dart';
import '../models/companion_model.dart';
import 'chat_page.dart';
import '../widgets/glass_card.dart'; // 导入
import '../utils/style.dart'; // 导入

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatCompanions = MockData.companions.take(3).toList(); // 模拟活跃聊天

    return Column(
      children: [
        // 自定义毛玻璃头部
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 60, 16, 10),
          child: Row(children: [Text("消息", style: AppTextStyles.header)]),
        ),

        // 聊天列表
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            itemCount: chatCompanions.length,
            separatorBuilder: (ctx, i) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final companion = chatCompanions[index];
              final lastMsg = MockData.getMessages(companion.id).last;

              return GlassCard(
                padding: const EdgeInsets.all(12),
                borderRadius: 20,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(companion: companion),
                    ),
                  );
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(companion.avatarUrl),
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            companion.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lastMsg.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: AppColors.textGrey),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          _formatTime(lastMsg.timestamp),
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 12,
                          ),
                        ),
                        if (index == 0) // 模拟未读角标
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              "1",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}
