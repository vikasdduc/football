import 'dart:async';
import 'dart:async';

import 'package:fantacySports/Model/BANK.dart';
import 'package:fantacySports/Model/Competition.dart';
import 'package:fantacySports/Model/CreateTeam.dart';
import 'package:fantacySports/Model/KYC_Data.dart';
import 'package:fantacySports/Model/LoginData.dart';
import 'package:fantacySports/Model/Matche.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import 'package:fantacySports/Model/SaveProfileData.dart';
import 'package:fantacySports/Model/SignUpData.dart';
import 'package:fantacySports/Networking/NetworkHelper.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/modules/register/verify.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/PAN.dart';
import '../Model/Soccer/soccer_comp_response.dart';
import '../Model/Soccer/soccer_match_response.dart';
import '../Model/Soccer/soccer_player.dart';
import '../Model/cashfree_response.dart';
import '../Model/download_response.dart';
import '../Model/generic_response.dart';
import '../Model/match_point_response.dart';
import '../Model/transaction_history.dart';
import '../Model/wallet_response.dart';

class access_network {
  static var url = ConstanceData.url + 'signup';

  static var google_url = ConstanceData.url_auth + 'google-signup';
  static var kyc_url = ConstanceData.url_auth + 'document-upload';

  static var otp_verify_url = ConstanceData.url + 'otp-verify';
  static var otp_login = ConstanceData.url + 'login-otp';
  static var otp_send_verify_url = ConstanceData.url + 'otp';
  static var orderId_url = ConstanceData.url + 'order_id';
  static var order_complete_url = ConstanceData.url + 'Complete';

  static var transaction_url = ConstanceData.url + 'transaction-list';
  static var entry_url = ConstanceData.url + 'entry';
  static var credit_url = ConstanceData.url + 'credit';

  static var kyc_get_url = ConstanceData.url_auth + 'get-kyc/';
  static var login_url = ConstanceData.url_auth + 'login';
  static var profile_url = ConstanceData.url_auth + 'moreinfo-update';

  static var competition_url =
      ConstanceData.base_url + "seasons/2022/competitions";

  //https://rest.entitysport.com/v2/matches/19887/info
  static var competition_match_url = ConstanceData.base_url + "matches/";

  static var upcoming_match_url = ConstanceData.url + "match_upcoming";
  static var joined_match_url = ConstanceData.url + "user/joined-match";

  static var fantasy_match_url = ConstanceData.base_url + "competitions/";
  static var fantasy_point_url = ConstanceData.base_url + "matches/";

  static var create_team_url = ConstanceData.url + "create_team";
  static var update_team_url = ConstanceData.url + "update-team";
  static var get_team_url = ConstanceData.url + "team_details";

  static var all_contest_url = ConstanceData.url + 'admin/all_contest_list';
  static var winners_url = ConstanceData.url + 'number_of_winners';
  static var check_contest_url = ConstanceData.url + 'check_contest';
  static var check_contest_admin_url =
      ConstanceData.url + 'check_contest_admin';

  static var create_contest_url = ConstanceData.url + 'create_contest';
  static var join_contest_url = ConstanceData.url + 'join_contest';
  static var join_contest_by_code_url =
      ConstanceData.url + 'join_contest_by_code';
  static var user_contest_list_url = ConstanceData.url + 'user_contest_list';
  static var user_contest_by_list_url =
      ConstanceData.url + 'get_user_contest_by_match';

  static var notification_url = ConstanceData.url + 'notification';
  static var level_url = ConstanceData.url + 'user/points_score';
  static var leader_board_url = ConstanceData.url + 'leader_board_list';
  static var user_play_history_url = ConstanceData.url + 'user/play/history';

  static var email_phone_update_url = ConstanceData.url + 'user-profile/update';
  static var get_selby_url = ConstanceData.url + 'get-selected-player-ratio';
  static var recently_url = ConstanceData.url + 'user/recently-match';

