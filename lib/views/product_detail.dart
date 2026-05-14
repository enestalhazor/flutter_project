import 'package:flutter/material.dart';
import 'package:flutter_project/models/products_model.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final Set<int> cartIds;
  const ProductDetail({
    super.key,
    required this.product,
    required this.cartIds,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Back", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.product.image,
            height: 350,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 6),

                Text(
                  widget.product.tagline,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                SizedBox(height: 12),

                Text(
                  widget.product.price,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                Divider(height: 40, thickness: 0.5),

                Text(
                  widget.product.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 4),

                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      widget.cartIds.add(widget.product.id);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "✓ Added to cart",
                          style: TextStyle(color: Colors.green),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.black,
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: Text("Add to Cart"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
