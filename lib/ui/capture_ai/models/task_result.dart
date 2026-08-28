class AITaskResult {
  final String title;
  final String deadline;
  final String summary;
  final String stakeholder;
  final String priority;

  AITaskResult({
    required this.title,
    required this.deadline,
    required this.summary,
    required this.stakeholder,
    required this.priority,
  });

  factory AITaskResult.fromJson(Map<String, dynamic> json) {
    return AITaskResult(
      title: json['title'] ?? '',
      deadline: json['deadline'] ?? '',
      summary: json['summary'] ?? '',
      stakeholder: json['stakeholder'] ?? '',
      priority: json['priority'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'deadline': deadline,
      'summary': summary,
      'stakeholder': stakeholder,
      'priority': priority,
    };
  }

  AITaskResult copyWith({
    String? title,
    String? deadline,
    String? summary,
    String? stakeholder,
    String? priority,
  }) {
    return AITaskResult(
      title: title ?? this.title,
      deadline: deadline ?? this.deadline,
      summary: summary ?? this.summary,
      stakeholder: stakeholder ?? this.stakeholder,
      priority: priority ?? this.priority,
    );
  }
}
