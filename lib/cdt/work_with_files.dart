import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class WWF {

  Future<String> get ApplicationDocumentsDirectoryPath async {
    final path = await getApplicationDocumentsDirectory();
    return path.path;
  }

  Future<File> DatFile(String file_name) async {
    final FilePath = await ApplicationDocumentsDirectoryPath;
    return new File('$FilePath/$file_name.dat');
  }

  Future<File> writeToFile(String file_name, String value) async {
    final file = await DatFile(file_name);
    return file.writeAsString(value);
  }

  Future<String> readFromFile(String file_name) async {
    try {
      final file = await DatFile(file_name);
      final String data = file.readAsStringSync();

      return data;

    } catch (e) {
      throw PlatformException(code: e.toString());
    }
  }

  Future<bool> checkExistFile(String path) async {
    return await File(path).exists();
  }

  // ---------[ map => str | str => map ]---------

  String mapToString(Map map) {
    final String string = map.toString();
    return string;
  }

  Map stringToMap(String string) {
    final Map map = jsonDecode(string);
    return map;
  }

  // --------[ utf8.encode | utf8.decode ]-------

  /// Encrypt from user text to utf8
  String enc(String input) {
    String result = utf8.encode(input).toString();
    return result;
  }

  /// Encrypt from utf8 text to user text
  String dec(String input) {
    List<int> li = json.decode(input).cast<int>();
    String result = utf8.decode(li);
    return result;
  }
}