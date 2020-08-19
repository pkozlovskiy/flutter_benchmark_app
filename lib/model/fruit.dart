import 'package:json_annotation/json_annotation.dart';

enum Fruit {
  @JsonValue("apple")
  apple,
  @JsonValue("banana")
  banana,
  @JsonValue("strawberry")
  strawberry,
}
