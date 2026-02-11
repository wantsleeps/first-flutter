import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/error.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../router/app_routes.dart';
import '../widgets/glass_card.dart'; // Import
import '../utils/style.dart'; // Import

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Consumer to rebuild when user data changes
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100), // Padding for bottom nav
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Avatar with Liquid Glow
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppGradients.primaryGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
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
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userProvider.userName,
                      style: AppTextStyles.header.copyWith(fontSize: 24),
                    ),
                    Text(
                      "ID: ${userProvider.userId}",
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Stats in GlassCard
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GlassCard(
                  borderRadius: 24,
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
              ),

              const SizedBox(height: 24),

              // Menu Items in GlassCard
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GlassCard(
                  padding: EdgeInsets.zero,
                  borderRadius: 24,
                  child: Column(
                    children: [
                      _buildMenuItem(
                        context,
                        Icons.account_balance_wallet,
                        "我的钱包",
                        () => Navigator.pushNamed(context, AppRoutes.wallet),
                      ),
                      const Divider(
                        height: 1,
                        indent: 60,
                        color: AppColors.glassBorder,
                      ),
                      _buildMenuItem(
                        context,
                        Icons.history,
                        "历史订单",
                        () => Navigator.pushNamed(context, AppRoutes.orders),
                      ),
                      const Divider(
                        height: 1,
                        indent: 60,
                        color: AppColors.glassBorder,
                      ),
                      _buildMenuItem(context, Icons.favorite, "我的收藏", () {}),
                      const Divider(
                        height: 1,
                        indent: 60,
                        color: AppColors.glassBorder,
                      ),
                      _buildMenuItem(context, Icons.settings, "设置", () {}),
                      const Divider(
                        height: 1,
                        indent: 60,
                        color: AppColors.glassBorder,
                      ),
                      _buildMenuItem(
                        context,
                        Icons.help_outline,
                        "帮助与客服",
                        () {},
                      ),
                      const Divider(
                        height: 1,
                        indent: 60,
                        color: AppColors.glassBorder,
                      ),
                      _buildMenuItem(
                        context,
                        Icons.error,
                        "error页面",
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ErrorPage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              TextButton(
                onPressed: () {
                  userProvider.logout();
                },
                child: Text(
                  "退出登录",
                  style: TextStyle(
                    color: Colors.red.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
        ),
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
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 20, color: AppColors.primary),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.textBlack,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textGrey,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
