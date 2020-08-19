// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['index'] as int,
    json['guid'] as String,
    json['isActive'] as bool,
    json['balance'] as String,
    json['picture'] as String,
    json['age'] as int,
    json['eyeColor'] as String,
    json['name'] as String,
    json['company'] as String,
    json['email'] as String,
    json['phone'] as String,
    json['address'] as String,
    json['about'] as String,
    json['registered'] == null
        ? null
        : DateTime.parse(json['registered'] as String),
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    (json['tags'] as List)?.map((e) => e as String)?.toList(),
    (json['range'] as List)?.map((e) => e as int)?.toList(),
    (json['friends'] as List)
        ?.map((e) =>
            e == null ? null : Friend.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['greeting'] as String,
    _$enumDecodeNullable(_$FruitEnumMap, json['favoriteFruit']),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'guid': instance.guid,
      'isActive': instance.isActive,
      'balance': instance.balance,
      'picture': instance.picture,
      'age': instance.age,
      'eyeColor': instance.eyeColor,
      'name': instance.name,
      'company': instance.company,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'about': instance.about,
      'registered': instance.registered?.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'tags': instance.tags,
      'range': instance.range,
      'friends': instance.friends,
      'greeting': instance.greeting,
      'favoriteFruit': _$FruitEnumMap[instance.favoriteFruit],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$FruitEnumMap = {
  Fruit.apple: 'apple',
  Fruit.banana: 'banana',
  Fruit.strawberry: 'strawberry',
};
