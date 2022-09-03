import 'dart:math';

import 'package:dio/dio.dart';

class kyc {
  int _id = 1241424;
  dynamic _pan, _bank;
  String _team_name;

  kyc(this._pan, this._bank, this._team_name);

  get bank => _bank;

  int get id => _id;

  get pan => _pan;

  get team_name => _team_name;
}
