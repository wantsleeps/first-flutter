class Companion {
  final String id;
  final String name;
  final String game;
  final double price;
  final String avatarUrl;
  final double rating;
  final int orderCount;
  final List<String> tags;
  final String description;
  final bool isOnline;

  Companion({
    required this.id,
    required this.name,
    required this.game,
    required this.price,
    required this.avatarUrl,
    required this.rating,
    required this.orderCount,
    required this.tags,
    required this.description,
    required this.isOnline,
  });
}

class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMe;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
}

class MockData {
  static final List<String> games = [
    "王者荣耀",
    "英雄联盟",
    "绝地求生",
    "无畏契约",
    "原神",
    "Dota 2",
    "和平精英",
  ];

  static List<Companion> companions = [
    Companion(
      id: "1",
      name: "瑶瑶公主",
      game: "王者荣耀",
      price: 20.0,
      avatarUrl: "https://api.dicebear.com/7.x/avataaars/png?seed=Alice",
      rating: 4.9,
      orderCount: 120,
      tags: ["甜美", "C位", "话痨"],
      description: "荣耀王者百星，全能补位。老板在这个段位随便杀，我负责喊666！",
      isOnline: true,
    ),
    Companion(
      id: "2",
      name: "野王哥哥",
      game: "英雄联盟",
      price: 35.0,
      avatarUrl: "https://api.dicebear.com/7.x/avataaars/png?seed=Bob",
      rating: 4.8,
      orderCount: 85,
      tags: ["技术流", "幽默", "指挥"],
      description: "电一王者打野，带你体验飞一般的感觉。不赢不收钱。",
      isOnline: false,
    ),
    Companion(
      id: "3",
      name: "狙击女神",
      game: "绝地求生",
      price: 25.0,
      avatarUrl: "https://api.dicebear.com/7.x/avataaars/png?seed=Cathy",
      rating: 4.7,
      orderCount: 200,
      tags: ["人美声甜", "刚枪", "声优"],
      description: "P城是我家，把把吃鸡不是梦。快来上车！",
      isOnline: true,
    ),
    Companion(
      id: "4",
      name: "瓦罗兰特特工",
      game: "无畏契约",
      price: 30.0,
      avatarUrl: "https://api.dicebear.com/7.x/avataaars/png?seed=David",
      rating: 5.0,
      orderCount: 50,
      tags: ["爆头", "战术", "高冷"],
      description: "赋能战将，捷风单推人。带你体验什么叫真正的枪法。",
      isOnline: true,
    ),
    Companion(
      id: "5",
      name: "提瓦特向导",
      game: "原神",
      price: 15.0,
      avatarUrl: "https://api.dicebear.com/7.x/avataaars/png?seed=Eva",
      rating: 4.9,
      orderCount: 300,
      tags: ["锄大地", "剧情", "唱歌"],
      description: "专业代肝，锄大地，过剧情，深渊满星。还可以陪你聊剧情哦。",
      isOnline: false,
    ),
    Companion(
      id: "6",
      name: "刀塔老兵",
      game: "Dota 2",
      price: 40.0,
      avatarUrl: "https://api.dicebear.com/7.x/avataaars/png?seed=Frank",
      rating: 4.6,
      orderCount: 1500,
      tags: ["老玩家", "队长", "耐心"],
      description: "万分大神转辅助，包鸡包眼包TP，保你发育无忧。",
      isOnline: true,
    ),
  ];

  static List<ChatMessage> getMessages(String companionId) {
    return [
      ChatMessage(
        id: "1",
        senderId: companionId,
        text: "小哥哥/小姐姐，在吗？要一起玩游戏吗？",
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isMe: false,
      ),
      ChatMessage(
        id: "2",
        senderId: "me",
        text: "在的，刚上线。",
        timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
        isMe: true,
      ),
      ChatMessage(
        id: "3",
        senderId: companionId,
        text: "那拉我拉我，我随时准备好了！",
        timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
        isMe: false,
      ),
    ];
  }
}