  static var competed_match_url = ConstanceData.url + 'user/competed-match';
  static var live_match_url = ConstanceData.url + 'user/live-match';
  static var upcoming_match_user_url =
      ConstanceData.url + 'user/upcoming-match';
  static var leaderboard_contest_url =
      ConstanceData.url + 'get_user_contest_match_leaderboard';
  static var team_details_by_match_url =
      ConstanceData.url + 'team_details_by_match';
  static var getleaderboard_url = ConstanceData.url + 'getleaderboard';

  static var create_bank_detail_url = ConstanceData.url + 'create-bank-detail';
  static var create_pan_detail_url = ConstanceData.url + 'create-pan-detail';
  static var user_image_url = ConstanceData.url + 'user-image-profile/update';

  static var create_query_url = ConstanceData.url + 'create-user-query';
  static var check_app_url = ConstanceData.url + 'check-app-version';

  static var winner_list_url = ConstanceData.url + 'list-winner-mega';

  static var series_list_url = ConstanceData.url + 'participant-series-list';

  static var fantasy_point_brekdown_url =
      ConstanceData.url + 'get-matches-details';
  static var leader_board_list_week_url =
      ConstanceData.url + 'leader_board_list_week';
  static var leader_board_list_series_url =
      ConstanceData.url + 'leader_board_list';

  static var get_week_info_url = ConstanceData.url + 'get-week-info';

  static var feed_details_url = ConstanceData.url + 'feed-details';

  static var get_coupon_url = ConstanceData.url + 'coupon';
  static var apply_coupon_url = ConstanceData.url + 'coupon-apply';

  static var send_otp_url = ConstanceData.url + 'info_change_send_otp';
  static var verify_otp_url = ConstanceData.url + 'info_change_verify_otp';

  static var player_points_url =
      ConstanceData.url + 'player/points/competition';
  static var match_points_url = ConstanceData.url + 'getTeamPoints';

  static var transaction_history_req_url =
      ConstanceData.url + 'transaction-history-req';

  static var paytm_do_payment_url = ConstanceData.url + 'paytm/do-payment';

  static var banner_list_url = ConstanceData.url + 'banner-list';
  static var email_verify_url = ConstanceData.url + 'email_verify';
  static var transactionStatus_url =
      ConstanceData.url + 'paytm-transaction-status';
  static var wallet_url = ConstanceData.url + 'get_wallet_data/';
  static var cashfree_url = ConstanceData.url + 'cashfree-generate-token';
  static var payout_url = ConstanceData.url + 'cashfree-withdrawal';
  static var soccer_comp_url = 'https://soccer.entitysport.com/competitions';

//====================================================================
  Future<dynamic> mobile_email_Register(login_data data) async {
    NetworkHelper helper = NetworkHelper(otp_login);
    var dataR = await helper.mobile_email_Register(data);
    return dataR;
  }

  Future<dynamic> mobile_email_Register1(login_data data) async {
    NetworkHelper helper = NetworkHelper(otp_send_verify_url);
    var dataR = await helper.mobile_email_Register(data);
    return dataR;
  }

  Future<dynamic> verify_OTP(
      String number, String email, bool mobileOTP, String otp) async {
    NetworkHelper helper = NetworkHelper(otp_verify_url);
    var dataR = await helper.verifyOTP(number, email, mobileOTP, otp);
    return dataR;
  }

  Future<dynamic> login(SignUpData data) async {
    NetworkHelper helper = NetworkHelper(login_url);
    var dataR = await helper.login(data);
    ConstanceData.setId(dataR['data']['id']);
    ConstanceData.setToken(dataR['access_token']);
    return dataR;
  }

  Future<dynamic> profile(SaveProfileData data) async {
    NetworkHelper helper = NetworkHelper(profile_url);
    var dataR = await helper.profile(data);

    return dataR;
  }

  Future<dynamic> kyc_get() async {
    NetworkHelper helper =
        NetworkHelper(kyc_get_url + ConstanceData.id.toString());
    var dataR = await helper.getKyc();

    return dataR;
  }

  Future<dynamic> getCompletions(match_id) async {
    NetworkHelper helper = NetworkHelper(all_contest_url);
    var dataR = await helper.getCompletions(match_id);

    return dataR;
  }

  Future<dynamic> signup(SignUpData data) async {
    NetworkHelper helper = NetworkHelper(url);

    var a = helper.signup(data);
    return a;
  }

