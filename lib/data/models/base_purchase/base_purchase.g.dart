// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_purchase.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasePurchaseAdapter extends TypeAdapter<BasePurchase> {
  @override
  final int typeId = 6;

  @override
  BasePurchase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasePurchase(
      name: fields[0] as String,
      itemsKey: (fields[1] as List).cast<int>(),
      createdAt: fields[2] as String,
      updatedAt: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BasePurchase obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.itemsKey)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasePurchaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
