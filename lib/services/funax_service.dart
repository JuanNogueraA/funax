import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funax/model/comment.dart';
import 'package:funax/model/message.dart';
import 'package:funax/model/trend.dart';
import 'package:funax/model/tweet.dart';
import 'package:funax/model/user.dart';

class FunaxService {
  List<Tweet> tweets = [];
  List<User> users = [];
  List<Comment> comments = [];
  List<Message> messages = [];
  List<Trend> trends = [];

  bool loaded = false;

  Future<void> load_data() async {
    final response = await rootBundle.loadString('assets/data/funax_data.json');
    final data = json.decode(response);

    users = (data['usuarios'] as List)
        .map(
          (u) => User(
            id: u['id'],
            username: u['username'],
            nombre: u['nombre'],
            avatar: u['avatar'],
          ),
        )
        .toList();
    tweets = (data['tweets'] as List)
        .map(
          (t) => Tweet(
            id: t['id'],
            userId: t['userId'],
            contenido: t['contenido'],
            likes: List<int>.from(t['likes']),
          ),
        )
        .toList();
    comments = (data['comentarios'] as List)
        .map(
          (c) => Comment(
            id: c['id'],
            tweetId: c['tweetId'],
            userId: c['userId'],
            contenido: c['contenido'],
          ),
        )
        .toList();
    messages = (data['mensajes'] as List)
        .map(
          (m) => Message(
            id: m['id'],
            de: m['de'],
            para: m['para'],
            contenido: m['contenido'],
            leido: m['leido'],
          ),
        )
        .toList();
    trends = (data['trends'] as List)
        .map(
          (t) =>
              Trend(id: t['id'], hastag: t['hastag'], cantidad: t['cantidad']),
        )
        .toList();
  }

  List<Tweet> getTweets() => tweets;
  User getUser(int id) {
    return users.firstWhere((element) => element.id == id);
  }

  List<Comment> getComments(int tweetId) {
    return comments.where((element) => element.tweetId == tweetId).toList();
  }

  void addTweet(String contenido) {
    tweets.add(
      Tweet(
        id: tweets.isEmpty ? 1 : tweets.last.id + 1,
        userId: 1,
        contenido: contenido,
        likes: [],
      ),
    );
  }

  void updateTweet(int idTweet, String nuevoContenido) {
    final index = tweets.indexWhere((element) => element.id == idTweet);
    if (index != -1) {
      tweets[index].contenido = nuevoContenido;
    }
  }

  void deleteTweet(int idTweet) {
    tweets.removeWhere((element) => element.id == idTweet);
  }

  void likeTweet(int idTweet, String username) {
    final index = tweets.firstWhere((element) => element.id == idTweet);
    if (!index.likes.contains(1)) {
      index.likes.add(1);
    }
  }
}
