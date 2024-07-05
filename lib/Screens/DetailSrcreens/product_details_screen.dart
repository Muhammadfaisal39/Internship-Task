import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/Services/Product_Services/ProductsModel.dart';
import 'package:internship_task/Services/Components/reusable_row.dart';
import 'package:internship_task/Services/add_to_favourite_services/favourite_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    Text(
                      "Product Details",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                        fontFamily: "Playfair Display",
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Image.network(
                product.images![0],
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Product Details:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontSize: 18,
                    ),
                  ),
                  Consumer<FavoritesProvider>(
                    builder: (context, favoritesProvider, child) {
                      final isFavorite = favoritesProvider.isFavorite(product);
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 35,
                          color: isFavorite ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            favoritesProvider.removeFavorite(product);
                          } else {
                            favoritesProvider.addFavorite(product);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ReusableRow(title: "Name", value: product.title ?? ""),
              SizedBox(height: 16.h),
              ReusableRow(title: "Price", value: product.price.toString() ?? ""),
              SizedBox(height: 16.h),
              ReusableRow(title: "Brand", value: product.brand ?? ""),
              SizedBox(height: 16.h),
              Row(
                children: [
                  ReusableRow(title: "Rating", value: product.rating.toString()),
                  SizedBox(width: 10.w,),
                  const Icon(Icons.star,color: Colors.yellow,size: 18,),
                  const Icon(Icons.star,color: Colors.yellow,size: 18,),
                  const Icon(Icons.star,color: Colors.yellow,size: 18,),
                  const Icon(Icons.star,color: Colors.yellow,size: 18,),
                  const Icon(Icons.star,color: Colors.yellow,size: 18,),
                ],
              ),
              SizedBox(height: 16.h),
              ReusableRow(title: "Stock", value: product.stock.toString() ?? ""),
              SizedBox(height: 16.h),
              const Text(
                "Description:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: "Poppins",
                ),
              ),
              Text(
                product.description.toString(),
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16.h),
              const Text(
                "Product Gallery:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 16.h),
              GridView.builder(
                padding: EdgeInsets.only(top: 10.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 1,
                ),
                itemCount: product.images!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Prevents GridView from scrolling independently
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(product.images![index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
