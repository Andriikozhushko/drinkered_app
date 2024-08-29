import 'package:flutter/material.dart';
import 'package:task1_shop/home_page.dart';
import 'database/db.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Db database = Db();
  List<Map> coolDrinksList = [];

  @override
  void initState() {
    super.initState();
    getCoolDrinksData();
  }

  void getCoolDrinksData() async {
    try {
      await database.open();
      List<Map> result = await database.db!.rawQuery("SELECT * FROM drinks");
      setState(() {
        coolDrinksList = result;
      });
      print(coolDrinksList);
    } catch (e) {
      print("Error loading cool drinks data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            cartAppBar(),
            Expanded(
              child: Container(
                width: double.infinity,
                //color: Colors.yellow,
                child: ListView.builder(
                  itemCount: coolDrinksList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(coolDrinksList[index]['name']), // Пример текстового содержимого
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cartAppBar() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
        child: const Icon(
          Icons.arrow_back,
          size: 20,
        ),
      ),
      const Text(
        "Мiй Кошик",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(
        width: 20,
      ),
    ],
  );
}
