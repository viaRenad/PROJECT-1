// article_model.dart
class ArticleModel {
  String? sId;
  String? title;
  List<SubTitleContents>? subTitleContents;
  List<String>? imageUrl;
  List<String>? subTitles;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ArticleModel({
    this.sId,
    this.title,
    this.subTitleContents,
    this.imageUrl,
    this.subTitles,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];

    if (json['sub_title_contents'] != null) {
      subTitleContents = <SubTitleContents>[];
      json['sub_title_contents'].forEach((v) {
        subTitleContents!.add(SubTitleContents.fromJson(v));
      });
    }

    // إصلاح مشكلة null safety
    imageUrl =
        json['image_url'] != null ? List<String>.from(json['image_url']) : [];

    subTitles =
        json['sub_titles'] != null ? List<String>.from(json['sub_titles']) : [];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    if (subTitleContents != null) {
      data['sub_title_contents'] =
          subTitleContents!.map((v) => v.toJson()).toList();
    }
    data['image_url'] = imageUrl;
    data['sub_titles'] = subTitles;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class SubTitleContents {
  List<Paragraphs>? paragraphs;
  String? sId;

  SubTitleContents({this.paragraphs, this.sId});

  SubTitleContents.fromJson(Map<String, dynamic> json) {
    if (json['paragraphs'] != null) {
      paragraphs = <Paragraphs>[];
      json['paragraphs'].forEach((v) {
        paragraphs!.add(Paragraphs.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paragraphs != null) {
      data['paragraphs'] = paragraphs!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    return data;
  }
}

class Paragraphs {
  String? text;
  String? type;
  String? sId;

  Paragraphs({this.text, this.type, this.sId});

  Paragraphs.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['type'] = type;
    data['_id'] = sId;
    return data;
  }
}
