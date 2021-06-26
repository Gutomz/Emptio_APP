// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_purchase_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasePurchaseItemAdapter extends TypeAdapter<BasePurchaseItem> {
  @override
  final int typeId = 5;

  @override
  BasePurchaseItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasePurchaseItem(
      productKey: fields[0] as int,
      quantity: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BasePurchaseItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.productKey)
      ..writeByte(1)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasePurchaseItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
