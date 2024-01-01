import 'dart:io';

import 'package:flutter/material.dart';

class ViewStudentScreen extends StatelessWidget {
  final String name;
  final String age;
  final String place;
  final String phone;
  final String imagePath;

  const ViewStudentScreen({
    required this.name,
    required this.age,
    required this.place,
    required this.phone,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 15, 58),
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        backgroundColor: Color.fromARGB(255, 7, 140, 223),
        title: Text('P R O F I L E'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 62, 4, 79),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                backgroundImage: FileImage(File(imagePath)),
              ),
            ),
            SizedBox(height: 20),
            CardItem(
              title: 'Name',
              content: name,
              isAlternate: false,
            ),
            CardItem(
              title: 'Age',
              content: age,
              isAlternate: true,
            ),
            CardItem(
              title: 'Place',
              content: place,
              isAlternate: false,
            ),
            CardItem(
              title: 'Phone',
              content: phone,
              isAlternate: true,
            ),
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String content;
  final bool isAlternate;

  const CardItem({
    required this.title,
    required this.content,
    required this.isAlternate,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isAlternate
        ? Color.fromARGB(255, 33, 54, 101)
        : Color.fromARGB(255, 52, 4, 79);
    final textColor = isAlternate
        ? Color.fromARGB(255, 255, 255, 255)
        : Color.fromARGB(255, 255, 255, 255);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: bgColor,
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
