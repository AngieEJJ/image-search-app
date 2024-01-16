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
  final _controller = TextEditingController();

  List<Photo> _photos = [];

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetch('rose');
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
              controller: _controller,
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
                  onTap: () async {
                    final photos = await fetch(_controller.text);
                    setState(() {
                      _photos = photos;
                    });
                  },
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
                  itemCount: _photos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
                  ),
                  itemBuilder: (context, index) {
                    final photo = _photos[index];
                    // print(_photos[index]);
                    // print(_photos);
                    return PhotoWidget(photo: photo);// list가 아닌 photo 타입이어야 하기 때문에 리스트가 아닌 해당하는 객체가 필요.
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
