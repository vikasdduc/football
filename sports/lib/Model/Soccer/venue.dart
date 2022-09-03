

class Venue{
  // "venueid": "230",
  // "name": "Åråsen",
  // "location": "Lillestrom, Norway",
  // "founded": "1951",
  // "capacity": "11500",
  // "googlecoords": "59.962752,11.063458"
  String venueid,name,location,founded,capacity,googlecoords;

  Venue.fromJson(json){
    venueid = json['venueid']==null?'':json['venueid'];
    name= json['name']==null?'':json['name'];
    location = json['location']==null?'':json['location'];
    founded = json['founded']==null?'':json['founded'];
    capacity = json['capacity']==null?'':json['capacity'];
    googlecoords = json['googlecoords']==null?'':json['googlecoords'];
  }


}