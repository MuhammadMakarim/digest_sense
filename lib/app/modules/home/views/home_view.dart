import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_monitoring/app/data/dummy.dart';
import 'package:plant_monitoring/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('images/11-profile.png'),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 4),
                        ),
                        Icon(
                          Icons.notifications,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 15, bottom: 7),
              child: Text(
                "Hey User",
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff91A37F),
                ),
              ),
              // child: Obx(() => Text(
              //       controller.isLogin.value == false
              //           ? 'Hello Guest'
              //           : 'Hello, ${controller.fireAuthC.user!.displayName}',
              //       style: TextStyle(
              //           fontWeight: FontWeight.w700,
              //           color: Colors.black,
              //           fontSize: 16),
              //     )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 5),
              child: Text(
                'Lets Transform Waste into Green Energy',
                style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff394929)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, bottom: 10, right: 15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 20, color: Color(0xff3CB371)),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff3CB371),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff3CB371)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Color(0xff3CB371)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: MasonryGridView.builder(
                itemCount: 1,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 15, bottom: 15),
                      child: _buildItem(context, index));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: Center(
                child: Image.asset(
                  '${data[index]['image']}',
                  fit: BoxFit.cover,
                  height: 200,
                  width: 200,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Text('${data[index]['title']}',
                      // overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff304022))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  // Adding SizedBox to constrain the width of ElevatedButton
                  width: 30, // Adjust the width according to your UI design
                  height: 30, // Adjust the height according to your UI design
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.DETAIL);
                    },
                    child: Icon(
                      Icons.arrow_right_alt_sharp,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(1),
                      backgroundColor: Color(0xff739B61),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
