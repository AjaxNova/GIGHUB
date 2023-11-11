import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lite_jobs/provider/searc_screen_provider.dart';
import 'package:provider/provider.dart';

class SpecialAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100.0);
  final String appBarTitle;
  final VoidCallback? onTap;
  final BuildContext context;
  final bool isChat;
  final String? photoUrl;
  final bool isProfile;
  final bool isSearch;

  final TextEditingController? searchController;

  const SpecialAppbar({
    required this.context,
    required this.onTap,
    required this.appBarTitle,
    this.isChat = false,
    this.isProfile = false,
    this.isSearch = false,
    this.searchController,
    this.photoUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.08,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 19),
        child: Row(
          children: [
            isProfile
                ? const SizedBox()
                : GestureDetector(
                    onTap: onTap,
                    child: const LineIcon.arrowCircleLeft(
                      size: 42,
                    ),
                  ),
            isChat
                ? CircleAvatar(
                    backgroundImage: NetworkImage(photoUrl!),
                  )
                : const SizedBox(),
            if (isSearch)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors
                          .grey[200], // Background color for the input field
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              final prov = Provider.of<SearchScreenProvider>(
                                  context,
                                  listen: false);
                              prov.isSearchinTotrue();

                              prov.setSearchName(value);
                            },
                            controller: searchController,
                            onFieldSubmitted: (_) {
                              final prov = Provider.of<SearchScreenProvider>(
                                  context,
                                  listen: false);
                              prov.isSearchinTotrue();
                            }, // Handle search action
                            decoration: InputDecoration(
                              labelText: "Search",
                              labelStyle:
                                  GoogleFonts.inter(color: Colors.black),
                              border: InputBorder
                                  .none, // Remove the default input field border
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 16.0), // Padding
                            ),
                          ),
                        ),
                        const Icon(Icons.search,
                            color: Colors.black), // Search icon
                      ],
                    ),
                  ),
                ),
              )
            else
              Container(
                margin: const EdgeInsets.only(top: 2, left: 16),
                child: Text(
                  appBarTitle,
                  style: GoogleFonts.inter(
                      letterSpacing: .5,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
