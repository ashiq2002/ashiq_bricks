import 'dart:convert';

import 'package:flutter/foundation.dart';

void devLog({required String tag, required Map<String, dynamic> payload}){
  if(kDebugMode){
    print("-----------------Start $tag----------------------");
    try{
      print(const JsonEncoder.withIndent('  ').convert(payload));
    }catch(_){}
    print("-----------------End $tag----------------------\n\n");
  }
}