import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'cart_page.dart';
import 'database/db.dart';
import 'model/cool_drinks.dart';

class CoolDrinksDetails extends StatefulWidget {
  final CoolDrinks drinks;
  const CoolDrinksDetails({Key? key, required this.drinks}) : super(key: key);

  @override
  State<CoolDrinksDetails> createState() => _CoolDrinksDetailsState();
}

class _CoolDrinksDetailsState extends State<CoolDrinksDetails> {

  Db database = Db();
  @override
  void initState() {
    database.open();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: coolDrinksBottomSheet(),
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailsAppBar(),
            const SizedBox(height: 10,),
            Container(
              height: 320,
              width: double.infinity,
              // color: Colors.yellow,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipPath(
                      clipper: CustomPath(),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              widget.drinks.color, Colors.black
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      "assets/${widget.drinks.image}",
                      height: 310,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.drinks.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Пляшка: ${widget.drinks.volume}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                RatingBar.builder(
                  onRatingUpdate: (value) {},
                  itemCount: 5,
                  itemSize: 22,
                  allowHalfRating: true,
                  initialRating: widget.drinks.rating,
                  unratedColor: Colors.grey.shade400,
                  itemBuilder: (context, index) {
                    return const Icon(Icons.star,
                        color: Color.fromARGB(255, 37, 0, 100));
                  },
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade700,
              height: 30,
            ),
            const Text(
              'Склад продукту',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Газований солодкий напій - це освіжаючий і спраглий, що приваблює своїм бурхливим ігристим струменем, напій, що здатен розкрити неповторний смаковий букет на перший ковток. Завдяки ідеально збалансованому вмісту цукру і кислоти, він надає чудовий баланс солодощів та освіжаючої кислотності, властивих тільки найкращим газованим напоям. Його аромат здатний пробудити справжні емоції і викликати найприємніші враження. Він стане чудовим спутником на будь-якому святі або просто у повсякденному житті, даруючи насолоду кожному ковтку.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ], // Added closing square bracket for children list
        ),
      ),
    ); // Added closing parenthesis for Scaffold widget
  }

  Widget coolDrinksBottomSheet() => Container(
    height: 100,
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 37, 0, 100),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${widget.drinks.price} грн',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 30,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
            border: Border.all(width: 1.5, color: Colors.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap:() {
                    setState(() {
                      if(widget.drinks.count <= 1){
                        return;
                      }
                      else{
                        widget.drinks.count--;
                      }
                    });
                  } ,
                  child: const Icon(
                    Icons.remove,
                    size: 15,
                    color: Colors.white,
                  )),
              Text(widget.drinks.count.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      widget.drinks.count++;
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    size: 15,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        Container(
          height: 35,
          width: 90,
          child: ElevatedButton(
            onPressed: () async{
              if (database.db != null) {
                await database.db!.rawInsert("INSERT INTO drinks (name, image, volume, price) VALUES (?, ?, ?, ?;",
                    [
                      widget.drinks.name,
                      widget.drinks.image,
                      widget.drinks.volume,
                      widget.drinks.price,
                    ]);
              } else {
                // Обработка ситуации, когда database.db равен null
              }
              //popup
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.white,
                    content: Text(
                      "Напій додано до кошику",
                      style: TextStyle(
                        color: Color.fromARGB(255, 37, 0, 100),
                      ),
                    )),
              );
              //navigate
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Кошик",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 37, 0, 100),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget detailsAppBar() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          size: 20,
        ),
      ),
      const Icon(Icons.segment),
    ],
  );
}

class CustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(50, 0); //start paint
    path.quadraticBezierTo(20, 0, 20, 35); //(middle point, end point)
    path.lineTo(0, height - 40); //start paint
    path.quadraticBezierTo(2, height, 50, height); //(middle point, end point)

    path.lineTo(width - 50, height); //start paint
    path.quadraticBezierTo(
        width, height, width, height - 40); //(middle point, end point)

    path.lineTo(width - 20, 35); //start paint
    path.quadraticBezierTo(
        width - 20, 0, width - 50, 0); //(middle point, end point)

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
