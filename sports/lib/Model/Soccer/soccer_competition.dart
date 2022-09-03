class SoccerCompetition {
  String cid,
      cname,
      startdate,
      enddate,
      year,
      category,
      tournament_id,
      category_id,
      ioc,
      status,
      status_str,
      logo,
      competition_url,
      team_url,
      match_url,
      stats_url;

  SoccerCompetition.fromJson(json) {
    cid = json['cid'] == null ? '0' : json['cid'];
    cname = json['cname'] == null ? '' : json['cname'];
    startdate = json['startdate'] == null ? '' : json['startdate'];
    enddate = json['enddate'] == null ? '' : json['enddate'];
    year = json['year'] == null ? '' : json['year'];
    category = json['category'] == null ? '' : json['category'];
    tournament_id = json['tournament_id'] == null ? '' : json['tournament_id'];
    category_id = json['category_id'] == null ? '' : json['category_id'];
    ioc = json['ioc'] == null ? '' : json['ioc'];
    status = json['status'] == null ? '' : json['status'];
    status_str = json['status_str'] == null ? '' : json['status_str'];
    logo = json['logo'] == null ? '' : json['logo'];
    competition_url =
        json['competition_url'] == null ? '' : json['competition_url'];
    team_url = json['team_url'] == null ? '' : json['team_url'];
    match_url = json['match_url'] == null ? '' : json['match_url'];
    stats_url = json['stats_url'] == null ? '' : json['stats_url'];
  }
}
