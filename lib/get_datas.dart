import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

Future<List<dynamic>> readJson() async {
  final String response =
      await rootBundle.loadString('dataset/json/example_datas.json');
  final data = await json.decode(response);

  return List<dynamic>.from(data['Sikayetler ve Problemler']);
}

  // final file = File(
  //     'dataset\\json\\example_datas.json'); // JSON dosyasının yolunu buraya girin

  // if (await file.exists()) {
  //   final jsonString = await file.readAsString();
  //   final data = json.decode(jsonString);
  //   return List<dynamic>.from(data['SikayetlerveProblemler']);
  // } else {
  //   throw Exception('JSON dosyası bulunamadı');
  // }

