import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fantacySports/Model/Anounced.dart';
import 'package:fantacySports/Model/BANK.dart';
import 'package:fantacySports/Model/Banner.dart';
import 'package:fantacySports/Model/CashfreeToken.dart';
import 'package:fantacySports/Model/Commentaries/commentary.dart';
import 'package:fantacySports/Model/CreateTeam.dart';
import 'package:fantacySports/Model/GetTeam.dart';
import 'package:fantacySports/Model/LeaderBoardItem.dart';
import 'package:fantacySports/Model/PAN.dart';
import 'package:fantacySports/Model/Prize.dart';
import 'package:fantacySports/Model/Scorecard/Innings.dart';
import 'package:fantacySports/Model/Total_Level.dart';
import 'package:fantacySports/Model/Transaction.dart';
import 'package:fantacySports/Model/cashfree_response.dart';
import 'package:fantacySports/Model/contest.dart';
import 'package:fantacySports/Model/notification.dart';
import 'package:fantacySports/Model/player_points.dart';
import 'package:fantacySports/Model/user_play_history.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import 'package:fantacySports/Model/Competition.dart';
import 'package:fantacySports/Model/LoginData.dart';
import 'package:fantacySports/Model/Matche.dart';
import 'package:fantacySports/Model/Players.dart';
import 'package:fantacySports/Model/SaveProfileData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mime/mime.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:fantacySports/Model/KYC_Data.dart';
import 'package:fantacySports/Model/SignUpData.dart';
import 'package:http_parser/http_parser.dart';

