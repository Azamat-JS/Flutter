import 'package:ecommerce_flutter/components/shoe_tile.dart';
import 'package:ecommerce_flutter/models/cart.dart';
import 'package:ecommerce_flutter/models/shoe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  void addShoeToCart(Shoe shoe) {
    Provider.of<Cart>(context, listen: false).addItemToCart(shoe);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Successfully added!',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Check your cart!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Search', style: TextStyle(color: Colors.grey[500])),
              Icon(Icons.search, color: Colors.grey[500]),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Text(
            'Everyone flies.. some fly longer than others',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'Hot Picks 🔥',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Selector<Cart, List<Shoe>>(
            selector: (_, cart) => cart.getShoeList(),
            builder: (context, shoeList, child) {
              return ListView.builder(
                itemCount: shoeList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final shoe = shoeList[index];
                  return ShoeTile(shoe: shoe, onTap: () => addShoeToCart(shoe));
                },
              );
            },
          ),
        ),

        const Padding(
          padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
          child: Divider(color: Colors.white),
        ),
      ],
    );
  }
}
