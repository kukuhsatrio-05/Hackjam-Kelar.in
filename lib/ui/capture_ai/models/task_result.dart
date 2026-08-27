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
      title: json['title'] ?? '-',
      deadline: json['deadline'] ?? '-',
      summary: json['summary'] ?? '-',
      stakeholder: json['stakeholder'] ?? '-',
      priority: json['priority'] ?? '-',
    );
  }
}
