import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthub_2024_9/features/home/cubit/products_cubit.dart';
import 'package:icthub_2024_9/features/home/cubit/products_states.dart';
import 'package:icthub_2024_9/features/login/ui/screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Hello ${FirebaseAuth.instance.currentUser?.email ?? 'not found'}'),
        // 'Home
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
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductsLoaded) {
            return state.products.isEmpty
                ? const Center(
                    child: Text('Not have Data'),
                  )
                : ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                          state.products[index].image ?? '',
                          width: 50,
                          height: 100,
                        ),
                        title: Text(
                          state.products[index].title ?? '',
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          state.products[index].description ?? '',
                          maxLines: 2,
                        ),
                        trailing: Text('\$${state.products[index].price}'),
                      );
                    },
                  );
          } else if (state is ProductsError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Unknown Error'),
            );
          }
        },
      ),
    );
  }
}
