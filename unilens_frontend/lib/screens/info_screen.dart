import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Future<List<dynamic>> fetchResults() async {
    final response = await http.get(Uri.parse('http://localhost:8000/results'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<dynamic>>(
        future: fetchResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final article = data[index];
                return LinkBox(
                  index: index,
                  title: article['title'],
                  url: article['url'],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class LinkBox extends StatelessWidget {
  final int index;
  final String title;
  final String url;

  const LinkBox({
    required this.index,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(
            '${index + 1}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          _launchURL(url);
        },
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
