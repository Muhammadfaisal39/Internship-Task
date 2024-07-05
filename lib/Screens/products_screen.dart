import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/Services/Components/results_found_row.dart';
import 'package:internship_task/Services/Product_Services/ProductsModel.dart';
import 'package:internship_task/Services/Components/rating_reusable_row.dart';
import 'package:internship_task/Services/Product_Services/products_list_data.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController searchController = TextEditingController();
  ProductListData productListData = ProductListData();
  List<Product>? allProducts;
  List<Product>? filteredProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    var productsData = await productListData.getProductsData();
    setState(() {
      allProducts = productsData.products;
      filteredProducts = allProducts;
    });
  }

  void _filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = allProducts;
    } else {
      filteredProducts = allProducts
          ?.where((product) =>
          product.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

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
                "Products",
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
                _filterProducts(value);
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
            ResultsFound(number: filteredProducts?.length.toString() ?? "0"),
            Expanded(
              child: allProducts == null
                  ? const Center(child: CircularProgressIndicator())
                  : (filteredProducts == null || filteredProducts!.isEmpty)
                  ? const Center(child: Text('No products found'))
                  : ListView.builder(
                itemCount: filteredProducts!.length,
                itemBuilder: (context, index) {
                  var product = filteredProducts![index];
                  return Container(
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
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
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
