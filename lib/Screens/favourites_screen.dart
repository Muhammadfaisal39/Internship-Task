import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/Services/add_to_favourite_services/favourite_provider.dart';
import 'package:internship_task/Screens/DetailSrcreens/product_details_screen.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Favourites",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  fontFamily: "Playfair Display",
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: searchController,
              onChanged: (value) {
                Provider.of<FavoritesProvider>(context, listen: false).searchFavorites(value);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                prefixIconColor: Colors.black,
                hintText: "Search Product",
                contentPadding: const EdgeInsets.all(15),
                hintStyle: const TextStyle(color: Colors.grey),
                iconColor: Colors.black,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: InputBorder.none,
                enabled: true,
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Consumer<FavoritesProvider>(
                builder: (context, favoritesProvider, child) {
                  final favorites = favoritesProvider.favorites;

                  if (favorites.isEmpty) {
                    return const Center(child: Text('No favorites added.'));
                  }

                  return ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final product = favorites[index];
                      return ListTile(
                        title: Text(
                          product.title ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                        leading: Image.network(
                          product.images![0],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        trailing: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$${product.price.toString()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                fontSize: 11,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  product.rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                const Icon(Icons.star,color: Colors.yellow,size: 15,),
                                const Icon(Icons.star,color: Colors.yellow,size: 15,),
                                const Icon(Icons.star,color: Colors.yellow,size: 15,),
                                const Icon(Icons.star,color: Colors.yellow,size: 15,),
                                const Icon(Icons.star,color: Colors.yellow,size: 15,),
                              ],
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(product: product),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
