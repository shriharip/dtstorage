library tstorage;

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
/// The storage class extends changeNotifier.
/// This is to make sure that we can dispose the stream of values when 
/// the app is removed from the tree
///  Just create a Storage instance Storage()
/// we always return the static instance of the class with the file path  set to default 'storage.txt' ()  
class Storage extends ChangeNotifier {
  StreamController val =  BehaviorSubject();
  String fpath;
  File _f;
  String _path;

  Storage._();

static final Storage _instance = Storage._();
 
 factory Storage({String fpath}){
   _instance.fpath = fpath ?? 'storage.txt';
   return _instance;
 }

 Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    _path = _path == null ?  await _localPath + '/$fpath' : _path ;
   _f = _f ?? File(_path);
  return _f;
  }
/// you can also read the file to make changes outside the class 
/// this will result in error for reading value so please excerise caution
/// 
  Future<File> get file => _localFile;

/// Storage().read('count', 0) will give you a count key set to default value 0
/// The default value will help to create a non null value in the stream being listened

  Future<void> read(String key, {dynamic defaultValue}) async {
     try {
      final filep = await _localFile;
      // Read the file
      String contents = await filep.readAsString();
      Map<String, dynamic> dbval = json.decode(contents);
      val.sink.add(dbval[key]);  //can contain null values
       } catch (e) {
      // If encountering an error, return 0
     defaultValue == null ? val.sink.add(null) : val.sink.add(defaultValue);
    }
 }

 Future<bool> write(String key,  dynamic data) async {
    try {
      final filep = await _localFile;
      if (filep.existsSync()) { 
      String contents = await filep.readAsString();
      Map<String, dynamic> dbval = json.decode(contents);
      dbval[key] = data;
      String stval = json.encode(dbval);
       filep.writeAsString(stval);
      } else {
       Map<String, dynamic> dbval = Map(); 
       dbval[key] = data;
       String stval = json.encode(dbval);
        filep.writeAsString(stval);
      }
        read(key); //so our stream val has latest value
      return true;
        } catch (e) {
      // If encountering an error, return 0
      return false;
    }
 }

 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    val.close();
  }

}


