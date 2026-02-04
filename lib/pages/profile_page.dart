import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Avatar
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const NetworkImage(
                      "https://api.dicebear.com/7.x/avataaars/png?seed=User",
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "玩家一号",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "ID: 95279527",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem("余额", "¥120"),
                  _buildStatItem("订单", "15"),
                  _buildStatItem("优惠券", "3"),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Menu Items
            const Divider(height: 1),
            _buildMenuItem(Icons.account_balance_wallet, "我的钱包"),
            _buildMenuItem(Icons.history, "历史订单"),
            _buildMenuItem(Icons.favorite, "我的收藏"),
            _buildMenuItem(Icons.settings, "设置"),
            _buildMenuItem(Icons.help_outline, "帮助与客服"),
            const SizedBox(height: 40),

            TextButton(
              onPressed: () {},
              child: const Text("退出登录", style: TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[50], // Very subtle background
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      onTap: () {},
    );
  }
}
