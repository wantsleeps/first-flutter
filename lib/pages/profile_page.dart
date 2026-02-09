import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/error.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../router/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Consumer to rebuild when user data changes
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
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
                        backgroundImage: userProvider.avatarUrl.isNotEmpty
                            ? NetworkImage(userProvider.avatarUrl)
                            : null,
                        child: userProvider.avatarUrl.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userProvider.userName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "ID: ${userProvider.userId}",
                        style: const TextStyle(color: Colors.grey),
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
                      _buildStatItem(
                        "余额",
                        "¥${userProvider.balance.toStringAsFixed(0)}",
                      ),
                      _buildStatItem("订单", "${userProvider.orders.length}"),
                      _buildStatItem("优惠券", "3"), // Mock
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Menu Items
                const Divider(height: 1),
                _buildMenuItem(
                  context,
                  Icons.account_balance_wallet,
                  "我的钱包",
                  () => Navigator.pushNamed(context, AppRoutes.wallet),
                ),
                _buildMenuItem(
                  context,
                  Icons.history,
                  "历史订单",
                  () => Navigator.pushNamed(context, AppRoutes.orders),
                ),
                _buildMenuItem(context, Icons.favorite, "我的收藏", () {}),
                _buildMenuItem(context, Icons.settings, "设置", () {}),
                _buildMenuItem(context, Icons.help_outline, "帮助与客服", () {}),
                _buildMenuItem(
                  context,
                  Icons.error,
                  "error页面",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ErrorPage()),
                  ),
                ),
                const SizedBox(height: 40),

                TextButton(
                  onPressed: () {
                    userProvider.logout();
                    // No need to navigate manually if Main wraps Home/Login with Consumer
                    // But to be safe and clear stack/context
                    // Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                  child: const Text(
                    "退出登录",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
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

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
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
      onTap: onTap,
    );
  }
}
