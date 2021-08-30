import 'dart:collection';

import 'package:cripto_moedas/adapters/moeda_hive_adapter.dart';
import 'package:cripto_moedas/models/moedas_models.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritasData extends ChangeNotifier {
  List<MoedasModels> _lista = [];
  late LazyBox box;

  FavoritasData() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritas();
  }

  _openBox() async {
    Hive.registerAdapter(MoedaHiveAdapter());
    box = await Hive.openLazyBox<MoedasModels>('moedas_favoritas');
  }

  _readFavoritas() {
    box.keys.forEach((moeda) async {
      MoedasModels m = await box.get(moeda);
      _lista.add(m);
      notifyListeners();
    });
  }

  UnmodifiableListView<MoedasModels> get lista => UnmodifiableListView(_lista);

  saveAll(List<MoedasModels> moedas) {
    moedas.forEach((moeda) {
      if (!_lista.any((atual) => atual.subTitle == moeda.subTitle)) {
        _lista.add(moeda);
        box.put(moeda.subTitle, moeda);
      }
    });
    notifyListeners();
  }

  remove(MoedasModels moeda) {
    _lista.remove(moeda);
    box.delete(moeda.subTitle);
    notifyListeners();
  }
}
