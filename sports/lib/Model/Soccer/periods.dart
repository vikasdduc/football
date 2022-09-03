class Periods {
  // "home": 1,
  // "away": 1
  int home, away;

  Periods.fromJson(json) {
    home = json['home'] == null ? 0 : int.parse(json['home'].toString());
    away = json['away'] == null ? 0 : int.parse(json['away'].toString());
  }
}

class SpeificPeriods {
  Periods p1, p2, ft;
//periods: {p1: {home: 1, away: 1}, p2: {home: 1, away: 1}, ft: {home: 2, away: 2}}
//periods: {p1: {home: 1, away: 0}, p2: {home: 2, away: 1}, ft: {home: 3, away: 1}}
//periods: {p1: {home: 1, away: 1}, p2: {home: 0, away: 1}, ft: {home: 1, away: 2}}

  SpeificPeriods.fromJson(json) {
    // print(json['p1']);
    try {
      p1 = Periods.fromJson(json['p1']);
    } catch (e) {
      print(e);
    }
    try {
      p2 = Periods.fromJson(json['p2']);
    } catch (e) {
      print(e);
    }
    try {
      ft = Periods.fromJson(json['ft']);
    } catch (e) {
      print(e);
    }
  }
}
