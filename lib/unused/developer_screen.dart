// //FOR FUTURE STATE

// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';

// class DeveloperPortal extends StatefulWidget {
//   const DeveloperPortal({super.key});

//   @override
//   _devPortalState createState() => _devPortalState();
// }

// class MultiSelect extends StatefulWidget {
//   final List<String> items;

//   const MultiSelect({super.key, required this.items});

//   @override
//   State<MultiSelect> createState() => _MultiSelectState();
// }

// class _MultiSelectState extends State<MultiSelect> {
//   final List<String> _selectedItems = [];

//   void _itemChange(String itemValue, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         _selectedItems.add(itemValue);
//       } else {
//         _selectedItems.remove(itemValue);
//       }
//     });
//   }

//   void _cancel() {
//     Navigator.pop(context);
//   }

//   void _submit() {
//     Navigator.pop(context, _selectedItems);
//   }

//   //Widget to display selection of Genre window.................................Genre Widget
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.black54,
//       title: const Text('Select Genres'),
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: widget.items
//               .map(
//                 (item) => CheckboxListTile(
//                   value: _selectedItems.contains(item),
//                   title: Text(item,
//                       style: const TextStyle(
//                           color: Colors.white38, fontStyle: FontStyle.normal)),
//                   controlAffinity: ListTileControlAffinity.leading,
//                   onChanged: (isChecked) => _itemChange(item, isChecked!),
//                 ),
//               )
//               .toList(),
//         ),
//       ),
//       actions: [
//         TextButton(
//             onPressed: _cancel,
//             child:
//                 const Text('Cancel', style: TextStyle(color: Colors.white38))),
//         ElevatedButton(
//             onPressed: _submit,
//             child:
//                 const Text('Submit', style: TextStyle(color: Colors.black87))),
//       ],
//     );
//   }
// }

// class _devPortalState extends State<DeveloperPortal> {
//   final ImagePicker imagePicker = ImagePicker();
//   FilePickerResult? result;

//   List<XFile>? imageFileList = [];
//   List<String> _selectedGenre = [];

//   void selectImages() async {
//     final List<XFile> selectedImages = await imagePicker.pickMultiImage();
//     if (selectedImages.isNotEmpty) {
//       imageFileList!.addAll(selectedImages);
//     }
//     setState(() {});
//   }

//   void _showMultiSelect() async {
//     final List<String> genres = ['Action', 'Adventure', '3D', 'Puzzle'];

//     final List<String>? results = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return MultiSelect(
//           items: genres,
//         );
//       },
//     );
//     if (results != null) {
//       setState(() {
//         _selectedGenre = results;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xFF424242),
//                 Color(0xff9C27B0),
//                 Color(0xFF303030),
//               ],
//               stops: [0.05, 0.25, 0.7],
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 35,
//               ),
//               //Image.asset(name),
//               const SizedBox(
//                 height: 15,
//               ),
//               ConstrainedBox(
//                 constraints: const BoxConstraints(
//                   maxHeight: 200,
//                   maxWidth: 200,
//                 ),
//                 child: Image.asset(
//                   'assets/app_icon.png',
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(100, 1, 20, 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Dev Portal',
//                       style: TextStyle(
//                           color: Colors.purple[300],
//                           fontStyle: FontStyle.italic,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 10),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               SizedBox(
//                 height: 480,
//                 width: 325,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     const Text(
//                       'Post your game via Neon.',
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black38,
//                           fontWeight: FontWeight.bold,
//                           fontStyle: FontStyle.italic),
//                     ),
//                     const SizedBox(
//                       height: 60,
//                     ),
//                     const SizedBox(
//                         height: 45,
//                         width: 250,
//                         child: TextField(
//                           style: TextStyle(color: Colors.black87),
//                           textAlign: TextAlign.right,
//                           decoration: InputDecoration(
//                             labelText: 'Game. *',
//                             labelStyle: TextStyle(
//                               color: Colors.black87,
//                             ),
//                             filled: true,
//                             fillColor: Colors.black26,
//                             //suffixIcon:
//                             //Icon(FontAwesomeIcons.envelope, size: 17)
//                           ),
//                         )),
//                     const SizedBox(
//                       height: 2,
//                     ),
//                     const SizedBox(
//                         height: 45,
//                         width: 250,
//                         child: TextField(
//                           style: TextStyle(color: Colors.black87),
//                           textAlign: TextAlign.right,
//                           decoration: InputDecoration(
//                             labelText: 'Game Description. *',
//                             labelStyle: TextStyle(
//                               color: Colors.black87,
//                             ),
//                             filled: true,
//                             fillColor: Colors.black26,
//                             //suffixIcon:
//                             //Icon(FontAwesomeIcons.eyeSlash, size: 17)
//                           ),
//                         )),
//                     const Divider(
//                       height: 10,
//                       color: Colors.white10,
//                     ),

//                     //Selecting Genre Button....................................BUTTON
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: MaterialButton(
//                         color: Colors.white10,
//                         onPressed: _showMultiSelect,
//                         child: const Text(
//                           'Select Genre.',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black87,
//                               fontStyle: FontStyle.italic),
//                         ),
//                       ),
//                     ),

//                     Wrap(
//                       children: _selectedGenre
//                           .map((e) => Chip(
//                                 backgroundColor: Colors.black87,
//                                 label: Text(
//                                   e,
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ))
//                           .toList(),
//                     ),
//                     const Divider(
//                       height: 10,
//                       color: Colors.white10,
//                     ),

//                     //Selecting Images Button...................................BUTTON
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: MaterialButton(
//                           color: Colors.white10,
//                           child: const Text(
//                             'Select Images.',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                                 fontStyle: FontStyle.italic),
//                           ),
//                           onPressed: () {
//                             selectImages();
//                           }),
//                     ),

//                     Expanded(
//                       child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: GridView.builder(
//                               itemCount: imageFileList!.length,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 3),
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Image.file(
//                                     File(imageFileList![index].path),
//                                     fit: BoxFit.cover);
//                               })),
//                     ),
//                     const Divider(
//                       height: 5,
//                       color: Colors.white10,
//                     ),

//                     //Selecting Files Button....................................BUTTON
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: MaterialButton(
//                         color: Colors.white10,
//                         child: const Text(
//                           'Select File.',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black87,
//                               fontStyle: FontStyle.italic),
//                         ),
//                         onPressed: () async {
//                           result = await FilePicker.platform
//                               .pickFiles(allowMultiple: true);
//                           if (result == null) {
//                             print("No file selected");
//                           } else {
//                             setState(() {});
//                             for (var element in result!.files) {
//                               print(element.name);
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                     const Divider(
//                       height: 5,
//                       color: Colors.white10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(30.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           if (result != null)
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Text(
//                                     'Selected file:',
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   ListView.separated(
//                                     shrinkWrap: true,
//                                     itemCount: result?.files.length ?? 0,
//                                     itemBuilder: (context, index) {
//                                       return Text(
//                                           result?.files[index].name ?? '',
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold));
//                                     },
//                                     separatorBuilder:
//                                         (BuildContext context, int index) {
//                                       return const SizedBox(
//                                         height: 5,
//                                       );
//                                     },
//                                   )
//                                 ],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.black38,
//                             foregroundColor: Colors.white70,
//                           ),
//                           onPressed: () {},
//                           child: const Text('Post to Neon'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
