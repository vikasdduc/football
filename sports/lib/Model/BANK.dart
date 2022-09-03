class bank{

  String _user_id,_account_name,_account_number,_ifsc_code,_bank_name;
  dynamic _bank_image;

  bank(this._user_id, this._account_name, this._account_number, this._ifsc_code,
      this._bank_name, this._bank_image);

  dynamic get bank_image => _bank_image;

  get bank_name => _bank_name;

  get ifsc_code => _ifsc_code;

  get account_number => _account_number;

  get account_name => _account_name;

  String get user_id => _user_id;
}