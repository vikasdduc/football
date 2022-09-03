class Profile {
  var _name,
      _email,
      _password,
      _dob,
      _gender,
      _address,
      _city,
      _state,
      _team_name;
  var _id,
      _status,
      _credit,
      _is_email_verified,
      _is_pan_verified,
      _is_bank_verified;
  var _pincode,
      __phone,
      _pan_card,
      _bank_details,
      _balance,
      _user_level,
      _total_point,
      _profile_image;

  Profile(
    this._id,
    this._name,
    this._email,
    this._password,
    this._dob,
    this._gender,
    this._address,
    this._city,
    this._state,
    this._pincode,
    this.__phone,
    this._pan_card,
    this._bank_details,
    this._status,
    this._balance,
    this._credit,
    this._user_level,
    this._total_point,
    this._team_name,
    this._profile_image,
    this._is_email_verified,
    this._is_pan_verified,
    this._is_bank_verified,
  );

  factory Profile.fromJson(dynamic data) {
    return Profile(
      data['id'],
      data['name'],
      data['email'],
      data['password'],
      data['dob'],
      data['gender'],
      data['address'],
      data['city'],
      data['state'],
      data['pincode'],
      data['phone'],
      data['pan_card'],
      data['bank_details'],
      data['status'],
      data['balance'],
      data['credit'],
      data['user_level'],
      data['total_point'],
      data['team_name'],
      data['profile_image'],
      data['is_email_verified'],
      data['is_pan_verified'],
      data['is_bank_verified'],
    );
  }

  get is_email_verified => _is_email_verified;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'email': _email,
      'password': _password,
      'dob': _dob,
      'gender': _gender,
      'address': _address,
      'city': _city,
      'state': _state,
      'pincode': _pincode.toString(),
      'phone': __phone.toString(),
      'pan_card': this._pan_card,
      'bank_details': this._bank_details,
      'status': this._status,
      'balance': this._balance,
      'credit': this._credit,
      'user_level': this._user_level,
    };
  }

  get total_point => _total_point;

  get pan_card => _pan_card;

  Map<String, dynamic> toJsonForSaving() {
    return {
      'id': _id,
      'name': _name,
      'gender': _gender,
      'address': _address,
      'city': _city,
      'state': _state,
      'pincode': _pincode.toString(),
      'phone': __phone.toString()
    };
  }

  get team_name => _team_name;

  get credit => _credit;

  get phone => __phone;

  set phone(value) {
    __phone = value;
  }

  get profile_image => _profile_image;

  get _phone => __phone;

  get pincode => _pincode;

  set pincode(value) {
    _pincode = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  get state => _state;

  set state(value) {
    _state = value;
  }

  get city => _city;

  set city(value) {
    _city = value;
  }

  get address => _address;

  set address(value) {
    _address = value;
  }

  get gender => _gender;

  set gender(value) {
    _gender = value;
  }

  get dob => _dob;

  set dob(value) {
    _dob = value;
  }

  get password => _password;

  set password(value) {
    _password = value;
  }

  get email => _email;

  set email(value) {
    _email = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  get status => _status;

  get bank_details => _bank_details;

  get balance => _balance;

  get user_level => _user_level;

  get is_pan_verified => _is_pan_verified;

  get is_bank_verified => _is_bank_verified;
}
