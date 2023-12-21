import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/models/blog.dart';

class BlogDetail extends StatefulWidget {
  final String blogId;

  const BlogDetail({Key? key, required this.blogId}) : super(key: key);

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  late Future<Blog> futureBlog;

  @override
  void initState() {
    super.initState();
    futureBlog = fetchBlogDetails(widget.blogId);
  }

  Future<Blog> fetchBlogDetails(String blogId) async {
    final response = await http.get(
        Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$blogId"));

    if (response.statusCode == 200) {
      return Blog.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load blog details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Detayı"),
      ),
      body: FutureBuilder<Blog>(
        future: futureBlog,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Hata: ${snapshot.error}'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data!.title!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Yazar: ${snapshot.data!.author!}',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 16),
                  Image.network(
                    snapshot.data!.thumbnail!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Text(
                    snapshot.data!.content!,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
