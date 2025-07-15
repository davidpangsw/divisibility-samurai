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
}