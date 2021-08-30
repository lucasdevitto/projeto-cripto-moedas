
import 'package:cripto_moedas/models/moedas_models.dart';
import 'package:hive/hive.dart';

class MoedaHiveAdapter extends TypeAdapter<MoedasModels> {
  @override
  final typeId = 0;

  @override
  MoedasModels read(BinaryReader reader) {
    return MoedasModels(
      icone: reader.readString(),
      title: reader.readString(),
      subTitle: reader.readString(),
      price: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, MoedasModels obj) {
    writer.writeString(obj.icone);
    writer.writeString(obj.title);
    writer.writeString(obj.subTitle);
    writer.writeDouble(obj.price);
  }
}
