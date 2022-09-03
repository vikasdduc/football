

class contest_joined{
  String _total_fee,_deducted,_payable;

  contest_joined(this._total_fee, this._deducted, this._payable);

  get payable => _payable;

  get deducted => _deducted;

  String get total_fee => _total_fee;
}