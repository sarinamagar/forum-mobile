 import 'dart:convert';

import 'package:crypto/crypto.dart';

String hashPassword(String password) {
    var bytes = utf8.encode(password); 
    var hashedPassword = sha256.convert(bytes).toString();
    return hashedPassword;
  }