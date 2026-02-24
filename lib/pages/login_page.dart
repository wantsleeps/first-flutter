import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../router/app_routes.dart';
import '../widgets/glass_scaffold.dart'; // 导入
import '../widgets/glass_card.dart'; // 导入
import '../widgets/interaction_widgets.dart'; // 导入 PrimaryButton
import '../utils/style.dart'; // 导入

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 1500));

    if (mounted) {
      final username = _usernameController.text;
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).login(username, "password");

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: GlassCard(
            borderRadius: 30,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.water_drop_rounded, // 液体图标
                  size: 60,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  "游戏陪玩",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.header.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  "寻找你的完美游戏伙伴",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 48),

                // 用户名输入
                _buildGlassInput(
                  controller: _usernameController,
                  label: "用户名",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),

                // 密码输入
                _buildGlassInput(
                  controller: _passwordController,
                  label: "密码",
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 32),

                // 登录按钮
                PrimaryButton(
                  text: _isLoading ? "登录中..." : "登录",
                  fullWidth: true,
                  onPressed: _isLoading ? () {} : _login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: AppColors.textBlack),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.textGrey),
          prefixIcon: Icon(icon, color: AppColors.primary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
