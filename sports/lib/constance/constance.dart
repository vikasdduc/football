import 'dart:convert';

import 'package:fantacySports/Language/LanguageData.dart';
import 'package:fantacySports/Model/Anounced.dart';
import 'package:fantacySports/Model/Commentaries/commentary.dart';
import 'package:fantacySports/Model/Competition.dart';
import 'package:fantacySports/Model/GetTeam.dart';
import 'package:fantacySports/Model/Matche.dart';
import 'package:fantacySports/Model/Players.dart';
import 'package:fantacySports/Model/Profile.dart';
import 'package:fantacySports/Model/Scorecard/Innings.dart';
import 'package:fantacySports/Model/Scorecard/Innings.dart';
import 'package:fantacySports/Model/Soccer/soccer_match.dart';
import 'package:fantacySports/Model/Soccer/soccer_player.dart';
import 'package:fantacySports/Model/Team.dart';
import 'package:fantacySports/Model/Transaction.dart';
import 'package:fantacySports/Model/contest.dart';
import 'package:fantacySports/Model/notification.dart';
import 'package:fantacySports/Model/player_points.dart';
import 'package:flutter/material.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Banner.dart';
import '../Model/ContestJoined.dart';
import '../Model/Date_transaction.dart';
import '../Model/LeaderBoardItem.dart';
import '../Model/LeaderBoardItem.dart';
import '../Model/Recently_Played.dart';
import '../Model/Selby_Player.dart';
import '../Model/Total_Level.dart';
import '../Model/contest_joined.dart';
import '../Model/fantasy_point_action.dart';
import '../Model/leaderboard_outside.dart';
import '../Model/match_new.dart';
import '../Model/seriesItem.dart';
import '../Model/updated_transaction.dart';
import '../Model/user_play_history.dart';

enum CompetitionType { live, completed, upcoming, def }

class ConstanceData {
  static const BaseImageUrl = 'assets/images/';

  static final batsmanLogo = BaseImageUrl + "batsmanLogo.webp";
  static final homeLogo = BaseImageUrl + "logo-white.webp";
  static final finalLogo = BaseImageUrl + "logo-red.webp";
  static final palyerProfilePic = BaseImageUrl + "playerProfilePic.webp";
  static final messyPic = BaseImageUrl + "ads.webp";
  static final mumbaiIndians = BaseImageUrl + "mumbaiIndians.webp";
  static final kolkata = BaseImageUrl + "kolkata.webp";
  static final banglore = BaseImageUrl + "banglore.webp";
  static final baslider1 = BaseImageUrl + "baslider1.webp";
  static final baslider2 = BaseImageUrl + "baslider2.webp";
  static final baslider3 = BaseImageUrl + "baslider3.webp";
  static final baslider4 = BaseImageUrl + "baslider4.webp";
  static final bslider1 = BaseImageUrl + "bslider1.webp";
  static final bslider2 = BaseImageUrl + "bslider2.webp";
  static final bslider3 = BaseImageUrl + "bslider3.webp";
  static final bslider4 = BaseImageUrl + "bslider4.webp";
  static final bslider6 = BaseImageUrl + "bslider6.webp";
  static final channai = BaseImageUrl + "channai.webp";
  static final delhiCapital = BaseImageUrl + "delhiCapital.webp";
  static final fslider1 = BaseImageUrl + "fslider1.webp";
  static final fslider2 = BaseImageUrl + "fslider2.webp";
  static final fslider3 = BaseImageUrl + "fslider3.webp";
  static final fslider4 = BaseImageUrl + "fslider4.webp";
  static final hslider1 = BaseImageUrl + "hslider1.webp";
  static final hslider2 = BaseImageUrl + "hslider2.webp";
  static final hslider3 = BaseImageUrl + "hslider3.webp";
  static final hslider4 = BaseImageUrl + "hslider4.webp";
  static final hyderabad = BaseImageUrl + "hyderabad.webp";
  static final nslider1 = BaseImageUrl + "nslider1.webp";
  static final nslider2 = BaseImageUrl + "nslider2.webp";
  static final nslider3 = BaseImageUrl + "nslider3.webp";
  static final nslider4 = BaseImageUrl + "nslider4.webp";
  static final panjab = BaseImageUrl + "panjab.webp";
  static final rajsthanRoyal = BaseImageUrl + "rajsthanRoyal.webp";
  static final slider1 = BaseImageUrl + "slider1.webp";
  static final slider2 = BaseImageUrl + "slider2.webp";
  static final slider3 = BaseImageUrl + "slider3.webp";
  static final slider4 = BaseImageUrl + "slider4.webp";
  static final cricketerPic = BaseImageUrl + "cricketerPic.webp";
  static final cricketGround = BaseImageUrl + "field.webp";
  static final soccerGround = BaseImageUrl + "soccer.png";
  static final coupons = BaseImageUrl + "coupons.webp";
  static final group = BaseImageUrl + "group.webp";
  static final baseballPlayer = BaseImageUrl + "baseballPlayer.webp";
  static final basketballPlayer = BaseImageUrl + "basketballPlayer.webp";
  static final handballPlayer = BaseImageUrl + "handballPlayer.webp";
  static final hockyPlayer = BaseImageUrl + "hockyPlayer.webp";
  static final volleyballPlyer = BaseImageUrl + "volleyballPlyer.webp";
  static final kabadiplayer = BaseImageUrl + "kabadiplayer.webp";
  static final cricketPlayer = BaseImageUrl + "cricketPlayer.webp";
  static final footballPlayer = BaseImageUrl + "footballPlayer.webp";
  static final nflPlayer = BaseImageUrl + "nflPlayer.webp";

