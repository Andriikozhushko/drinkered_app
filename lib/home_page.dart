import 'package:flutter/material.dart';
import 'package:task1_shop/model/cool_drinks.dart';

import 'cart_page.dart';
import 'details_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late final TabController _tabController =
  TabController(length: 4, vsync: this);
  List<CoolDrinks> coolDrinks = CoolDrinksList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 238, 227),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
            homeAppBar(),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Color.fromARGB(255, 37, 0, 100),
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Шукати тут...',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          prefixIcon: const Icon(Icons.search, size: 18),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),

                      ),
                    ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(

                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 37, 0, 100),
                  ),
                  child: const Icon(Icons.tune, color: Colors.white, size: 16),

                ),
              ],
            ),
            const SizedBox(height: 15,),
            TabBar(

              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelPadding: const EdgeInsets.only(right: 10),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs: [
                createTabBar(Icons.local_bar, "Напої"),
                createTabBar(Icons.fastfood, 'Їжа'),
                createTabBar(Icons.favorite, 'Ліки'),
                createTabBar(Icons.games, 'Геймінг'),
              ],
            ),
            Expanded(child: TabBarView(
              controller: _tabController,
              children: [
                coolDrinksResults(),
                Center(
                  child: Text('Напої'),),
                Center(
                  child: Text('Їжа'),),
                Center(
                  child: Text('Ліки'),),
                Center(
                  child: Text('Геймінг'),),
              ],
            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget coolDrinksResults() => Column(
    children: [
      const SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Результати пошуку',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          ),
          Text('Усі товари',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 37, 0, 100),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8,),
      Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 8),
            itemCount: coolDrinks.length,
            itemBuilder: (context, index){
            final drinks = coolDrinks[index];
                return Container(
                  //color: Colors.yellow,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          ClipPath(
                            clipper: CustomClipPath(
                            ),
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    drinks.isFavorite = !drinks.isFavorite;
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  radius: 10,
                                  child: drinks.isFavorite ? const Icon(Icons.favorite, color: Colors.red,
                                  size: 12) : const Icon(Icons.favorite_border, color: Color.fromARGB(255, 37, 0, 100),
                                      size: 12) ,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6,),
                          Text(
                          drinks.name,
                            style: const TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                          Text(
                            "Пляшка: ${drinks.volume}",
                            style: const TextStyle(
                                fontSize: 8.4,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            "${drinks.price}\ грн",
                            style: const TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 37, 0, 100),
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 55,
                        top: 0,
                        child: GestureDetector(
                          onTap: (){
                            //Click on image to details page
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CoolDrinksDetails(drinks: drinks,)),
                            );
                          },
                          child: Image.asset(
                            "assets/${drinks.image}",
                            height: 160,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
            },
          ),
      ),
    ],
  );

  Widget createTabBar(IconData icon,String text) => Container(
    height: 32,
    width: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
         Icon(
          icon,
           color: Color.fromARGB(255, 37, 0, 100),
           size: 16,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: Color.fromARGB(255, 37, 0, 100),
          ),
        ),
      ],
    ),
  );

  Widget homeAppBar() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              //profile image
              image: const DecorationImage(
                  image: AssetImage(
                    'assets/profile2.jpg'
                  ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Вітаємо",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Степан Бандера",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
      GestureDetector(
          onTap: (){
            //NAVIGATOR TO CART PAGE
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
          child: const Icon(Icons.shopping_cart_outlined))
    ],
  );
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(30, 0);//start paint
    path.quadraticBezierTo(20, 0, 15, 10);//(middle point, end point)
    path.lineTo(0, height - 20); //start paint
    path.quadraticBezierTo(2, height, 25, height); //(middle point, end point)

    path.lineTo(width - 25, height); //start paint
    path.quadraticBezierTo(width - 2, height, width, height - 20); //(middle point, end point)

    path.lineTo(width - 15, 10); //start paint
    path.quadraticBezierTo(width - 20, 0, width - 30, 0); //(middle point, end point)


    path.close();

    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
