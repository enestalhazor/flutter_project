import 'package:flutter/material.dart';
import 'package:flutter_project/companents/card.dart';
import 'package:flutter_project/models/products_model.dart';
import 'package:flutter_project/services/api_service.dart';
import 'package:flutter_project/services/local_storage_service.dart';
import 'package:flutter_project/views/cart_screen.dart';
import 'package:flutter_project/views/product_detail.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final LocalStorageService lsservice = LocalStorageService();
  String userName = "";
  String errorMsg = "";
  List<Product> productsLists = [];
  final ApiService apiService = ApiService();
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();
  Set<int> cartIds = {};

  Future<void> loadUserName() async {
    try {
      final data = await lsservice.getData();
      setState(() {
        userName = data;
      });
    } catch (e) {
      setState(() {
        errorMsg = e.toString();
      });
    }
  }

  Future<void> loadProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      final data = await apiService.fetchProducts();

      setState(() {
        productsLists = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMsg = e.toString();
      });
    }
  }

  @override
  void initState() {
    loadUserName();
    loadProducts();
    super.initState();
  }

  void filterProducts(value) {
    // filter products.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome again $userName",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  IconButton(
                    onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(products: productsLists, cartIds: cartIds)))
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),

              SizedBox(height: 20),

              TextField(
                controller: searchController,
                onChanged: filterProducts,
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        itemCount: productsLists.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.60,
                        ),
                        itemBuilder: (context, index) {
                          final product = productsLists[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product: product, cartIds: cartIds)));
                            },
                            child: CustomCard(product: product),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
