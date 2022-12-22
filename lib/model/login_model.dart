import 'package:meta/meta.dart';
import 'dart:convert';

LogInModel welcomeFromJson(String str) => LogInModel.fromJson(json.decode(str));

String welcomeToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  LogInModel({
    required this.token,
  });

  final String token;

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
