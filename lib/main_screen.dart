import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:search_and_infinite_list/list_item.dart';
import 'package:search_and_infinite_list/provider.dart';
import 'package:search_and_infinite_list/search_panel.dart';
import 'package:search_and_infinite_list/user_model.dart';
import 'package:synchronized/synchronized.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SiProvider? data_controller;
  final ScrollController _controller = ScrollController();
  var lock = Lock();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data_controller = Provider.of<SiProvider>(context);
    when((p0) => data_controller!.getData.isEmpty, () async {
      // Get from localDb
      // Request Data from api
      await data_controller!.requestData();
    });
    _controller.addListener(() async {
      await lock.synchronized(() async {
        if (_controller.position.pixels >
            _controller.position.maxScrollExtent) {
          if (data_controller!.getSearch.isEmpty) {
            await Future.delayed(const Duration(seconds: 2), () {
              data_controller!.requestData();
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        body: SafeArea(
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        'Infinite Scroll List and Search',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w300),
                      )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image(
                        image: AssetImage('git_assets/searching.png'),
                        fit: BoxFit.contain,
                        height: 100,
                      ),
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SearchPanel(),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: Observer(builder: (context) {
              final loading = data_controller!.isLoading;
              final data = data_controller!.getData;
              final search = data_controller!.getSearch;

              List<User> currentData = [];

              if (search.isEmpty) {
                currentData = data;
              } else {
                currentData = search;
              }

              return ListView.builder(
                controller: _controller,
                itemCount: currentData.length + 1,
                // (search.isEmpty ? data.length : search.length) + 1,
                itemBuilder: (context, index) {
                  // final def_data = search.isEmpty ? data : search;
                  if (index == currentData.length) {
                    return loading
                        ? const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox();
                  } else {
                    return ListItem(user: currentData[index]);
                  }
                },
              );
            }))
          ]),
        ),
      ),
    );
  }
}
