import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
// Модель данных для пользователя
class User {
  final String id; // Идентификатор пользователя
  final String name; // Имя пользователя
  final String photoUrl; // URL фотографии пользователя

  // Конструктор класса User
  User({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  // Фабричный метод для создания объекта User из JSON
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Метод для конвертации объекта User в JSON
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