  static final archer = BaseImageUrl + "archer.webp";
  static final buttler = BaseImageUrl + "buttler.webp";
  static final chahal = BaseImageUrl + "chahal.webp";
  static final finch = BaseImageUrl + "finch.webp";
  static final defaultPlayer = BaseImageUrl + "player.webp";
  static final steyn = BaseImageUrl + "steyn.webp";
  static final stokes = BaseImageUrl + "stokes.webp";
  static final villiers = BaseImageUrl + "villiers.webp";
  static final smith = BaseImageUrl + "smith.webp";
  static final morris = BaseImageUrl + "morris.webp";
  static final jaiswal = BaseImageUrl + "jaiswal.webp";
  static final joshi = BaseImageUrl + "joshi.webp";
  static final rawat = BaseImageUrl + "rawat.webp";
  static final rewatia = BaseImageUrl + "rewatia.webp";
  static final siraj = BaseImageUrl + "siraj.webp";
  static final baseballPoint = BaseImageUrl + "baseballPoint.webp";
  static final basketPoint = BaseImageUrl + "basketPoint.webp";
  static final crickeyPoint = BaseImageUrl + "crickeyPoint.webp";
  static final footballPoint = BaseImageUrl + "footballPoint.webp";
  static final handballPoint = BaseImageUrl + "handballPoint.webp";
  static final nflPoint = BaseImageUrl + "nflPoint.webp";
  static final googlePay = BaseImageUrl + "googlePay.webp";
  static final razorPay = BaseImageUrl + "razorPay.webp";

  static final Color whiteFontColor = Colors.white;
  static final Color buttonColor = Color(0xff317E2F);

  static final url = "https://theapnateam.com/admin/public/api/";
  static final url_auth = "https://theapnateam.com/admin/public/api/auth/";
  static final app_key = "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE";

  static final base_url = "https://rest.entitysport.com/v2/";
  static final token = "a19d9c54e35df40ad67828a71320726c";

  static final tNC = "https://apnateam.co.in/terms-condition.html";
  static final privacy = "https://apnateam.co.in/privacy-policy.html";
  static final refund = "https://apnateam.co.in/refund.html";
  static final website = "https://apnateam.co.in/";
  static final String mid='avkHWu94477167485218';
  static final String cashfreeID='202620e3a4300451134c47919f026202';
  static final String callbackurl='https://securegw.paytm.in/theia/paytmCallback';
  static final bool isStaging=false;
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  static var access_token;

  static total_level level;

  static var wallet_amount=0;
  static var winnings=0;


