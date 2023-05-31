import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_and_infinite_list/provider.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({super.key});

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  TextEditingController? _controller;
  SiProvider? data_controller;
  int _selectedItem = 0;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data_controller = Provider.of<SiProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 5),
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              controller: _controller,
              placeholder: 'Search',
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              onChanged: (value) {
                // search
                data_controller!.search(value);
              },
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}

// IconButton(
//               onPressed: () {
//                 showActionSheet(context, () {
//                   // Choose Category Callback
//                   showDialog(
//                     context,
//                     CupertinoPicker(
//                       magnification: 1.22,
//                       squeeze: 1.2,
//                       useMagnifier: true,
//                       itemExtent: 32,
//                       // This sets the initial item.
//                       scrollController: FixedExtentScrollController(
//                         initialItem: _selectedItem,
//                       ),
//                       // This is called when selected item is changed.
//                       onSelectedItemChanged: (int selectedItem) {
//                         setState(() {
//                           _selectedItem = selectedItem;
//                         });
//                       },
//                       children: List<Widget>.generate(dialogItems.length,
//                           (int index) {
//                         return Center(child: Text(dialogItems[index]));
//                       }),
//                     ),
//                   );
//                 }, () {
//                   // Submit Callback
//                   if (_selectedItem == 1) {
//                     data_controller!.activeCategory();
//                   }
//                   Navigator.pop(context);
//                 });
//               },
//               icon: const Icon(
//                 Icons.filter_alt_outlined,
//                 size: 24,
//               ))

// Second Popup

// void showDialog(BuildContext context, Widget child) {
//   showCupertinoModalPopup<void>(
//     context: context,
//     builder: (BuildContext context) => Container(
//       height: 216,
//       padding: const EdgeInsets.only(top: 6.0),
//       // The Bottom margin is provided to align the popup above the system navigation bar.
//       margin: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       // Provide a background color for the popup.
//       color: CupertinoColors.systemBackground.resolveFrom(context),
//       // Use a SafeArea widget to avoid system overlaps.
//       child: SafeArea(
//         top: false,
//         child: child,
//       ),
//     ),
//   );
// }

// // First popup
// void showActionSheet(
//     BuildContext context, VoidCallback choose, VoidCallback submit) {
//   showCupertinoModalPopup<void>(
//     context: context,
//     builder: (BuildContext context) => CupertinoActionSheet(
//       title: const Text('Categories'),
//       actions: <CupertinoActionSheetAction>[
//         CupertinoActionSheetAction(
//           onPressed: choose,
//           child: const Text('Choose'),
//         ),
//         CupertinoActionSheetAction(
//           isDestructiveAction: true,
//           onPressed: submit,
//           child: const Text('Submit'),
//         ),
//       ],
//     ),
//   );
// }
