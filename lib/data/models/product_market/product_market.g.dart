// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_market.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductMarketAdapter extends TypeAdapter<ProductMarket> {
  @override
  final int typeId = 7;

  @override
  ProductMarket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductMarket(
      productKey: fields[0] as int,
      marketKey: fields[1] as int,
      price: fields[2] as double,
      updatedAt: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductMarket obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.productKey)
      ..writeByte(1)
      ..write(obj.marketKey)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductMarketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
