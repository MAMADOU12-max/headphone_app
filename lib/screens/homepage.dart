import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // create our animation
  late AnimationController animationController;
  late Animation<Offset> hoverAnimation;

  Color black = const Color(0xff000000);
  Color cream = const Color(0xfffcecd0);
  Color blue = const Color(0xffb6d7e4);

  // list of product
  List<Product> products = [
    Product(color: const Color(0xff000000), path: "assets/images/black.png"),
    Product(color: const Color(0xfffcecd0), path: "assets/images/cream.png"),
    Product(color: const Color(0xffb6d7e4), path: "assets/images/blue.png")
  ];

  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    // we add SingleTickerProviderStateMixin to get the vsync
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700))
          ..repeat(reverse: true // to keep the same flow when elementback
              );
    hoverAnimation = Tween(
      begin: const Offset(0, 0),
      end: const Offset(0, 0.02),
    ).animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff292929),
      body: SafeArea(
        child: Column(
          children: [
            SlideTransition(
                position: hoverAnimation,
                // make smooth when image change color
                child: AnimatedSwitcher( 
                   duration: const Duration(milliseconds: 700),
                  child: Image.asset(
                    products[currentIndex].path), 
                    // important to add key so AnimatedSwitcher will have effect
                    key: ValueKey<int>(currentIndex),
                  )
                ),
            const SizedBox(height: 20.0),
            const Text("BOAT ROCKERZ 450R",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
            const Text("Bluetooth Headphones",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(products.length, (index) {
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: products[index].color,
                      ),
                    ));
              }),
            ), 
            const SizedBox(height: 20.0),
            const Text(
              "Rs. 1,500",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25.0,
                fontWeight: FontWeight.w500
              )
            ), 
            const SizedBox(height: 30.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              height: 45.0,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle( 
                  backgroundColor: MaterialStateProperty.all(products[currentIndex].color)
                ),
                onPressed: () { 

                },
                child: const Text( 
                  "BUY IT" , 
                  style: TextStyle( 
                    color: Colors.brown, 
                    fontSize: 20.0, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Product {
  final Color color;
  final String path;

  Product({required this.color, required this.path});
}
