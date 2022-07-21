import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:future_builder_ex/mock_data/post.dart';
import 'package:future_builder_ex/picture.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('포스트'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                suffixIcon: Icon(Icons.search),
                hintText: '검색어를 입력하세요',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Post>>(
                future: getImages(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('에러가 발생했습니다'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('데이터가 없습니다'),
                    );
                  }

                  final posts = snapshot.data!;

                  if (posts.isEmpty) {
                    return const Center(
                      child: Text('데이터가 0개입니다'),
                    );
                  }

                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(posts[index].title),
                        subtitle: Text(posts[index].body),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Post>> getImages() async {
    await Future.delayed(const Duration(seconds: 2));

    String jsonString = mypost;

    Map<String, dynamic> json = jsonDecode(jsonString);
    List post = json['post'];
    return post.map((e) => Post.fromJson(e)).toList();

    // 에러 발생
    // throw Exception('엄청난 에러');

    // 빈 리스트
    // return [];
  }
}
