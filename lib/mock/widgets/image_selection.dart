// import 'package:flutter/material.dart';

// import '../../utils/colors/colors.dart';

// Column _circleAvatar() {
//   return Column(
//     children: [
//       Consumer<SignUpScreenProvider>(
//         builder: (context, value, child) {
//           return value.fetchImage != null
//               ? CircleAvatar(
//                   backgroundColor: singUPButtonColor,
//                   radius: 77,
//                   child: Stack(
//                     children: [
//                       value.isImageIsLoading
//                           ? const CircularProgressIndicator(
//                               color: singUPButtonColor,
//                             )
//                           : CircleAvatar(
//                               backgroundColor: Colors.white,
//                               radius: 72,
//                               backgroundImage: MemoryImage(value.fetchImage!),
//                               child: value.isImageIsLoading
//                                   ? const CircularProgressIndicator(
//                                       color: singUPButtonColor,
//                                     )
//                                   : const SizedBox(),
//                             ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: GestureDetector(
//                           onTap: () async {
//                             value.changeIsLoading();
//                             final file = await pickImage(ImageSource.gallery);
//                             if (file != null) {
//                               value.setImage(file);
//                               value.changeIsImageLoading();
//                             } else {
//                               value.changeIsImageLoading();
//                             }
//                           },
//                           child: const CircleAvatar(
//                             radius: 21,
//                             backgroundColor: Colors.grey,
//                             child: CircleAvatar(
//                               backgroundColor: singUPButtonColor,
//                               child: Icon(
//                                 Icons.mode_edit_outlined,
//                                 color: Colors.black,
//                                 size: 26,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               : CircleAvatar(
//                   backgroundColor: singUPButtonColor,
//                   radius: 77,
//                   child: GestureDetector(
//                     onTap: () async {
//                       value.changeIsImageLoading();
//                       final file = await pickImage(ImageSource.gallery);
//                       if (file != null) {
//                         value.setImage(file);
//                         value.changeIsImageLoading();
//                       } else {
//                         value.changeIsImageLoading();
//                       }
//                     },
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 72,
//                       child: value.isImageIsLoading
//                           ? const CircularProgressIndicator(
//                               color: singUPButtonColor,
//                             )
//                           : Image.asset(
//                               "assets/images/default_person.png",
//                               fit: BoxFit.cover,
//                             ),
//                     ),
//                   ),
//                 );
//         },
//       ),
//     ],
//   );
// }
