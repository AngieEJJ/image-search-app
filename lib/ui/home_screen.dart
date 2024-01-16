import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_search/model/photo.dart';
import 'package:http/http.dart' as http;
import 'widget/photo_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Photo>> fetch(String query) async {
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=41487259-59b1e614313376c6d9c201e9c&q=$query&image_type=photo'));
    // print(response.body);
    // print(jsonDecode(response.body));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    // print(jsonResponse['hits'].runtimeType);
    List hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }

  @override
  void initState() {
    fetch('query');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('이미지 검색 앱'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Color(0xFF4FB6B2),
                  ),
                ),
                hintText: 'Search',
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    color: Color(0xFF4FB6B2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
                  ),
                  itemBuilder: (context, index) {
                    return Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
