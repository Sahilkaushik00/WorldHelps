import 'package:flutter/material.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donate"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? 3
                      : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: (2 / 2.5),
                ),
                children: [
                  homeCard(
                    icon: Icons.menu_book_rounded,
                    title: "Books",
                    color1: const Color(0xff8E2DE2),
                    color2: const Color(0xff4A00E0),
                    onpress: () {},
                  ),
                  homeCard(
                    icon: Icons.shopping_bag,
                    title: "Cloths",
                    color1: const Color(0xfff12711),
                    color2: const Color(0xfff5af19),
                    onpress: () {},
                  ),
                  homeCard(
                    icon: Icons.food_bank_rounded,
                    title: "Food",
                    onpress: () {},
                    color1: const Color(0xff52c234),
                    color2: const Color(0xff061700),
                  ),
                  homeCard(
                    icon: Icons.local_offer,
                    title: "Shoes",
                    onpress: () {},
                    color1: const Color(0xff232526),
                    color2: const Color(0xff414345),
                  ),
                  homeCard(
                    icon: Icons.devices,
                    title: "Electronics items",
                    onpress: () {},
                    color1: const Color(0xff4b6cb7),
                    color2: const Color(0xff182848),
                  ),
                  homeCard(
                    icon: Icons.money,
                    title: "Money",
                    onpress: () {},
                    color1: const Color(0xffB38728),
                    color2: const Color(0xffFBF5B7),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector homeCard({
    required String title,
    required IconData icon,
    required VoidCallback onpress,
    required Color color1,
    required Color color2,
  }) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [color1, color2],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 50,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
