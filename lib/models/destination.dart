import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartcaseflutter/utils/date_handle.dart';

class Destination {
  final String id;
  final String city;
  final Map location;
  final String date;

  Destination({
    @required this.id,
    @required this.city,
    @required this.location,
    @required this.date,
  });

  factory Destination.fromDocument(DocumentSnapshot doc) {
    return Destination(
        id: doc['id'],
        city: doc['city'],
        location: doc['location'],
        date: DateHandle.to.parseDateTime(doc["date"].toDate(), "dd/MM/yyyy"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "city": city,
      "location": location,
      "date": DateHandle.to.parseDateString(date, "dd/MM/yyyy")
    };
  }
}
