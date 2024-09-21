import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icthub_2024_9/features/home/data/data_source/products_data_source.dart';
import 'package:icthub_2024_9/features/home/data/data_source/upload_products_firebase.dart';
import 'package:icthub_2024_9/features/login/ui/screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   ProductsDataSource.getProductsData().then((v) {
  //     setState(() {});
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Hello ${FirebaseAuth.instance.currentUser?.email ?? 'not found'}'), // 'Home
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: FutureBuilder(
          future: UploadProductsFirebase().getProductsFormFirbase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data?.length == 0
                  ? Center(
                      child: Text('Not have Data'),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                            snapshot.data?[index].image ?? '',
                            width: 50,
                            height: 100,
                          ),
                          title: Text(
                            snapshot.data?[index].title ?? 'No Data',
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            snapshot.data?[index].description ??
                                "No description",
                            maxLines: 2,
                          ),
                          trailing: Text('\$${snapshot.data?[index].price}'),
                        );
                      },
                    );
            }
            return Center(
              child: Text('Failed to fetch data'),
            );
          },
          // body: ProductsDataSource.isLoading
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     : ProductsDataSource.isError
          //         ? const Center(
          //             child: Text('Failed to fetch data'),
          //           )
          //         : ProductsDataSource.listOfProducts.isEmpty
          //             ? const Center(
          //                 child: Text('No data found in database'),
          //               )
          //             : ListView.builder(
          //                 itemCount: ProductsDataSource.listOfProducts.length,
          //                 itemBuilder: (context, index) {
          // return ListTile(
          //   leading: Image.network(
          //     ProductsDataSource.listOfProducts[index].image ??
          //         '',
          //     width: 50,
          //     height: 100,
          //   ),
          //   title: Text(
          //     ProductsDataSource.listOfProducts[index].title ??
          //         'No title',
          //     maxLines: 1,
          //   ),
          //   subtitle: Text(
          //     ProductsDataSource
          //             .listOfProducts[index].description ??
          //         'No description',
          //     maxLines: 2,
          //   ),
          //   trailing: Text(
          //       '\$${ProductsDataSource.listOfProducts[index].price ?? 0.0}'),
          // );
          //                 },
          //               ),
        ));
  }
}