import '../Model/Cupon.dart';
import '../Model/Date_transaction.dart';
import '../Model/Feed.dart';
import '../Model/GetTeam_2.dart';
import '../Model/Leaderboard_contest.dart';
import '../Model/Paytm_Token.dart';
import '../Model/Prize.dart';
import '../Model/Recently_Played.dart';
import '../Model/Selby_Player.dart';
import '../Model/SeriesLeaderboardItem.dart';
import '../Model/Soccer/soccer_comp_response.dart';
import '../Model/Soccer/soccer_match_response.dart';
import '../Model/Soccer/soccer_player.dart';
import '../Model/UpcomingMatchModel.dart';
import '../Model/Winner.dart';
import '../Model/WinnersListItem.dart';
import '../Model/contest_joined.dart';
import '../Model/download_response.dart';
import '../Model/fantasy_point_action.dart';
import '../Model/generic_response.dart';
import '../Model/leaderboard_outside.dart';
import '../Model/match_new.dart';
import '../Model/match_point_response.dart';
import '../Model/player_point.dart';
import '../Model/seriesItem.dart';
import '../Model/transaction_history.dart';
import '../Model/wallet_response.dart';
import '../Model/week.dart';
import '../Model/weeklyLeaderboardItem.dart';
import '../Testing/Winners.dart';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Dio dio;

  BaseOptions option =
      BaseOptions(connectTimeout: 25000, receiveTimeout: 25000, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'APP-KEY': ConstanceData.app_key,
    'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
  });

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Future login(SignUpData data) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
    });
    dio = Dio(option);

    try {
      Response response = await dio.post(url,
          data: data.mobileOTP
              ? {
                  'phone': data.phone.toString(),
                  'password': '123456',
                }
              : {
                  'email': data.email,
                  'password': '123456',
                });
      if (response.statusCode == 200) {
        print('2 ${response.data}');
        return response.data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print('2 ${data.mobileOTP ? {
          'phone': data.phone.toString(),
          'password': '123456',
        } : {
          'email': data.email,
          'password': '123456',
        }}');
      print('${e.message}');
    }
  }

  Future signup(SignUpData data) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key
    });
    print(url);
    dio = Dio(option);
    try {
      Response response = await dio.post(url, data: {
        'name': data.name,
        'phone': data.phone,
        'email': data.email,

        // 'password': data.password,
        'login_by': data.login_by,
        // 'id': data.id,
      });
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print('1 42 ${{
        'name': data.name,
        'phone': data.phone,
        'email': data.email,
        // 'password': data.password,
        'login_by': data.login_by,
        // 'id': data.id,
      }} ${e}');
    }
  }

  Future mobile_email_Register(login_data data) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    print(url);
    print({
      // 'name': data.name,
      'phone': data.mobile.toString(),
      'email': data.email,
      'vcode': data.vcode.toString(),
      // 'login_by': data.login_by,
    });
    dio = Dio(option);
    try {
      Response response = await dio.post(url,
          data: data.mobileOTP
              ? {
                  // 'name': data.name,
                  'phone': data.mobile.toString(),
                  'vcode': data.vcode.toString(),
                  // 'login_by': data.login_by,
                }
              : {
                  'email': data.email,
                });
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print('${e.message} ${e.error} ${e.response}');
    }
  }

  Future verifyOTP(
      String number, String email, bool mobileOTP, String otp) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.post(url,
          data: mobileOTP
              ? {
                  'phone': number,
                  'otp_value': otp,
                }
              : {
                  'email': email,
                  'otp_value': otp,
                });
      if (response.statusCode == 200) {
        if (response.data['message'] != "Your OTP is Incorrect!") {
          print(response.data['message']);
          return response.data;
        } else {
          print(response.data['message']);
          return response.data;
        }
      } else {
        print('${response.data}');
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

  Future getNotification() async {
    dio = Dio(option);
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;

        List<Notifications> list =
            data.map((e) => Notifications.fromJson(e)).toList();

        return list;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e);
    }
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future profile(SaveProfileData data) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    try {
      Response response = await dio.post(url, data: {
        'name': data.name,
        'id': data.id.toString(),
        'address': data.address,
        'city': data.city,
        'pincode': data.pincode.toString(),
        'gender': data.gender,
        'state': data.state,
        'dob': data.dob,
        // 'login_by': data.login_by,
      });
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<dynamic> getCompletions(match_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);

    var data = {'match_id': match_id};
    print(data);
    try {
      Response response = await dio.get(
        url,
        queryParameters: data,
      );
      print('contest response ${response.data}');
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;

        List<Contest> list = data.map((e) => Contest.fromJson(e)).toList();

        return list;
      } else {
        List<Contest> list = new List<Contest>();
        return list;
      }
    } on DioError catch (e) {
      print(e);
      List<Contest> list = new List<Contest>();
      return list;
    }
  }

  Future<TransactionHistoryResp> TransactionHistory(
      String uid, type, int status, int page) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'uid': uid,
      'type': type, //deposit/withdrawal/contest/other
      'status': status, //0=inprogress, 1=success, 2=fail
      'page': page,
    });
    try {
      Response response = await dio.post(url, data: {
        'uid': uid,
        'type': type, //deposit/withdrawal/contest/other
        'status': status, //0=inprogress, 1=success, 2=fail
        'page': page,
      });
      if (response.statusCode == 200) {
        print('transaction history  ${response.data}');
        return TransactionHistoryResp.fromJson(response.data);
      } else {
        print('transaction history  ${response.data}');
        return TransactionHistoryResp.withError("Something went wrong");
      }
    } on DioError catch (e) {
      print(e);
      print('transaction history  ${e.response}');
      return TransactionHistoryResp.withError("Something went wrong");
    }
  }

  Future<dynamic> enter_competition(String uid, int content_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    try {
      Response response = await dio.post(url, data: {
        'uid': uid,
        'content_id': content_id,
      });
      if (response.statusCode == 200) {
        var data = response.data['message'];
        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<dynamic> credit(String uid) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    try {
      Response response = await dio.post(url, data: {
        'uid': uid,
      });
      if (response.statusCode == 200) {
        var data = response.data['message'];
        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e);
    }
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future signUpWithFacebook(
      String email, String name, String s, String token) async {
    dio = Dio(option);

    try {
      Response response = await dio.post(url, data: {
        'email': email,
        'login_by': s,
        'google_id': token,
        'name': name,
      });
      if (response.statusCode == 200) {
        print('${{
          'email': email,
          'login_by': s,
          'google_id': token,
          'name': name,
        }}   ${response.data}');
        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Email id is not registered with us",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      print('signup ${e.message}');
    }
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future otpVerify(String number, String otp) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);

    try {
      Response response = await dio.post(url, data: {
        'phone': number,
        'otp_value': otp,
      });
      if (response.statusCode == 200) {
        print("${response.data['message']}");
        return response.data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future otpsend(String number) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);

    try {
      Response response = await dio.post(url, data: {
        'phone': number,
      });
      if (response.statusCode == 200) {
        print(response.data['message']);
        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future getKyc() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print(ConstanceData.access_token.toString());
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        print('kyc resp ${response.data}');
        return response.data;
      } else {
        print('kyc resp ${response.data}');
        return 'Failed';
      }
    } on DioError catch (e) {
      print('kyc resp ${e.message} ${e.response}');
      print(e.message);
    }
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future verifyKyc(kyc kycdata) async {
    print('id${await ConstanceData.id}');
    final mimedatatype =
        lookupMimeType(kycdata.pan, headerBytes: [0xFF, 0xD8]).split('/');
    print(mimedatatype);
    final pan = await http.MultipartFile.fromPath('pan_card[]', kycdata.bank,
        filename: 'pan_card',
        contentType: new MediaType(mimedatatype[0], mimedatatype[1]));
    print("${pan.contentType}${pan.filename} ");

    final bank = await http.MultipartFile.fromPath(
        'bank_details[]', kycdata.bank,
        filename: 'bank_details',
        contentType: new MediaType(mimedatatype[0], mimedatatype[1]));
    print("${bank.contentType}${bank.filename} ");
    final imageUpload = http.MultipartRequest('POST', Uri.parse(url));

    imageUpload.files.add(pan);
    imageUpload.files.add(bank);
    imageUpload.fields['team_name'] = 'Mine';
    imageUpload.fields['id'] = await ConstanceData.id.toString();
    imageUpload.headers['APP-KEY'] = ConstanceData.app_key;
    imageUpload.headers['Authorization'] =
        'Bearer ${ConstanceData.access_token.toString()}';
    imageUpload.headers['Content-Type'] = "multipart/form-data";
    try {
      final streamResp = await imageUpload.send();
      print(streamResp.stream);
      final response = await http.Response.fromStream(streamResp);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("${responseData}");
        return responseData['message'];
      } else {
        print("${response.statusCode} ${response}");
      }
    } catch (e) {
      print(e);
    }
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Future saveTeam(CreateTeam data) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 35000, receiveTimeout: 35000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print(
        '${data.uid}\n${data.competition_id}\n${data.match_id}\n${data.team_A}\n${data.team_B}');
    print({
      'uid': data.uid,
      'competition_id': data.competition_id,
      'match_id': data.match_id,
      'team_a': data.team_A,
      'team_b': data.team_B,
    });
    try {
      Response response = await dio.post(url, data: {
        'uid': data.uid,
        'competition_id': data.competition_id,
        'match_id': data.match_id,
        'team_a': data.team_A,
        'team_b': data.team_B,
      });
      if (response.statusCode == 200) {
        print(response.data['message']);
        return response.data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.response);
      print(e.error);
    }
  }

  Future getTeam(String uid) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print(uid);

    try {
      Response response = await dio.post(url, data: {
        'uid': uid,
      });
      if (response.statusCode == 200) {
        var data = response.data['team'] as List;
        List<GetTeam> list = data.map((e) => GetTeam.fromJson(e)).toList();
        print(response.data);
        return list;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response);
    }
  }

  Future orderId(String amount) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);

    try {
      Response response = await dio.post(url, data: {
        'amount': amount,
      });
      if (response.statusCode == 200) {
        var data = response.data;
        print(response.data);
        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future orderComplete(int id, String signature, String paymentId,
      String orderId, int totalAmount) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print('${url} \n ${{
      'uid': id.toString(),
      'rzp_paymentid': paymentId,
      'rzp_orderid': orderId,
      'rzp_signature': signature,
      'amount': totalAmount.toString(),
    }}');
    try {
      Response response = await dio.post(url, data: {
        'uid': id.toString(),
        'rzp_paymentid': paymentId,
        'rzp_orderid': orderId,
        'rzp_signature': signature,
        'amount': totalAmount.toString(),
      });
      if (response.statusCode == 200) {
        var data = response.data;
        print(response.data);
        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print('AD ${e}');
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  //============================================================================
  Future fetchCompetition(constance.CompetitionType type) async {
    dio = Dio(option);

    try {
      Response response = await dio.get(url,
          queryParameters: type == constance.CompetitionType.def
              ? {
                  'token': ConstanceData.token,
                  'per_page': '80',
                  'paged': '1',
                }
              : {
                  'token': ConstanceData.token,
                  'status': getType(type),
                  'per_page': '80',
                  'paged': '1',
                });
      if (response.statusCode == 200) {
        var data = response.data['response']['items'] as List;

        List<competition> list =
            data.map((e) => competition.fromJson(e)).toList();

        return list;
      } else {
        List<competition> list = new List<competition>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<competition> list = new List<competition>();
      return list;
    }
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future fetchMatches(String status) async {
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(url, queryParameters: {
        'token': ConstanceData.token,
        'per_page': '80',
        'paged': '1',
        'status': status,
      });
      if (response.statusCode == 200) {
        var data = response.data['response']['items'] as List;
        print('result ${response.data['response']}');
        List<match> list = data.map((e) => match.fromJson(e)).toList();

        return list;
      } else {
        List<match> list = new List<match>();
        return list;
      }
    } on DioError catch (e) {
      print(e);
      List<match> list = new List<match>();
      return list;
    }
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Future fetchFantasyRoster(String a, String b) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    Dio dio = Dio(option);
    print(url);
    print({
      'token': ConstanceData.token,
    });
    Response response;
    try {
      response = await dio.get(url, queryParameters: {
        'token': ConstanceData.token,
      });
      print('RASWFSF ${response.data}');
      if (response.statusCode == 200 &&
          response.data['response'].toString() !=
              "Invalid Competition/Match id") {
        var data = response.data['response']['squads'][0]['players'] as List;
        var data1 = response.data['response']['squads'][1]['players'] as List;

        List<players> list1 = data.map((e) => players.fromJson(e)).toList();
        List<players> list2 = data1.map((e) => players.fromJson(e)).toList();
        print(
            'a ${a} b ${b} ${response.data['response']['squads'][0]['team_id'].toString() == a} ${response.data['response']['squads'][0]['team_id'].toString() == b}');
        return {
          'a': response.data['response']['squads'][0]['team_id'].toString() == a
              ? list1
              : list2,
          'b': response.data['response']['squads'][0]['team_id'].toString() == a
              ? list2
              : list1,
        };
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print('Rooster ${e.response}');
      return 'Failed';
    }
  }

  Future fetchFantasyPoints() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    Dio dio = Dio(option);
    print(url);
    print({
      'token': ConstanceData.token,
    });
    try {
      Response response = await dio.get(url, queryParameters: {
        'token': ConstanceData.token,
      });
      if (response.statusCode == 200 &&
          response.data['response'].toString() !=
              "Invalid Competition/Match id") {
        var data =
            response.data['response']['points']['teama']['playing11'] as List;
        var data1 =
            response.data['response']['points']['teamb']['playing11'] as List;

        List<Player_Points> list1 =
            data.map((e) => Player_Points.fromJson(e)).toList();
        List<Player_Points> list2 =
            data1.map((e) => Player_Points.fromJson(e)).toList();
        return {
          'a': list1,
          'b': list2,
        };
      } else {
        print('ga');
        return 'Failed';
      }
    } on DioError catch (e) {
      print('points ${e.message}');
      return 'Failed';
    }
  }

  Future fetchMatchSquad(team_A, team_B) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    Dio dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(url, queryParameters: {
        'token': ConstanceData.token,
      });
      if (response.statusCode == 200) {
        var data = response.data['response']['teama']['squads'] as List;
        var data1 = response.data['response']['teamb']['squads'] as List;

        List<Anounced> list1 = data.map((e) => Anounced.fromJson(e)).toList();
        List<Anounced> list2 = data1.map((e) => Anounced.fromJson(e)).toList();
        return {
          'a': response.data['response']['teama']["team_id"] == team_A
              ? list1
              : list2,
          'b': response.data['response']['teama']["team_id"] == team_A
              ? list2
              : list1,
        };
      } else {
        print('ga');
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

  Future fetchInnings() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    Dio dio = Dio(option);
    try {
      Response response = await dio.get(url, queryParameters: {
        'token': ConstanceData.token,
      });
      if (response.statusCode == 200) {
        var data = response.data['response']['innings'] as List;
        print(response.data['response']);
        List<innings> list1 = data.map((e) => innings.fromJson(e)).toList();
        return list1;
      } else {
        List<innings> list1 = new List<innings>();
        return list1;
      }
    } on DioError catch (e) {
      print(e.message);
      List<innings> list1 = new List<innings>();
      return list1;
    }
  }

  Future fetchCommentry() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    Dio dio = Dio(option);
    try {
      Response response = await dio.get(url, queryParameters: {
        'token': ConstanceData.token,
      });
      if (response.statusCode == 200) {
        var data = response.data['response']['commentaries'] as List;

        List<commentaries> list1 =
            data.map((e) => commentaries.fromJson(e)).toList(growable: false);
        return list1;
      } else {
        List<commentaries> list1 = new List<commentaries>();
        return list1;
      }
    } on DioError catch (e) {
      print(e.message);
      List<commentaries> list1 = new List<commentaries>();
      return list1;
    }
  }

  getType(constance.CompetitionType type) {
    if (type == constance.CompetitionType.live) return 'live';
    if (type == constance.CompetitionType.upcoming) return 'fixture';
    if (type == constance.CompetitionType.completed) return 'result';
  }

  Future updateTeam(String team_a, team_b, uid, id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'uid': uid,
      'id': id,
      'team_a': team_a,
      'team_b': team_b,
    });
    try {
      Response response = await dio.post(url, data: {
        'uid': uid,
        'id': id,
        'team_a': team_a,
        'team_b': team_b,
      });
      if (response.statusCode == 200) {
        print('result ${response.data}');
        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future payout(String user_id, amount) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'user_id': user_id,
      'amount': amount,
    });
    try {
      Response response = await dio.post(url, data: {
        'user_id': user_id,
        'amount': amount,
      });
      if (response.statusCode == 200) {
        print('result ${response.data}');
        return response.data['message'];
      } else {
        return 'Something Went Wrong';
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future winners(String id, no) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);

    try {
      Response response = await dio.post(url, data: {
        'id': id,
        'numbers': no,
      });
      if (response.statusCode == 200) {
        var data = response.data as List;
        List<winner> list =
            data.map((e) => winner.fromJson(e)).toList(growable: false);
        return list;
      } else {
        List<winner> list = new List<winner>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<winner> list = new List<winner>();
      return list;
    }
  }

  Future check_contest(String prizeMoney, total_sports) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'prize': prizeMoney,
      'total_sports': total_sports,
    });
    try {
      Response response = await dio.post(url, data: {
        'prize': prizeMoney,
        'total_sports': total_sports,
      });
      if (response.statusCode == 200) {
        print('${response.data['data']}');
        var data = response.data['data'] as List;
        print('as ${prizeMoney} ${total_sports} ${response.data['data']}');
        List<prize> list =
            data.map((e) => prize.fromJson(e)).toList(growable: false);
        return list;
      } else {
        List<prize> list = new List<prize>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<prize> list = new List<prize>();
      return list;
    }
  }

  Future check_contest_admin(String contest_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'contest_id': contest_id,
    });
    try {
      Response response = await dio.post(url, data: {
        'contest_id': contest_id,
      });
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        List<prize> list =
            data.map((e) => prize.fromJson(e)).toList(growable: false);
        return list;
      } else {
        List<prize> list = new List<prize>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<prize> list = new List<prize>();
      return list;
    }
  }

  Future create_contest(String category_id, prize, entry, total_sports, user_id,
      name, winner) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'category_id': category_id,
      'prize': prize,
      'entry': entry,
      'total_sports': total_sports,
      'user_id': user_id,
      'contest_name': name,
      'number_of_winners': winner,
    });
    try {
      Response response = await dio.post(url, data: {
        'category_id': category_id,
        'prize': prize,
        'entry': entry,
        'total_sports': total_sports,
        'user_id': user_id,
        'contest_name': name,
        'number_of_winners': winner,
      });
      print('Create Contes Response ${response.data}');
      if (response.statusCode == 200) {
        var data = response.data;

        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print('Error ${e.response}');
    }
  }

  Future<GenericResponse> join_contest(String contest_id, user_id, match_id,
      compition_id, team_id, coupon) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print(' ${{
      'contest_id': contest_id,
      'user_id': user_id,
      'match_id': match_id,
      'compition_id': compition_id,
      'user_id': user_id,
      'team_id': team_id,
      'coupon': coupon,
    }}');
    Response response;
    try {
      response = await dio.post(url, data: {
        'contest_id': contest_id,
        'user_id': user_id,
        'match_id': match_id,
        'compition_id': compition_id,
        'user_id': user_id,
        'team_id': team_id,
        'coupon': coupon,
      });
      if (response.statusCode == 200) {
        print('contest jopind: ${response.data}');
        var data = response.data;

        return GenericResponse.fromJson(response.data);
      } else {
        return GenericResponse.withError('Something went wrong');
      }
    } on DioError catch (e) {
      print(e.response);
      print(e);
      return GenericResponse.withError(e.message);
    }
  }

  Future<GenericResponse> join_contest_multiple(String contest_id, user_id,
      match_id, compition_id, team_id, coupon, List<int> ids) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    getTeams() {
      var list = '';
      for (int i = 0; i < ids.length; i++) {
        if (i == 0) {
          list = ids[i].toString() + ',';
        } else {
          if (ids[i] != 0) {
            list = list + ids[i].toString() + ',';
          }
        }
      }
      return list.substring(list.length - 1) == ','
          ? list.substring(0, list.length - 1)
          : list;
    }

    var data = {
      'contest_id': contest_id,
      'user_id': user_id,
      'match_id': match_id,
      'compition_id': compition_id,
      'user_id': user_id,
      'coupon': coupon,
      'team_id': getTeams()
    };
    dio = Dio(option);
    print(url);

    print(' ${data}');
    Response response;
    try {
      response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        print('contest joined multiple: ${response.data}');
        var data = response.data;

        return GenericResponse.fromJson(response.data);
      } else {
        return GenericResponse.withError('Something went wrong');
      }
    } on DioError catch (e) {
      // print(response.data);
      print(e);
      return GenericResponse.withError(e.message);
    }
  }

  Future<GenericResponse> join_contest_by_code(
      String contest_code, user_id, team_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);

    try {
      Response response = await dio.post(url, data: {
        'contest_code': contest_code,
        'user_id': user_id,
        'team_id': team_id,
      });
      if (response.statusCode == 200) {
        var data = response.data;
        print(' ss ${data}');
        return GenericResponse.fromJson(response.data);
      } else {
        return GenericResponse.withError('Something went wrong');
      }
    } on DioError catch (e) {
      return GenericResponse.withError(e.message);
      print(e.message);
    }
  }

  Future user_contest(String userId) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(url, queryParameters: {
        'user_id': userId,
      });
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        print('user contest ${response.data}');
        List<Contest> list =
            data.map((e) => Contest.fromJson(e)).toList(growable: false);
        return list;
      } else {
        List<Contest> list = new List<Contest>();
        return list;
      }
    } on DioError catch (e) {
      print('12aas2d ${userId} ');
      print(e.message);
      List<Contest> list = new List<Contest>();
      return list;
    }
  }

  Future level(String userId) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 45000, receiveTimeout: 20000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(url, queryParameters: {
        'user_id': userId,
      });
      if (response.statusCode == 200) {
        var data = response.data['data'];
        print('total ${response.data['data']}');
        total_level total = total_level.fromJson(data);
        return total;
      } else {
        print('12as2d ${userId} ${response.data}');
        return 'Failed';
      }
    } on DioError catch (e) {
      print('12aas2d ${userId} ');
      print(e.message);
    }
  }

  Future leader_board_fetcher() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;

        List<leaderBoard> list =
            data.map((e) => leaderBoard.fromJson(e)).toList(growable: false);
        return list;
      } else {
        List<leaderBoard> list = new List<leaderBoard>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<leaderBoard> list = new List<leaderBoard>();
      return list;
    }
  }

  Future user_play_history_fetch(userId) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 355000, receiveTimeout: 355000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(url, queryParameters: {
        'user_id': userId,
      });
      if (response.statusCode == 200) {
        print(response.data);
        var data = user_play_History.fromJson(response.data['data']);
        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future email_phone_update(email, phone, userId) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.post(url, queryParameters: {
        'user_id': userId,
        'email': email,
        'phone': phone,
      });
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future recently_played_fetcher(user_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 125000, receiveTimeout: 110000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(url, queryParameters: {
        'user_id': user_id,
      });
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;

        List<recently_played> list = data
            .map((e) => recently_played.fromJson(e))
            .toList(growable: false);
        return list;
      } else {
        List<recently_played> list = List<recently_played>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<recently_played> list = List<recently_played>();
      return list;
    }
  }

  Future selby_fetcher(match_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(url, queryParameters: {
        'match_id': match_id,
      });
      if (response.statusCode == 200) {
        var data = response.data['data']['player_ratio_detail'] as List;

        List<selby_Player> list =
            data.map((e) => selby_Player.fromJson(e)).toList(growable: false);
        return list;
      } else {
        List<selby_Player> list = List<selby_Player>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<selby_Player> list = List<selby_Player>();
      return list;
    }
  }

  Future competed_match(user_id, page) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(url, queryParameters: {
        'user_id': user_id,
        'page': page,
      });
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        print('czx ${data.length}');
        List<match_new> list =
            data.map((e) => match_new.fromJson(e)).toList(growable: false);
        return list;
      } else {
        List<match_new> list = List<match_new>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<match_new> list = List<match_new>();
      return list;
    }
  }

  Future user_contest_by_list(String userId, match_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'user_id': userId,
      'match_id': match_id,
    });
    try {
      Response response = await dio.post(url, queryParameters: {
        'user_id': userId,
        'match_id': match_id,
      });
      print("User contest response ${response.data}");
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;

        try {
          List<ContestJoined> list = data
              .map((e) => ContestJoined.fromJson(e))
              .toList(growable: false);
          return list;
        } catch (e) {
          print('ms ${response.data['data']}');
          List<ContestJoined> list = List<ContestJoined>();
          return list;
        }
      } else {
        List<ContestJoined> list = List<ContestJoined>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<ContestJoined> list = List<ContestJoined>();
      return list;
    }
  }

  Future get_leaderboard_contest(user_id, match_id, contest_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'user_id': user_id,
      'match_id': match_id,
      'contest_id': contest_id,
    });
    try {
      Response response = await dio.post(url, queryParameters: {
        'user_id': user_id,
        'match_id': match_id,
        'contest_id': contest_id,
      });
      if (response.statusCode == 200) {
        var data = response.data['result'] as List;
        print(response.data);
        List<leaderBoard_contest> list = List<leaderBoard_contest>();
        try {
          list = data
              .map((e) => leaderBoard_contest.fromJson(e))
              .toList(growable: false);
        } catch (e) {
          print(e);
        }
        return list;
      } else {
        List<leaderBoard_contest> list = List<leaderBoard_contest>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<leaderBoard_contest> list = List<leaderBoard_contest>();
      return list;
    }
  }

  Future get_team_details_by_match(user_id, match_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'user_id': user_id,
      'match_id': match_id,
    });
    try {
      Response response = await dio.post(url, queryParameters: {
        'user_id': user_id,
        'match_id': match_id,
      });
      if (response.statusCode == 200) {
        var data = response.data['result'] as List;
        print(response.data['result']);
        List<GetTeam_2> list = List<GetTeam_2>();
        try {
          list = data.map((e) => GetTeam_2.fromJson(e)).toList(growable: false);
        } catch (e) {
          print(e);
        }
        return list;
      } else {
        List<GetTeam_2> list = List<GetTeam_2>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<GetTeam_2> list = List<GetTeam_2>();
      return list;
    }
  }

  Future getleaderboard_outside(user_id, match_id, cid, contest_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'user_id': user_id,
      'match_id': match_id,
      'compition_id': cid,
      'contest_id': contest_id,
    });
    try {
      Response response = await dio.post(url,
          data: contest_id != 0
              ? {
                  'user_id': user_id,
                  'match_id': match_id,
                  'compition_id': cid,
                  'contest_id': contest_id,
                }
              : {
                  'user_id': user_id,
                  'match_id': match_id,
                  'compition_id': cid,
                  // 'contest_id': contest_id,
                });
      if (response.statusCode == 200) {
        var data = response.data['result'] as List;
        print('result is ${response.data['result']}');
        List<leaderboard_outside> list = List<leaderboard_outside>();

        list = data
            .map((e) => leaderboard_outside.fromJson(e))
            .toList(growable: false);

        return list;
      } else {
        List<leaderboard_outside> list = List<leaderboard_outside>();
        return list;
      }
    } on DioError catch (e) {
      print('error iu ${e.message}');
      List<leaderboard_outside> list = List<leaderboard_outside>();
      return list;
    }
  }

  Future sendBankDetails(bank data) async {
    final mimedatatype =
        lookupMimeType(data.bank_image, headerBytes: [0xFF, 0xD8]).split('/');
    final bank = await http.MultipartFile.fromPath(
        'bank_image[]', data.bank_image,
        filename: 'bank_image',
        contentType: new MediaType(mimedatatype[0], mimedatatype[1]));
    print("${bank.contentType}${bank.filename} ");
    final imageUpload = http.MultipartRequest('POST', Uri.parse(url));

    imageUpload.files.add(bank);
    imageUpload.fields['account_name'] = data.account_name;
    imageUpload.fields['account_number'] = data.account_number;
    imageUpload.fields['ifsc_code'] = data.ifsc_code;
    imageUpload.fields['bank_name'] = data.bank_name;
    imageUpload.fields['user_id'] = await ConstanceData.id.toString();
    imageUpload.headers['APP-KEY'] = ConstanceData.app_key;
    imageUpload.headers['Authorization'] =
        'Bearer ${ConstanceData.access_token.toString()}';
    imageUpload.headers['Content-Type'] = "multipart/form-data";
    try {
      final streamResp = await imageUpload.send();
      print(streamResp.stream);
      final response = await http.Response.fromStream(streamResp);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("${responseData}");
        return responseData['message'];
      } else {
        print("${response.statusCode} ${response}");
      }
    } catch (e) {
      print(e);
    }
  }

  Future sendPanDetails(pan data) async {
    final mimedatatype =
        lookupMimeType(data.pan_image, headerBytes: [0xFF, 0xD8]).split('/');
    final pan = await http.MultipartFile.fromPath('pan_image[]', data.pan_image,
        filename: 'pan_image',
        contentType: new MediaType(mimedatatype[0], mimedatatype[1]));
    print("${pan.contentType}${pan.filename} ");
    final imageUpload = http.MultipartRequest('POST', Uri.parse(url));

    imageUpload.files.add(pan);
    imageUpload.fields['pan_name'] = data.pan_name;
    imageUpload.fields['pan_number'] = data.pan_number;
    imageUpload.fields['user_id'] = await ConstanceData.id.toString();
    imageUpload.headers['APP-KEY'] = ConstanceData.app_key;
    imageUpload.headers['Authorization'] =
        'Bearer ${ConstanceData.access_token.toString()}';
    imageUpload.headers['Content-Type'] = "multipart/form-data";
    try {
      final streamResp = await imageUpload.send();
      print(streamResp.stream);
      final response = await http.Response.fromStream(streamResp);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("${responseData}");
        return responseData['message'];
      } else {
        print("${response.statusCode} ${response}");
      }
    } catch (e) {
      print(e);
    }
  }

  Future sendUserImage(dynamic data) async {
    final mimedatatype =
        lookupMimeType(data, headerBytes: [0xFF, 0xD8]).split('/');
    final pan = await http.MultipartFile.fromPath('profile_image', data,
        filename: 'profile_image',
        contentType: new MediaType(mimedatatype[0], mimedatatype[1]));
    final imageUpload = http.MultipartRequest('POST', Uri.parse(url));

    imageUpload.files.add(pan);
    imageUpload.fields['user_id'] = await ConstanceData.id.toString();
    imageUpload.headers['APP-KEY'] = ConstanceData.app_key;
    imageUpload.headers['Authorization'] =
        'Bearer ${ConstanceData.access_token.toString()}';
    imageUpload.headers['Content-Type'] = "multipart/form-data";
    try {
      final streamResp = await imageUpload.send();
      print(streamResp.stream);
      final response = await http.Response.fromStream(streamResp);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("${responseData}");
        return responseData['message'];
      } else {
        print("${response.statusCode} ${response}");
      }
    } catch (e) {
      print(e);
    }
  }

  Future create_query(String uquery, name, email, mobile_no) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'cache-control': 'no-cache, private',
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);

    try {
      Response response = await dio.post(url, data: {
        'user_id': ConstanceData.prof.id.toString(),
        'uquery': uquery,
        'name': name,
        'email': email,
        'mobile_no': mobile_no,
      });
      if (response.statusCode == 200) {
        var data = response.data['message'];

        return data;
      } else {
        return '';
      }
    } on DioError catch (e) {
      return '';
    }
  }

  Future<DownloadResponse> check_app_version(String app_version) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(url, queryParameters: {
        'app_version': app_version,
      });
      if (response.statusCode == 200) {
        var data = response.data['status'];
        print('dat ${response.data['status']}');
        return DownloadResponse.fromJson(response.data);
      } else {
        return DownloadResponse.withError('');
      }
    } on DioError catch (e) {
      return DownloadResponse.withError('');
    }
  }

  Future winner_list() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': "application/json",
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    Response response = await dio.get(
      url,
    );
    try {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        print(response.data['data']);
        List<winnerlist> list = List<winnerlist>();
        try {
          list =
              data.map((e) => winnerlist.fromJson(e)).toList(growable: false);
        } catch (e) {
          print('2${e}');
        }

        return list;
      } else {
        List<winnerlist> list = List<winnerlist>();
        return list;
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 302) {
        print(e);
        var data = response.data['data'] as List;

        List<winnerlist> list = List<winnerlist>();

        list = data.map((e) => winnerlist.fromJson(e)).toList(growable: false);

        return list;
      }
      List<winnerlist> list = List<winnerlist>();
      return list;
    }
  }

  Future get_series_list(String user_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print({
      'user_id': user_id,
    });
    try {
      Response response = await dio.post(url, queryParameters: {
        'user_id': user_id,
      });
      print('${response.isRedirect}');
      if (response.statusCode == 200) {
        print(response.data['data']);
        var data = response.data['data'] as List;

        List<SeriesItem> list = List<SeriesItem>();

        list = data.map((e) => SeriesItem.fromJson(e)).toList(growable: false);

        return list;
      } else {
        List<SeriesItem> list = List<SeriesItem>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<SeriesItem> list = List<SeriesItem>();
      return list;
    }
  }

  Future fantasy_point_brekdown() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        var dataOne = response.data['one'] as List;
        var dataBonus = response.data['bonus'] as List;
        var dataEconomy = response.data['economy'] as List;
        var dataStrike = response.data['strike'] as List;

        List<fantasy_point_action> listOne = List<fantasy_point_action>();

        listOne = dataOne
            .map((e) => fantasy_point_action.fromJson(e))
            .toList(growable: false);

        List<fantasy_point_action> listBonus = List<fantasy_point_action>();

        listBonus = dataBonus
            .map((e) => fantasy_point_action.fromJson(e))
            .toList(growable: false);

        List<fantasy_point_action> listEconomy = List<fantasy_point_action>();

        listEconomy = dataEconomy
            .map((e) => fantasy_point_action.fromJson(e))
            .toList(growable: false);

        List<fantasy_point_action> listStrike = List<fantasy_point_action>();

        listStrike = dataStrike
            .map((e) => fantasy_point_action.fromJson(e))
            .toList(growable: false);

        return {
          'one': listOne,
          'bonus': listBonus,
          'economy': listEconomy,
          'strike': listStrike,
        };
      } else {
        List<fantasy_point_action> listOne = List<fantasy_point_action>();

        List<fantasy_point_action> listBonus = List<fantasy_point_action>();

        List<fantasy_point_action> listEconomy = List<fantasy_point_action>();

        List<fantasy_point_action> listStrike = List<fantasy_point_action>();

        return {
          'one': listOne,
          'bonus': listBonus,
          'economy': listEconomy,
          'strike': listStrike,
        };
      }
    } on DioError catch (e) {
      print('ad12 ${e}');
      List<fantasy_point_action> listOne = List<fantasy_point_action>();

      List<fantasy_point_action> listBonus = List<fantasy_point_action>();

      List<fantasy_point_action> listEconomy = List<fantasy_point_action>();

      List<fantasy_point_action> listStrike = List<fantasy_point_action>();

      return {
        'one': listOne,
        'bonus': listBonus,
        'economy': listEconomy,
        'strike': listStrike,
      };
    }
  }

  Future leader_board_list_week(String id, week, compId, start, end) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print({
      'user_id': id,
      'compition_id': compId,
      'week_no': week,
      'start_date': start,
      'end_date': end,
      // 'end_date': end,
      // 'start_date': '2022-03-07',
      // 'end_date': '2022-03-27',
    });
    try {
      Response response = await dio.get(url, queryParameters: {
        'user_id': id,
        'compition_id': compId,
        'week_no': week,
        // 'start_date': start,
        // 'end_date': end,
        // 'end_date': end,
        // 'start_date': '2022-03-07',
        // 'end_date': '2022-03-27',
      });
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        print(response.data['data']);
        List<WeeklyLeaderboardItem> list = List<WeeklyLeaderboardItem>();

        list = data
            .map((e) => WeeklyLeaderboardItem.fromJson(e))
            .toList(growable: false);

        return list;
      } else {
        List<WeeklyLeaderboardItem> list = List<WeeklyLeaderboardItem>();
        return list;
      }
    } on DioError catch (e) {
      print(e);
      List<WeeklyLeaderboardItem> list = List<WeeklyLeaderboardItem>();
      return list;
    }
  }

  Future get_coupon() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;

        List<cupon> list = List<cupon>();

        list = data.map((e) => cupon.fromJson(e)).toList(growable: false);

        return list;
      } else {
        List<cupon> list = List<cupon>();
        return list;
      }
    } on DioError catch (e) {
      List<cupon> list = List<cupon>();
      return list;
    }
  }

  Future get_feed_details() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;

        List<feed> list = List<feed>();

        list = data.map((e) => feed.fromJson(e)).toList(growable: false);

        return list;
      } else {
        List<feed> list = List<feed>();
        return list;
      }
    } on DioError catch (e) {
      List<feed> list = List<feed>();
      return list;
    }
  }

  Future leader_board_list(String user_id, compition_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'user_id': user_id,
      'compition_id': compition_id,
      // 'start_date': '2022-03-07',
      // 'end_date': '2022-03-27',
    });
    try {
      Response response = await dio.post(url, queryParameters: {
        'user_id': user_id,
        'compition_id': compition_id,
        // 'start_date': '2022-03-07',
        // 'end_date': '2022-03-27',
      });
      print('Response ${response.data}');
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;

        List<series_leaderboard_item> list = List<series_leaderboard_item>();

        list = data
            .map((e) => series_leaderboard_item.fromjson(e))
            .toList(growable: false);

        return list;
      } else {
        List<series_leaderboard_item> list = List<series_leaderboard_item>();
        return list;
      }
    } on DioError catch (e) {
      print(e);
      List<series_leaderboard_item> list = List<series_leaderboard_item>();
      return list;
    }
  }

  Future get_week_info(user_id, compition_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    try {
      Response response = await dio.post(url, queryParameters: {
        'user_id': user_id,
        'compition_id': compition_id,
        // 'start_date': '2022-03-07',
        // 'end_date': '2022-03-27',
      });
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;

        List<week> list = List<week>();

        list = data.map((e) => week.fromJson(e)).toList(growable: false);

        return list;
      } else {
        List<week> list = List<week>();
        return list;
      }
    } on DioError catch (e) {
      print(e);
      List<week> list = List<week>();
      return list;
    }
  }

  Future apply_coupon(String title, amount, user_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.post(url, queryParameters: {
        'title': title,
        'amount': amount,
        'user_id': user_id,
      });
      if (response.statusCode == 200) {
        var data = response.data;
        print('cupon ${data}');
        return data;
      } else {
        return true;
      }
    } on DioError catch (e) {
      return true;
    }
  }

  Future send_otp(String email, phone) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.post(url, queryParameters: {
        'email': email == null ? '' : email,
        'phone': phone == null ? '' : phone,
      });
      if (response.statusCode == 200) {
        var data = response.data['message'];
        print(data);
        return data;
      } else {
        return true;
      }
    } on DioError catch (e) {
      print(e);
      return true;
    }
  }

  Future verify_otp(String email, phone, otp) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.post(url, queryParameters: {
        'email': email == null ? '' : email,
        'phone': phone == null ? '' : phone,
        'otp': otp,
      });
      if (response.statusCode == 200) {
        var data = response.data['message'];
        print(data);
        return data;
      } else {
        return true;
      }
    } on DioError catch (e) {
      print(e);
      return true;
    }
  }

  Future player_points(String compition_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    try {
      Response response = await dio.post(url, queryParameters: {
        'compition_id': compition_id,
      });
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;

        List<player_point> list = new List<player_point>();

        list =
            data.map((e) => player_point.fromJson(e)).toList(growable: false);

        return list;
      } else {
        List<player_point> list = new List<player_point>();
        return list;
      }
    } on DioError catch (e) {
      print('sd a${e}');
      List<player_point> list = new List<player_point>();
      return list;
    }
  }

  Future transaction_history_req(String user_id, type) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    var data = {
      'uid': user_id,
      'type': type,
    };
    print(data);
    try {
      Response response = await dio.post(url, queryParameters: data);
      if (response.statusCode == 200) {
        var data = response.data['message'];
        print(data);
        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future paytm_do_payment(String user_id, order_id, amount) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print('order_id sent ${order_id}');
    try {
      Response response = await dio.post(url, data: {
        'uid': user_id,
        'order_id': order_id,
        'amount': amount,
      });
      if (response.statusCode == 200) {
        paytm_token data = paytm_token.fromJson(response.data['data']);
        print(response.data['data']);
        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future banner_list() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 105000, receiveTimeout: 105000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    try {
      Response response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;

        List<banner> list = new List<banner>();

        list = data.map((e) => banner.fromJson(e)).toList(growable: false);

        return list;
      } else {
        List<banner> list = new List<banner>();
        return list;
      }
    } on DioError catch (e) {
      print('sd a${e}');
      List<banner> list = new List<banner>();
      return list;
    }
  }

  Future fetchUpcomingMatches(int num) async {
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(url, queryParameters: {'page': num});
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        print('results are ${response.data['data']}');
        List<match> list = data.map((e) => match.fromJson(e)).toList();

        return list;
      } else {
        List<match> list = new List<match>();
        return list;
      }
    } on DioError catch (e) {
      print(e.response);
      List<match> list = new List<match>();
      return list;
    }
  }

  Future fetchJoinedMatches(user_id) async {
    dio = Dio(option);
    print(url);
    print({'user_id': user_id});
    try {
      Response response =
          await dio.get(url, queryParameters: {'user_id': user_id});
      print("Joined match response ${response.data}");
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        List<match> list = data.map((e) => match.fromJson(e)).toList();

        return list;
      } else {
        List<match> list = new List<match>();
        return list;
      }
    } on DioError catch (e) {
      print('Joined match response  ${e.response}');
      List<match> list = new List<match>();
      return list;
    }
  }

  Future email_verify(email, otp) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.post(url, data: {
        'email': email,
        'otp': otp,
      });
      if (response.statusCode == 200) {
        var data = response.data['message'];
        print(data);
        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<WalletData> getWallet() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        print(data);
        return WalletData.fromJson(data);
      } else {
        return WalletData(false, 0, '0', 'Something Went Wrong');
      }
    } on DioError catch (e) {
      print(e);
      return WalletData(false, 0, '0', e.message);
    }
  }

  Future<MatchPointResponse> getMatchPlayerPoint(team_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    var data = {'team_id': team_id};
    try {
      Response response = await dio.post(url, queryParameters: data);
      print('match point response ${response.data}');
      if (response.statusCode == 200) {
        var data = response.data;
        print(data);
        return MatchPointResponse.fromJson(data);
      } else {
        return MatchPointResponse.withError('Something Went Wrong');
      }
    } on DioError catch (e) {
      print(e);
      return MatchPointResponse.withError(e.message);
    }
  }

  Future transactionStatus(orderId) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'order_id': orderId,
      'uid': ConstanceData.prof.id,
    });
    try {
      Response response = await dio.post(url, data: {
        'order_id': orderId,
        'uid': ConstanceData.prof.id,
      });
      if (response.statusCode == 200) {
        var data = response.data['data']['body']['resultInfo']['resultStatus'];
        print(data);
        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future get_live_match(user_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'user_id': user_id,
    });
    try {
      Response response = await dio.get(url, queryParameters: {
        'user_id': user_id,
      });
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        print('live ${data.length}');
        List<match> list =
            data.map((e) => match.fromJson(e)).toList(growable: false);
        return list;
      } else {
        List<match> list = [];
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<match> list = [];
      return list;
    }
  }

  Future upcoming_match_user(user_id) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 25000, receiveTimeout: 10000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    print(url);
    print({
      'user_id': user_id,
    });
    try {
      Response response = await dio.get(url, queryParameters: {
        'user_id': user_id,
      });
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        print('user upcoming ${data}');
        List<match> list =
            data.map((e) => match.fromJson(e)).toList(growable: false);
        return list;
      } else {
        print('user upcoming 1 ${response.statusCode}');
        List<match> list = [];
        return list;
      }
    } on DioError catch (e) {
      print('user upcoming 2 ${e.message} ${e.response}');
      List<match> list = [];
      return list;
    }
  }

  Future<CashfreeResponse> cashfreeTransaction(
      user_id, amount, customerPhone, customerName, customerEmail) async {
    BaseOptions option =
        BaseOptions(connectTimeout: 35000, receiveTimeout: 35000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    var data = {
      'user_id': user_id,
      'amount': amount,
      'customerPhone': customerPhone,
      'customerName': customerName,
      'customerEmail': customerEmail,
    };
    print(url);
    print(data);
    try {
      Response response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        print(response.data);
        return CashfreeResponse.fromJson(response.data);
      } else {
        return CashfreeResponse(
            false, "Something went wrong", null, '', CashfreeToken('', '', ''));
      }
    } on DioError catch (e) {
      print(e.response);
      return CashfreeResponse(
          false, e.message, null, '', CashfreeToken('', '', ''));
    }
  }

  Future<SoccerCompResponse> getSoccerCompetitions() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 35000, receiveTimeout: 35000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      // 'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    var data = {
      'token': '44689d60663efa7ad59e4903675b794e',
    };
    // print(url);
    print(data);
    try {
      Response response = await dio.get(url, queryParameters: data);
      print(url);
      print('soccer competitions ${response.data}');
      if (response.statusCode == 200) {
        print(response.data);
        return SoccerCompResponse.fromJson(response.data);
      } else {
        return SoccerCompResponse.withError();
      }
    } on DioError catch (e) {
      print(e.response);
      return SoccerCompResponse.withError();
    }
  }

  Future<SoccerMatchResponse> getSoccerMatch() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 35000, receiveTimeout: 35000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      // 'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    var data = {
      'token': '44689d60663efa7ad59e4903675b794e',
    };
    print(url);
    print(data);
    try {
      Response response = await dio.get(url, queryParameters: data);
      print(url);
      print('soccer matches ${response.data}');
      if (response.statusCode == 200) {
        return SoccerMatchResponse.fromJson(response.data);
      } else {
        return SoccerMatchResponse.withError();
      }
    } on DioError catch (e) {
      print(e.response);
      return SoccerMatchResponse.withError();
    }
  }

  Future<SoccerPlayerResponse> getSoccerPlayers() async {
    BaseOptions option =
        BaseOptions(connectTimeout: 35000, receiveTimeout: 35000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'APP-KEY': ConstanceData.app_key,
      // 'Authorization': 'Bearer ${ConstanceData.access_token.toString()}',
    });
    dio = Dio(option);
    var data = {
      'token': '44689d60663efa7ad59e4903675b794e',
    };
    // print(url);
    print(data);
    try {
      Response response = await dio.get(url, queryParameters: data);
      print(url);
      print('soccer matches ${response.data}');
      if (response.statusCode == 200) {
        return SoccerPlayerResponse.fromJson(response.data);
      } else {
        return SoccerPlayerResponse.withError();
      }
    } on DioError catch (e) {
      print(e.response);
      return SoccerPlayerResponse.withError();
    }
  }
}
