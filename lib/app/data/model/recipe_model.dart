import 'dart:convert';

class RecipeModel {
  int? id;
  String? title;
  String? content;
  String? image;
  RecipeModel({
    this.id,
    this.title,
    this.content,
    this.image,
  });

  RecipeModel copyWith({
    int? id,
    String? title,
    String? content,
    String? image,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id']?.toInt(),
      title: map['title'],
      content: map['content'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeModel.fromJson(String source) =>
      RecipeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RecipeModel(id: $id, title: $title, content: $content, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipeModel &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ content.hashCode ^ image.hashCode;
  }

  static List<RecipeModel> toJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => RecipeModel.fromMap(e)).toList();
  }
}
