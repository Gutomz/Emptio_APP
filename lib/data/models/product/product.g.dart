// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      brand: fields[0] as String,
      name: fields[1] as String,
      variation: fields[2] as String,
      image: fields[3] as String?,
      weight: fields[4] as Measurement,
      tags: (fields[5] as List).cast<String>(),
      createdAt: fields[6] as String,
      updatedAt: fields[7] as String,
      marketPrice: fields[8] as double?,
      marketPriceUpdatedAt: fields[9] as String?,
    )..deleted = fields[10] as bool;
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.brand)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.variation)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.tags)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.marketPrice)
      ..writeByte(9)
      ..write(obj.marketPriceUpdatedAt)
      ..writeByte(10)
      ..write(obj.deleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
