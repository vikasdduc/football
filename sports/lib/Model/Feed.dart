

class feed {
  String _image,_url,_description,_ago;

  feed(this._image, this._url, this._description, this._ago);

  factory feed.fromJson(dynamic json){
    return feed(
      json['image'],
      json['url'],
      json['description'],
      json['ago'],
    );
  }

  get ago => _ago;

  get description => _description;

  get url => _url;

  String get image => _image;
}