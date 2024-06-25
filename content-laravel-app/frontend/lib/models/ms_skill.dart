class Skill {
    final int id;
    final String name;
    final String description;
    final String category;
    final double score;

    Skill({
        required this.id,
        required this.name,
        required this.description,
        required this.category,
        required this.score,
    });

    // ignore: empty_constructor_bodies
    factory Skill.fromJson(Map<String, dynamic> json) {
        return Skill(
            id: json['id_skill'],
            name: json['skill_name'],
            description: json['skill_description'],
            category: json['skill_category'],
            score: (json['skill_score'] as num).toDouble(),
        );
    }
}
