// models/duaa_model.dart
class ContentItem {
  final String title;
  final String text;

  ContentItem({required this.title, required this.text});

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(title: json['title'], text: json['text']);
  }
}
