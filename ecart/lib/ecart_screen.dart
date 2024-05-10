import 'package:flutter/material.dart';
import 'package:ecart/ecart_model.dart';
import 'package:ecart/services.dart';
import 'package:ecart/details_screen.dart'; 

class EcartHomeScreen extends StatefulWidget {
  const EcartHomeScreen({Key? key}) : super(key: key);

  @override
  State<EcartHomeScreen> createState() => _EcartHomeScreenState();
}

class _EcartHomeScreenState extends State<EcartHomeScreen> {
  List<ProductElement> products = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    myProducts(); 
  }

  void myProducts() {
    setState(() {
      isLoading = true;
    });
    productsItmes().then((value) {
      setState(() {
        products = value; 
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: const Text("Product App")),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 24,      
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(25),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index]; 
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(productElement: product), 
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 250,
                        // width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29),
                          image: DecorationImage(
                            image: NetworkImage(product.thumbnail), 
                            fit: BoxFit.fill,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 165, 68, 30),
                              offset: Offset(-5, 3),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(146, 0, 0, 0),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(19),
                              bottomRight: Radius.circular(29),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 9),
                                  child: Text(
                                    product.title, 
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 9,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 220, 42, 59),
                              ),
                              Text(
                                product.rating.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              const SizedBox(width: 8,),
                              const Text(
                                "Rs",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 2,),
                              Text(
                                product.price.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
