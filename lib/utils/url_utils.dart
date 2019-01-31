import 'dart:math';
import 'dart:convert';

import 'package:crypto/crypto.dart';

const String DOMAIN = "domain";
const String CLIENT_ID = "client_id";
const String AUDIENCE = "audience";
const String SCOPES = "scopes";
const String REDIRECT_URI = "redirect_uri";

String codeVerifier;
String codeChallenge;


///To create authorization URL
String getAuthorizationUrl() {
  codeVerifier = _createVerifier();
  codeChallenge = _createChallenge(codeVerifier);
  String authorizationUrl =
      "https://$DOMAIN/authorize?scope=$SCOPES&audience=$AUDIENCE&response_type=code&client_id=$CLIENT_ID&code_challenge=$codeChallenge&code_challenge_method=S256&redirect_uri=$REDIRECT_URI";
  return authorizationUrl;
}

///To create code challenge
String _createChallenge(String verifier) {
  var enc = utf8.encode(verifier);
  var challenge = sha256.convert(enc).bytes;
  return base64UrlEncode(challenge).replaceAll("=", "");
}

///To create code verifier
String _createVerifier() {
  var generator = Random.secure();
  var verifier = List.generate(32, (x) => generator.nextInt(256));
  return base64UrlEncode(verifier).replaceAll("=", "");
}

