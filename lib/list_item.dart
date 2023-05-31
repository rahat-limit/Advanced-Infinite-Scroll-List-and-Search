import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:search_and_infinite_list/provider.dart';
import 'package:search_and_infinite_list/user_model.dart';

class ListItem extends StatefulWidget {
  final User user;
  const ListItem({super.key, required this.user});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    SiProvider data_controller = Provider.of<SiProvider>(context);
    void delete(User user) {
      data_controller.delete(user);
    }

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CupertinoListTile(
              backgroundColor: Colors.white70,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
              title: Text(
                widget.user.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(widget.user.email),
              trailing: IconButton(
                  splashRadius: 21,
                  splashColor: Colors.blueGrey[400],
                  onPressed: () => delete(widget.user),
                  icon: const Icon(
                    Icons.delete,
                    color: CupertinoColors.systemRed,
                    size: 21,
                  ))),
        ));
  }
}
