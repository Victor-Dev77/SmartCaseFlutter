import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String id;
  final String pseudo;
  final String mail;

  User({
    @required this.id,
    @required this.pseudo,
    @required this.mail,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
        id: doc['userId'],
        mail: doc['mail'],
        pseudo: doc['pseudo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "pseudo": pseudo,
      "mail": mail
    };
  }
}
