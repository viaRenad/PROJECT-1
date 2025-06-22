// models/duaa_model.dart
class ContentItem {
  final String repeat;
  final String text;

  ContentItem({required this.repeat, required this.text});

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(repeat: json['repeat'], text: json['text']);
  }
}
