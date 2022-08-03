import 'package:flutter/material.dart';
import 'package:rest_api_with_flutter/services/remote_services.dart';

import '../models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: Visibility(
          visible: isLoaded,
          child: ListView.builder(
            itemCount: posts?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(posts?[index]?.title ?? '',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                subtitle: Text(posts?[index]?.body ?? ''),
              );
            },
          ),
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
