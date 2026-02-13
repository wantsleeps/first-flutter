import 'package:flutter/material.dart';
import '../models/companion_model.dart';
import '../widgets/companion_card.dart';
import '../widgets/glass_card.dart'; // 导入 GlassCard
import '../utils/style.dart'; // 导入样式

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ["全部", ...MockData.games];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // 根据选择和搜索查询过滤陪玩
    final filteredCompanions = MockData.companions.where((c) {
      final matchesCategory =
          _selectedCategoryIndex == 0 ||
          c.game == _categories[_selectedCategoryIndex];
      final matchesSearch =
          _searchQuery.isEmpty ||
          c.name.contains(_searchQuery) ||
          c.game.contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();

    return Column(
      children: [
        // 头部 / 使用 GlassCard 的搜索框
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: GlassCard(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  borderRadius: 30,
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: AppColors.textGrey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: AppTextStyles.body,
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "搜索陪玩大神...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: AppColors.textGrey),
                            contentPadding: EdgeInsets.zero, // 文本垂直居中
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // 筛选按钮
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  gradient: AppGradients.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(Icons.tune, color: Colors.white, size: 24),
              ),
            ],
          ),
        ),

        // 分类横向列表
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedCategoryIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.glassWhite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : AppColors.glassBorder,
                      width: 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // 陪玩列表
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100), // 底部导航栏的内边距
            itemCount: filteredCompanions.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return CompanionCard(companion: filteredCompanions[index]);
            },
          ),
        ),
      ],
    );
  }
}
