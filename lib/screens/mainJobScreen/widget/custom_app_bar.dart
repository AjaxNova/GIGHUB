import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/controller/provider/auth_provider.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/screens/profilePage/profile_page.dart';
import 'package:lite_jobs/screens/searchScreen/search_screen.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/home_screen_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context, listen: false);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(prov.getUserModel.uid)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Image(
                        height: 60,
                        image: AssetImage("assets/icons/Icons8menu641.png"))),
                Row(
                  children: [
                    const SizedBox(
                        child: Icon(
                      Icons.filter_alt_outlined,
                      size: 33,
                    )),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2.5, color: Colors.grey.shade900),
                          borderRadius: BorderRadius.circular(25)),
                      height: 40,
                      width: 40,
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 19,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      height: 60,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.red),
                            child: const Image(
                                width: 30,
                                height: 30,
                                image: AssetImage(
                                    "assets/icons/Icons8person941.png")),
                          ),
                          Positioned(
                            top: 7,
                            right: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade600),
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.blue),
                              height: 18,
                              width: 18,
                              child: Center(
                                  child: Text(
                                "4",
                                style: GoogleFonts.inter(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          final userMod =
              UserModel.fromSnap(snapshot.data as DocumentSnapshot<Object?>);
          return SizedBox(
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Image(
                        height: 50,
                        image: AssetImage("assets/icons/Icons8menu641.png"))),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        showSortOptions(context);
                      },
                      child: const Opacity(
                        opacity: .7,
                        child: SizedBox(
                            child: Icon(
                          Icons.filter_alt_outlined,
                          size: 28,
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Utils().navigateMe(
                            context: context,
                            page: SearchScreen(
                              uid: userMod.uid,
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.8, color: Colors.grey.shade900),
                            borderRadius: BorderRadius.circular(25)),
                        height: 30,
                        width: 30,
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      height: 60,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Utils().navigateMe(
                                  context: context,
                                  page: ProfilePage(
                                    user: userMod,
                                    isHost: true,
                                  ));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 8),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(userMod.photoUrl)),
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.red),
                            ),
                          ),
                          Positioned(
                            top: 7,
                            right: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade600),
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.blue),
                              height: 15,
                              width: 15,
                              child: Center(
                                  child: Text(
                                "4",
                                style: GoogleFonts.inter(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Image(
                        height: 60,
                        image: AssetImage("assets/icons/Icons8menu641.png"))),
                Row(
                  children: [
                    const SizedBox(
                        child: Icon(
                      Icons.filter_alt_outlined,
                      size: 33,
                    )),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2.5, color: Colors.grey.shade900),
                          borderRadius: BorderRadius.circular(25)),
                      height: 40,
                      width: 40,
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 19,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      height: 60,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.red),
                            child: const Image(
                                width: 30,
                                height: 30,
                                image: AssetImage(
                                    "assets/icons/Icons8person941.png")),
                          ),
                          Positioned(
                            top: 7,
                            right: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade600),
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.blue),
                              height: 18,
                              width: 18,
                              child: Center(
                                  child: Text(
                                "4",
                                style: GoogleFonts.inter(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

void showSortOptions(BuildContext context) {
  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(110, 80, 100, 100),
    items: <PopupMenuItem<String>>[
      const PopupMenuItem<String>(
        value: "time",
        child: Text('Sort by Time'),
      ),
      const PopupMenuItem<String>(
        value: "title",
        child: Text('Sort by Title'),
      ),
      const PopupMenuItem<String>(
        value: "price",
        child: Text('Sort by Price'),
      ),
    ],
  ).then((criterion) {
    if (criterion != null) {
      Provider.of<HomeScreenProvider>(context, listen: false)
          .setSortType(criterion);
    }
  });
}
