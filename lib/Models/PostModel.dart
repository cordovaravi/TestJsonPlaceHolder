// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

class PostModel {
  PostModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  int? userId;
  int? id;
  String? title;
  String? body;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json["userId"] == null ? null : json["userId"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
      );

  static Map<String, dynamic> toMap(PostModel postModel) => {
        "id": postModel.id,
        "userId": postModel.userId,
        "title": postModel.title,
        "body": postModel.body
      };

  static String encode(List<PostModel> postModel) => json.encode(
        postModel
            .map<Map<String, dynamic>>((obj) => PostModel.toMap(obj))
            .toList(),
      );

  static List<PostModel> decode(String Data) =>
      (json.decode(Data) as List<dynamic>)
          .map<PostModel>((item) => PostModel.fromJson(item))
          .toList();
}
