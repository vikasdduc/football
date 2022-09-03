

import 'package:fantacySports/Testing/Chat.dart';
import 'package:fantacySports/Testing/Matches.dart';
import 'package:fantacySports/Testing/Winners.dart';
import 'package:fantacySports/modules/home/mainPage.dart';
import 'package:fantacySports/modules/navigationBar/feed.dart';
import 'package:fantacySports/modules/navigationBar/group.dart';
import 'package:fantacySports/modules/navigationBar/myMatches/myMatches.dart';
import 'package:fantacySports/modules/navigationBar/winner.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:fragment_navigate/navigate-support.dart';

class Fragments{
  static FragNavigate fragNav;
  static List<Posit> screens = <Posit>[
    Posit(
      key: "Home",
      title: "Apna Team",
      fragment: MainPage(),
      icon:Icon(
        FontAwesomeIcons.home,
        size: 18,
      ),
    ),Posit(
      key: "Matches",
      title: "My Matches",
      // fragment: MyMatchesPage(),
      fragment: Matches(),
      icon:Icon(
        FontAwesomeIcons.basketballBall,
        size: 18,
      ),
    ),Posit(
      key: "Winners",
      title: "Winners",
      // fragment: WinnerPage(),
      fragment: Winner(),
      icon:Icon(
        FontAwesomeIcons.award,
        size: 18,
      ),
    ),Posit(
      key: "Feed",
      title: "Feed",
      fragment: FeedPage(),
      icon:Icon(
        FontAwesomeIcons.images,
        size: 18,
      ),
    ),
    Posit(
      key: "Chat",
      title: "Contact Us",
      fragment: GroupPage(),
      icon:Icon(
        FontAwesomeIcons.sms,
        size: 18,
      ),
    ),
    Posit(
      key: "Chat",
      title: "Contact Us",
      fragment: GroupPage(),
      icon:Icon(
        FontAwesomeIcons.sms,
        size: 18,
      ),
    ),

  ];

  static get list{
    return screens;
  }

}