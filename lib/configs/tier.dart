enum Tier {
  study(name: 'Study', emoji: '📚'),
  bronze(name: 'Bronze', emoji: '🥉'),
  silver(name: 'Silver', emoji: '🥈'),
  gold(name: 'Gold', emoji: '🥇');

  const Tier({
    required this.name,
    required this.emoji,
  });

  final String name;
  final String emoji;
  
  /// Convert string to Tier enum
  static Tier fromString(String tierString) {
    switch (tierString.toLowerCase()) {
      case 'study': return Tier.study;
      case 'bronze': return Tier.bronze;
      case 'silver': return Tier.silver;
      case 'gold': return Tier.gold;
      default: return Tier.study; // Default fallback
    }
  }
}