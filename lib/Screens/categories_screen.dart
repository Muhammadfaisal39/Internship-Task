import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/Services/Components/results_found_row.dart';
import 'package:internship_task/Services/categories_services/CaategoriesModel.dart';
import 'package:internship_task/Services/categories_services/CategoriesData.dart';
import 'package:internship_task/Screens/DetailSrcreens/category_products_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController searchController = TextEditingController();
  late Future<List<Category>> futureCategories;
  List<Category> allCategories = [];
  List<Category> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  void filterCategories(String query) {
    if (query.isEmpty) {
      filteredCategories = allCategories;
    } else {
      filteredCategories = allCategories.where((category) {
        return category.name.toLowerCase().contains(query.toLowerCase());
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
              child: Text(
                "Categories",
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
                filterCategories(value);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                prefixIconColor: Colors.black,
                hintText: "Search Category",
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
            ResultsFound(number: filteredCategories.length.toString()),
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: futureCategories,
                builder: (context, categorySnapshot) {
                  if (categorySnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (categorySnapshot.hasError) {
                    return Center(child: Text('Error: ${categorySnapshot.error}'));
                  } else if (!categorySnapshot.hasData || categorySnapshot.data!.isEmpty) {
                    return const Center(child: Text('No categories available'));
                  } else {
                    allCategories = categorySnapshot.data!;
                    if (searchController.text.isEmpty) {
                      filteredCategories = allCategories;
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 0.75, // Adjust based on your design
                      ),
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        var category = filteredCategories[index];
                        var categoryName = category.name;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryProductsScreen(
                                  category: category,
                                  categoryName: categoryName,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 150.h, // Adjust based on your design
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                    image: NetworkImage('https://via.placeholder.com/150'), // Replace with actual image URL
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                category.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  fontFamily: "Playfair Display",
                                  color: Colors.black,
                                ),
                              ),
                            ],
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
