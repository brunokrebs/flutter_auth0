import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';


class AuthBloc {
  Stream<CodeModel> _output = Stream.empty();
  ReplaySubject<String> _input = ReplaySubject<String>();

  Stream<CodeModel> get output => _output;
  Sink<String> get input => _input;

  AuthBloc() {
    _output = _input.distinct().asyncMap(_onData).asBroadcastStream();
  }

  CodeModel _onData(String initialLink) {
    String authCode;
    CodeModel returnedData;
    if (initialLink.contains("code")) {
      authCode = initialLink.substring(
          initialLink.lastIndexOf("?code=") + 6, initialLink.indexOf("&state"));
      returnedData = CodeModel(valueType: "code", authCode: authCode);
    } else if (initialLink.contains("error")) {
      authCode = initialLink.substring(initialLink.lastIndexOf("?error=") + 7);
      returnedData = CodeModel(valueType: "error", authCode: authCode);
    }
    return returnedData;
  }
}

class CodeModel {
  final String valueType;
  final String authCode;

  CodeModel({
    @required this.valueType,
    @required this.authCode,
  });
}
