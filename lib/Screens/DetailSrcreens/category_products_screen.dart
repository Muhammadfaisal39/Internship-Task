import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/Services/Components/results_found_row.dart';
import 'package:internship_task/Services/Product_Services/ProductsModel.dart';
import 'package:internship_task/Services/Components/rating_reusable_row.dart';
import 'package:internship_task/Services/categories_services/CaategoriesModel.dart';
import 'package:internship_task/Screens/DetailSrcreens/product_details_screen.dart';
import 'package:internship_task/Services/Product_Services/products_list_data.dart'; // Import the new screen

class CategoryProductsScreen extends StatefulWidget {
  final Category category;
  final String categoryName;

  const CategoryProductsScreen(
      {super.key, required this.category, required this.categoryName});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  late Future<ProductsModel> futureProducts;
  ProductListData productListData = ProductListData();
  TextEditingController searchController = TextEditingController();
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    futureProducts = productListData.getProductsData();
  }

  void filterProducts(String query, List<Product> products) {
    if (query.isEmpty) {
      filteredProducts = products;
    } else {
      filteredProducts = products.where((product) {
        return product.title!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
        child: Column(
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
                    widget.categoryName,
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
            TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filterProducts(value, filteredProducts);
                });
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
            ResultsFound(number: filteredProducts.length.toString()),
            Expanded(
              child: FutureBuilder<ProductsModel>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No products available'));
                  } else {
                    List<Product> products = snapshot.data!.products!
                        .where((product) => product.category == widget.category.slug)
                        .toList();

                    if (searchController.text.isEmpty) {
                      filteredProducts = products;
                    }

                    return ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        var product = filteredProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  product: product,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 10.h),
                            padding: EdgeInsets.all(15.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 250.h,
                                  child: Image.network(
                                    product.images![0],
                                    height: 250.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        product.title ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins",
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '\$${product.price}',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                RattingRow(rating: product.rating.toString()),
                                SizedBox(height: 5.h),
                                Text(
                                  "By ${product.brand}",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "In ${product.category}",
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
