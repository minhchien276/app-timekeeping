import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BlogModel {
  final int? id;
  final String? title;
  final String? content;
  final String? image;
  final String? link;
  final DateTime? dateTimeBlog;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  BlogModel({
    this.id,
    this.title,
    this.content,
    this.image,
    this.link,
    this.dateTimeBlog,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'link': link,
      'dateTimeBlog': dateTimeBlog?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      dateTimeBlog: map['dateTimeBlog'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTimeBlog'] as int)
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogModel.fromJson(String source) =>
      BlogModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