  static setLvl(total_level lvl) async {
    level = lvl;
  }

  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = token;
    print('e ${token}');
    await prefs.setString('access_token', token.toString());
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('ad ${prefs.get('access_token')}');
    return prefs.get('access_token');
  }

  static clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static  List<banner>bannerList = new List<banner>();

  static setBanner(List<banner>list){
    bannerList = list;
  }

  static List<GetTeam> mylist;

  static setMyList(List<GetTeam> list) {
    mylist = list;
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  static var id = null;

  static setId(dynamic ids) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = ids;
    print('set Id ${ids}');
    await prefs.setString('access', ids.toString());
  }

  static getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('access');
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  static Profile prof;

  static setProfile(Profile pro) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prof = pro;
    await prefs.setString('profile', pro.toJson().toString());
  }

  static getProf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prof = Profile.fromJson(jsonDecode(prefs.get('profile')));
  }

  static var entryList = [
    "₹1-₹50",
    "₹51-₹100",
    "₹101-₹1,000",
    "₹1,001 & above",
  ];
  static var teamsList = [
    "2",
    "3-10",
    "11-100",
    "1,000 & above",
  ];

  static var prizeList = [
    "₹1-₹10,000",
    "₹10,000-₹1 Lakh",
    "₹1 Lakh-₹10 Lakh",
    "₹10 Lakh-₹25 Lakh",
  ];

  static var teamTypes = [
    "Single Entry",
    "Multi Entry",
    "Single Winner",
    "Multi Winner",
    "Guaranteed",
  ];

  static int entry;
  static int teams;
  static int prize;
  static int type;
  static List<Notifications> notifications;

  static List<leaderBoard> leaderboard = new List<leaderBoard>();

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  static int competitionNo;
  static int competitionNoLive;
  static int competitionNoComplete;
  static int competitionNoSchedule;

  static List<UpdatedTransaction> transactions=[];
  // static List<date_transaction> transactions=[];

  static FragNavigate fragNav;

  static setNav(FragNavigate frag) {
    fragNav = frag;
  }

  static List<fantasy_point_action> listOne = List<fantasy_point_action>();
  static List<fantasy_point_action> listBonus = List<fantasy_point_action>();
  static List<fantasy_point_action> listEconomy = List<fantasy_point_action>();
  static List<fantasy_point_action> listStrike = List<fantasy_point_action>();





  static GlobalKey discounted = GlobalKey();
  static GlobalKey beginners = GlobalKey();
  static GlobalKey headtohead = GlobalKey();
  static GlobalKey low_entry = GlobalKey();
  static GlobalKey mega = GlobalKey();
  static GlobalKey high_reward = GlobalKey();

  static List<Contest> contests = new List<Contest>();
  static List<Contest> Mycontests = new List<Contest>();
  static List<ContestJoined> specific_contests = new List<ContestJoined>();
  static List<leaderboard_outside> leaderboardoutside = new List<leaderboard_outside>();
  static user_play_History leader;

  static setLeader(user_play_History list) async {
    leader = list;
    print('lead ${list}');
  }

  static List<recently_played> recently_played_list = List<recently_played>();

  static List<Contest> fileteredContests;

  static List<competition> competitionlist;
  static List<competition> livecompetitionlist;
  static List<competition> Compcompetitionlist;
  static List<competition> Schedcompetitionlist;

  static setTransactions(List<UpdatedTransaction> list) async {
  // static setTransactions(List<date_transaction> list) async {
    transactions = list;
    print('length ${list.length}');
  }
  static addTransactions(List<UpdatedTransaction> list) async {
  // static addTransactions(List<date_transaction> list) async {
    transactions.addAll(list);
    print('length ${list.length}');
  }

  static setRecently_played_list(List<recently_played> list) async {
    recently_played_list = list;
  }

  static setleaderboard(List<leaderBoard> list) async {
    leaderboard = list;
  }

  static setMyContests(List<Contest> list) async {
    Mycontests = list;
  }

  static setSpecific_contests(List<ContestJoined> list) async {
    specific_contests = list;
    print('a2ads ${list}');
  }

  static setContests(List<Contest> list) async {
    contests = list;
    fileteredContests = list;
  }

  static setCompetition(List<competition> list) async {
    competitionlist = list;
  }

  static setLiveCompetition(List<competition> list) async {
    livecompetitionlist = list;
  }

  static setCompCompetition(List<competition> list) async {
    Compcompetitionlist = list;
  }

  static setSchedCompetition(List<competition> list) async {
    Schedcompetitionlist = list;
  }

  static List<competition> filteredcompetitionlist = new List<competition>();
  static List<competition> filteredLivecompetitionlist =
      new List<competition>();
  static List<competition> filteredCompcompetitionlist =
      new List<competition>();
  static List<competition> filteredShedcompetitionlist =
      new List<competition>();

  static filterCompetition(List<competition> list) async {
    for (var i in list) {
      if (!i.game_format.toString().contains('women')) {
        filteredcompetitionlist.add(i);
      } else {}
    }
  }

  static filterLiveCompetition(List<competition> list) async {
    for (var i in list) {
      if (!i.game_format.toString().contains('women')) {
        filteredLivecompetitionlist.add(i);
      } else {}
    }
  }

  static filterCompCompetition(List<competition> list) async {
    for (var i in list) {
      if (!i.game_format.toString().contains('women')) {
        filteredCompcompetitionlist.add(i);
      } else {}
    }
  }

  static filterShedCompetition(List<competition> list) async {
    for (var i in list) {
      if (!i.game_format.toString().contains('women')) {
        filteredShedcompetitionlist.add(i);
      } else {}
    }
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  static List<String> competitionIds = new List<String>();
  static List<String> LivecompetitionIds = new List<String>();
  static List<String> SchedcompetitionIds = new List<String>();
  static List<String> CompcompetitionIds = new List<String>();

  static List<SeriesItem> seriesPlayed = new List<SeriesItem>();

  static addIDs(String id) async {
    competitionIds.add(id);
  }

  static contest_joined contest_joined_bill;

  static setSeriesPlayeds(List<SeriesItem> list) async {
    seriesPlayed = list;
    print('got the series ${list}');
  }

  static addLiveIDs(String id) async {
    LivecompetitionIds.add(id);
  }

  static addSchedIDs(String id) async {
    SchedcompetitionIds.add(id);
  }

  static addCompIDs(String id) async {
    CompcompetitionIds.add(id);
  }

  static List<match> matchlist;
  static List<match> matchUpcominglist = [];
  static List<match> matchLivelist;
  static List<match> matchSchedlist;
  static List<match> matchJoined=[];
  static List<match_new> matchComplist =[];
  static List<SoccerMatch> soccermatchlist=[];
  static List<SoccerMatch> soccerUpcominglist = [];
  static List<SoccerMatch> soccerLivelist;
  static List<SoccerMatch> soccerSchedlist;
  static List<SoccerMatch> soccerJoined=[];

  static setMatch(List<match> list) async {
    matchlist = list;
  }

  static addMatch(List<match> list) async {
    if (matchlist == null) {
      matchlist = new List<match>();
    }
    matchlist.add(list[0]);
  }

  static setSchedMatch(List<match> list) async {
    matchSchedlist = list;
  }

  static addSchedMatch(List<match> list) async {
    if (matchSchedlist == null) {
      matchSchedlist = new List<match>();
    }
    matchSchedlist.addAll(list);
  }
  static setJoinedMatch(List<match> list) async {
    matchJoined = list;
  }

  static addJoinedMatch(List<match> list) async {
    if (matchJoined == null) {
      matchJoined = new List<match>();
    }
    matchJoined.addAll(list);
  }

  static setLiveMatch(List<match> list) async {
    print('match set');
    matchLivelist = list;
  }

  static addLiveMatch(match list) async {
    if (matchLivelist == null) {
      matchLivelist = new List<match>();
    }
    matchLivelist.add(list);
  }
  static setSoccerMatch(List<SoccerMatch> list) async {
    soccermatchlist = list;
  }

  static addsoccerMatch(List<SoccerMatch> list) async {
    if (soccermatchlist == null) {
      soccermatchlist = [];
    }
    soccermatchlist.add(list[0]);
  }

  static setSchedSoccerMatch(List<SoccerMatch> list) async {
    soccerSchedlist = list;
  }

  static addSchedSoccerMatch(List<SoccerMatch> list) async {
    if (soccerSchedlist== null) {
      soccerSchedlist = [];
    }
    soccerSchedlist.addAll(list);
  }
  static setJoinedSoccerMatch(List<SoccerMatch> list) async {
    soccerJoined = list;
  }

  static addJoinedSoccerMatch(List<SoccerMatch> list) async {
    if (soccerJoined == null) {
      soccerJoined = [];
    }
    soccerJoined.addAll(list);
  }

  static setLiveSoccerMatch(List<SoccerMatch> list) async {
    print('match set');
    soccerLivelist = list;
  }

  static addLiveSoccerMatch(SoccerMatch list) async {
    if (soccerLivelist == null) {
      soccerLivelist = [];
    }
   soccerLivelist.add(list);
  }

  static setCompMatch(List<match_new> list) async {
    matchComplist = list;
    print('xca ${list.length}');
  }

  static addCompMatch(List<match_new> list) async {
    if ( matchComplist == null) {
      matchComplist = new List<match_new>();
    }
    matchComplist.addAll(list);
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  static bool data = false;
  static List<players> selectedPlayers = new List<players>();
  static List<players> teamA = new List<players>();
  static List<players> teamB = new List<players>();
  static List<players> teamCombine = new List<players>();

  static List<SoccerPlayer> soccerTeamA=[];
  static List<SoccerPlayer> soccerTeamB=[];
  static List<SoccerPlayer> soccerTeamCombine=[];
  static List<SoccerPlayer> soccerSelectedPlayers=[];

  static List<Anounced> anouncedTeamA;
  static List<Anounced> anouncedTeamB;

  static List<innings> Innings = new List<innings>();
  static List<commentaries> CommentariesA = new List<commentaries>();
  static List<commentaries> CommentariesB = new List<commentaries>();
  static List<commentaries> CommentariesCombo = new List<commentaries>();

  static setCommentariesA(List<commentaries> list) {
    CommentariesA = list.toList(growable: false);

    setCommentariesCombo(CommentariesA, CommentariesB);
  }

  static setCommentariesB(List<commentaries> list) {
    CommentariesB = list.toList(growable: false);

    setCommentariesCombo(CommentariesA, CommentariesB);
  }

  static setCommentariesCombo(
      List<commentaries> list, List<commentaries> list1) {
    if (list == null || list.isEmpty) {
      List<commentaries> list3 = list1;
      CommentariesCombo = new List<commentaries>();
      CommentariesCombo.addAll(list3.toList(growable: false));
    } else if (list1 == null || list1.isEmpty) {
      List<commentaries> list3 = list;
      CommentariesCombo.addAll(list3.toList(growable: false));
    } else {
      try {
        List<commentaries> list3 = list + list1;
        CommentariesCombo.addAll(list3.toList(growable: false));
      } catch (e) {
        print('${e} ${list.length} ${list1.length}');
      }
    }
  }

  static setInnings(List<innings> list) {
    Innings = list.toList(growable: false);
  }

  static setAnnouncedA(List<Anounced> list) {
    anouncedTeamA = list;
  }

  static setAnnouncedB(List<Anounced> list) {
    anouncedTeamB = list;
  }

  static List<List<Player_Points>> teamA_points =
      new List<List<Player_Points>>();
  static List<List<Player_Points>> teamB_points =
      new List<List<Player_Points>>();
  static List<Player_Points> teamCombine_points = new List<Player_Points>();

  static addTeamA(List<players> list) {
    teamA = new List<players>();
    if (list.length > 1) {
      teamA.addAll(list);
    }
  }

  static addTeamB(List<players> list) {
    teamB = new List<players>();
    if (list.length > 1) {
      teamB.addAll(list);
    }
  }

  static List<selby_Player> selby_Player_list = List<selby_Player>();

  static setselby_Player(List<selby_Player> list) {
    selby_Player_list = list;
  }

  static setTeam(List<players> list, List<players> list1) {
    teamCombine = new List<players>();
    List<players> list3 = list + list1;
    teamCombine.addAll(list3);
    teamCombine = teamCombine.toList()..shuffle();
    print('a ${list.length} b ${list1.length} ${teamCombine.length}');
  }

  static addTeamA_point(List<Player_Points> list) {
    if (list.length > 1) {
      teamA_points.add(list);
    }
  }

  static addTeamB_point(List<Player_Points> list) {
    if (list.length > 1) {
      teamB_points.add(list);
    }
  }

  static setTeam_point(List<Player_Points> list, List<Player_Points> list1) {
    List<Player_Points> list3 = list + list1;
    teamCombine_points.addAll(list3);
  }

  static int matchIndex;
  static int matchLiveIndex;
  static int matchSchedIndex;
  static int matchCompIndex;

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  List<String> colors = [
    '#EB1165',
    '#32a852',
    '#e6230e',
    '#760ee6',
    '#008080',
    '#4FBE9F'
  ];
}

int colorsIndex = 0;
String locale = "en";
AllTextData allTextData;

var primaryColorString = '#cf0100';

//var primaryColorString = '#061E42';
//0E2F56
var secondaryColorString = '#0E2F56';