  Future<dynamic> signUpWithFacebook(
      String email, String name, String s, String token) async {
    NetworkHelper helper = NetworkHelper(google_url);

    var a = helper.signUpWithFacebook(email, name, s, token);
    return a;
  }

  Future<dynamic> sendKyc(kyc data) async {
    NetworkHelper helper = NetworkHelper(kyc_url);

    var a = await helper.verifyKyc(data);

    Fluttertoast.showToast(
        msg: "$a",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    return a;
  }

  Future<dynamic> verifyOTP(String number, String otp) async {
    NetworkHelper helper = NetworkHelper(otp_verify_url);

    var a = await helper.otpVerify(number, otp);

    return a;
  }

  Future<dynamic> getNotification() async {
    NetworkHelper helper = NetworkHelper(notification_url);
    var a = await helper.getNotification();
    return a;
  }

  Future<TransactionHistoryResp> TransactionHistory(
      String uid, type, int status, int page) async {
    NetworkHelper helper = NetworkHelper(transaction_url);
    var a = await helper.TransactionHistory(uid, type, status, page);
    return a;
  }

  //=====================================================================
  Future<dynamic> fetchCompetition(constance.CompetitionType type) async {
    NetworkHelper helper = NetworkHelper(competition_url);
    List<competition> data = await helper.fetchCompetition(type);
    return data;
  }

  Future<dynamic> fetchMatches(String status) async {
    NetworkHelper helper = NetworkHelper(competition_match_url);
    List<match> data = await helper.fetchMatches(status);
    return data;
  }

  Future<dynamic> fetchUpcomingMatches(int num) async {
    NetworkHelper helper = NetworkHelper(upcoming_match_url);
    List<match> data = await helper.fetchUpcomingMatches(num);
    return data;
  }

  Future<dynamic> fetchJoinedMatches(user_id) async {
    NetworkHelper helper = NetworkHelper(joined_match_url);
    List<match> data = await helper.fetchJoinedMatches(user_id);
    return data;
  }

  Future<dynamic> fetchFantasyRoster(
      String cid, String mid, String a, String b) async {
    NetworkHelper helper =
        NetworkHelper(fantasy_match_url + cid.toString() + '/squads/' + mid);

    var data = await helper.fetchFantasyRoster(a, b);

    return data;
  }

  Future<dynamic> fetchFantasyPoint(String mid) async {
    NetworkHelper helper =
        NetworkHelper(fantasy_point_url + mid + '/newpoint2');

    var data = await helper.fetchFantasyPoints();

    return data;
  }

  Future<dynamic> saveTeam(CreateTeam data) async {
    NetworkHelper helper = NetworkHelper(create_team_url);
    var response = await helper.saveTeam(data);
    return response;
  }

  Future<dynamic> updateTeam(String team_a, team_b, uid, id) async {
    NetworkHelper helper = NetworkHelper(update_team_url);
    var response = await helper.updateTeam(team_a, team_b, uid, id);
    return response;
  }

  Future<dynamic> payout(user_id, amount) async {
    NetworkHelper helper = NetworkHelper(payout_url);
    var response = await helper.payout(user_id, amount);
    return response;
  }

  Future<dynamic> getTeam() async {
    NetworkHelper helper = NetworkHelper(get_team_url);
    var response = await helper.getTeam(ConstanceData.prof.id.toString());
    return response;
  }

  Future<dynamic> getTeamWithID(id) async {
    NetworkHelper helper = NetworkHelper(get_team_url);
    var response = await helper.getTeam(id);
    return response;
  }

  Future<dynamic> order_id(int totalAmount) async {
    NetworkHelper helper = NetworkHelper(orderId_url);
    var response = await helper.orderId(totalAmount.toString());
    return response;
  }

  Future<dynamic> updatePayment(int id, String signature, String paymentId,
      String orderId, int totalAmount) async {
    NetworkHelper helper = NetworkHelper(order_complete_url);
    var response = await helper.orderComplete(
        id, signature, paymentId, orderId, totalAmount);
    return response;
  }

  Future<dynamic> enterCompetition(String id, int contest_id) async {
    NetworkHelper helper = NetworkHelper(entry_url);
    var response = await helper.enter_competition(id, contest_id);
    return response;
  }

  Future<dynamic> credit(String id) async {
    NetworkHelper helper = NetworkHelper(credit_url);
    var response = await helper.credit(id);
    return response;
  }

  Future<dynamic> fetchMatchSquad(String match_id, team_A, team_B) async {
    NetworkHelper helper =
        NetworkHelper(fantasy_point_url + match_id + '/squads');
    var response = await helper.fetchMatchSquad(team_A, team_B);
    return response;
  }

  Future<dynamic> fetchInnings(String match_id) async {
    NetworkHelper helper =
        NetworkHelper(fantasy_point_url + match_id + '/scorecard');
    var response = await helper.fetchInnings();
    return response;
  }

  Future<dynamic> fetchCommentry(String match_id, String innings) async {
    NetworkHelper helper = NetworkHelper(
        fantasy_point_url + match_id + '/innings/' + innings + '/commentary');
    var response = await helper.fetchCommentry();
    return response;
  }

  Future<dynamic> winners(String id, no) async {
    NetworkHelper helper = NetworkHelper(winners_url);
    var response = await helper.winners(id, no);
    return response;
  }

  Future<dynamic> check_contest(String prize, total_sports) async {
    NetworkHelper helper = NetworkHelper(check_contest_url);
    var response = await helper.check_contest(prize, total_sports);
    return response;
  }

  Future<dynamic> check_contest_admin(String contest_id) async {
    NetworkHelper helper = NetworkHelper(check_contest_admin_url);
    var response = await helper.check_contest_admin(contest_id);
    return response;
  }

  Future<dynamic> create_contest(String category_id, prize, entry, total_sports,
      user_id, name, winner) async {
    NetworkHelper helper = NetworkHelper(create_contest_url);
    var response = await helper.create_contest(
        category_id, prize, entry, total_sports, user_id, name, winner);
    return response;
  }

  Future<GenericResponse> join_contest(String contest_id, user_id, match_id,
      compition_id, team_id, coupon) async {
    NetworkHelper helper = NetworkHelper(join_contest_url);
    GenericResponse response = await helper.join_contest(
        contest_id, user_id, match_id, compition_id, team_id, coupon);
    return response;
  }

  Future<GenericResponse> join_multiple_contest(String contest_id, user_id,
      match_id, compition_id, team_id, coupon, List<int> ids) async {
    NetworkHelper helper = NetworkHelper(join_contest_url);
    GenericResponse response = await helper.join_contest_multiple(
        contest_id, user_id, match_id, compition_id, team_id, coupon, ids);
    return response;
  }

  Future<dynamic> join_contest_by_code(
      String contest_code, user_id, team_id) async {
    NetworkHelper helper = NetworkHelper(join_contest_by_code_url);
    var response =
        await helper.join_contest_by_code(contest_code, user_id, team_id);
    return response;
  }

  Future<dynamic> user_contest_list(String userId) async {
    NetworkHelper helper = NetworkHelper(user_contest_list_url);
    var response = await helper.user_contest(userId);
    return response;
  }

  Future<dynamic> user_contest_by_list(String userId, match_id) async {
    NetworkHelper helper = NetworkHelper(user_contest_by_list_url);
    var response = await helper.user_contest_by_list(userId, match_id);
    return response;
  }

  Future<dynamic> level(String userId) async {
    NetworkHelper helper = NetworkHelper(level_url);
    var response = await helper.level(userId);
    return response;
  }

  Future<dynamic> leader_board() async {
    NetworkHelper helper = NetworkHelper(leader_board_url);
    var response = await helper.leader_board_fetcher();
    return response;
  }

  Future<dynamic> user_play_history(userId) async {
    NetworkHelper helper = NetworkHelper(user_play_history_url);
    var response = await helper.user_play_history_fetch(userId);
    return response;
  }

  Future<dynamic> email_phone_update(email, phone, userId) async {
    NetworkHelper helper = NetworkHelper(email_phone_update_url);
    var response = await helper.email_phone_update(email, phone, userId);
    return response;
  }

  Future<dynamic> recently_played(user_id) async {
    NetworkHelper helper = NetworkHelper(recently_url);
    var response = await helper.recently_played_fetcher(user_id);
    return response;
  }

  Future<dynamic> get_selby(match_id) async {
    NetworkHelper helper = NetworkHelper(get_selby_url);
    var response = await helper.selby_fetcher(match_id);
    return response;
  }

  Future<dynamic> get_competed_match(user_id, page) async {
    NetworkHelper helper = NetworkHelper(competed_match_url);
    var response = await helper.competed_match(user_id, page);
    return response;
  }

  Future<dynamic> get_live_match(user_id) async {
    NetworkHelper helper = NetworkHelper(live_match_url);
    var response = await helper.get_live_match(user_id);
    return response;
  }

  Future<dynamic> get_upcoming_match_user(user_id) async {
    NetworkHelper helper = NetworkHelper(upcoming_match_user_url);
    var response = await helper.upcoming_match_user(user_id);
    return response;
  }

  Future<dynamic> get_leaderboard_contest(user_id, match_id, contest_id) async {
    NetworkHelper helper = NetworkHelper(leaderboard_contest_url);
    var response =
        await helper.get_leaderboard_contest(user_id, match_id, contest_id);
    return response;
  }

  Future<dynamic> getleaderboard_outside(
      user_id, match_id, cid, contest_id) async {
    NetworkHelper helper = NetworkHelper(getleaderboard_url);
    var response =
        await helper.getleaderboard_outside(user_id, match_id, cid, contest_id);
    return response;
  }

  Future<dynamic> team_details_by_match(user_id, match_id) async {
    NetworkHelper helper = NetworkHelper(team_details_by_match_url);
    var response = await helper.get_team_details_by_match(user_id, match_id);
    return response;
  }

  Future<dynamic> sendBank(bank data) async {
    NetworkHelper helper = NetworkHelper(create_bank_detail_url);

    var a = await helper.sendBankDetails(data);

    Fluttertoast.showToast(
        msg: "$a",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    return a;
  }

  Future<dynamic> sendPan(pan data) async {
    NetworkHelper helper = NetworkHelper(create_pan_detail_url);

    var a = await helper.sendPanDetails(data);

    Fluttertoast.showToast(
        msg: "$a",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    return a;
  }

  Future<dynamic> send_user_image(dynamic data) async {
    NetworkHelper helper = NetworkHelper(user_image_url);

    var a = await helper.sendUserImage(data);

    Fluttertoast.showToast(
        msg: "$a",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    return a;
  }

  Future<dynamic> create_query(String uquery, name, email, mobile_no) async {
    NetworkHelper helper = NetworkHelper(create_query_url);

    var a = await helper.create_query(uquery, name, email, mobile_no);

    Fluttertoast.showToast(
        msg: "$a",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    return a;
  }

  Future<DownloadResponse> check_app_version(String app_version) async {
    NetworkHelper helper = NetworkHelper(check_app_url);

    DownloadResponse a = await helper.check_app_version(app_version);
    print('it ${a}');
    return a;
  }

  Future<dynamic> get_winner_list() async {
    NetworkHelper helper = NetworkHelper(winner_list_url);

    var a = await helper.winner_list();
    return a;
  }

  Future<dynamic> get_series_list(String id) async {
    NetworkHelper helper = NetworkHelper(series_list_url);

    var a = await helper.get_series_list(id);
    return a;
  }

  Future<dynamic> fantasy_point_brekdown() async {
    NetworkHelper helper = NetworkHelper(fantasy_point_brekdown_url);

    var a = await helper.fantasy_point_brekdown();
    return a;
  }

  Future<dynamic> leader_board_list_week(
      String id, week, compId, start, end) async {
    NetworkHelper helper = NetworkHelper(leader_board_list_week_url);

    var a = await helper.leader_board_list_week(id, week, compId, start, end);
    return a;
  }

  Future<dynamic> leader_board_list_series(String user_id, compition_id) async {
    NetworkHelper helper = NetworkHelper(leader_board_list_series_url);

    var a = await helper.leader_board_list(user_id, compition_id);
    return a;
  }

  Future<dynamic> get_coupon() async {
    NetworkHelper helper = NetworkHelper(get_coupon_url);

    var a = await helper.get_coupon();
    return a;
  }

  Future<dynamic> get_feed_details() async {
    NetworkHelper helper = NetworkHelper(feed_details_url);

    var a = await helper.get_feed_details();
    return a;
  }

  Future<dynamic> get_week_info(String user_id, compition_id) async {
    NetworkHelper helper = NetworkHelper(get_week_info_url);

    var a = await helper.get_week_info(user_id, compition_id);
    return a;
  }

  Future<dynamic> apply_coupon(String title, amount, user_id) async {
    NetworkHelper helper = NetworkHelper(apply_coupon_url);

    var a = await helper.apply_coupon(title, amount, user_id);
    return a;
  }

  Future<dynamic> send_otp(String email, phone) async {
    NetworkHelper helper = NetworkHelper(send_otp_url);

    var a = await helper.send_otp(email, phone);
    return a;
  }

  Future<dynamic> verify_otp(String email, phone, otp) async {
    NetworkHelper helper = NetworkHelper(verify_otp_url);

    var a = await helper.verify_otp(email, phone, otp);
    return a;
  }

  Future<dynamic> player_points(String compition_id) async {
    NetworkHelper helper = NetworkHelper(player_points_url);

    var a = await helper.player_points(compition_id);
    return a;
  }

  Future<dynamic> transaction_history_req(String user_id, type) async {
    NetworkHelper helper = NetworkHelper(transaction_history_req_url);

    var a = await helper.transaction_history_req(user_id, type);
    return a;
  }

  Future<dynamic> paytm_do_payment(String user_id, order_id, amount) async {
    NetworkHelper helper = NetworkHelper(paytm_do_payment_url);

    var a = await helper.paytm_do_payment(user_id, order_id, amount);
    print(a);
    return a;
  }

  Future<dynamic> banner_list() async {
    NetworkHelper helper = NetworkHelper(banner_list_url);

    var a = await helper.banner_list();
    return a;
  }

  Future<dynamic> email_verify(email, otp) async {
    NetworkHelper helper = NetworkHelper(email_verify_url);

    var a = await helper.email_verify(email, otp);
    return a;
  }

  Future<dynamic> transactionStatus(orderId) async {
    NetworkHelper helper = NetworkHelper(transactionStatus_url);

    var a = await helper.transactionStatus(orderId);
    return a;
  }

  Future<CashfreeResponse> cashfreeTransaction(
      user_id, amount, customerPhone, customerName, customerEmail) async {
    NetworkHelper helper = NetworkHelper(cashfree_url);

    var a = await helper.cashfreeTransaction(
        user_id, amount, customerPhone, customerName, customerEmail);
    return a;
  }

  Future<WalletData> getWallet() async {
    NetworkHelper helper =
        NetworkHelper(wallet_url + ConstanceData.prof.id.toString());

    WalletData a = await helper.getWallet();
    return a;
  }

  Future<MatchPointResponse> getMatchPlayerPoint(team_id) async {
    NetworkHelper helper = NetworkHelper(match_points_url);

    MatchPointResponse a = await helper.getMatchPlayerPoint(team_id);
    return a;
  }

  Future<SoccerCompResponse> getSoccerCompetitions() async {
    NetworkHelper helper = NetworkHelper(soccer_comp_url);

    SoccerCompResponse a = await helper.getSoccerCompetitions();
    return a;
  }

  Future<SoccerMatchResponse> getSoccerMatch(cid) async {
    NetworkHelper helper = NetworkHelper(
        'https://soccer.entitysport.com/competition' + '/${cid}' + '/matches');

    SoccerMatchResponse a = await helper.getSoccerMatch();
    return a;
  }

  Future<SoccerPlayerResponse> getSoccerPlayers(mid) async {
    NetworkHelper helper = NetworkHelper(
        'https://soccer.entitysport.com/matches' +
            '/${mid}' +
            '/fantasy');

    SoccerPlayerResponse a = await helper.getSoccerPlayers();
    return a;
  }
}
