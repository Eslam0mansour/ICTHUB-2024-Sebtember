import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthub_2024_9/features/counter/cubit/counter_cubit.dart';
import 'package:icthub_2024_9/features/counter/ui/screens/counter/counter_screen.dart';
import 'package:icthub_2024_9/features/home/cubit/products_cubit.dart';
import 'package:icthub_2024_9/features/home/ui/screens/home_screen.dart';
import 'package:icthub_2024_9/features/more/cubit/profile_cubit.dart';
import 'package:icthub_2024_9/features/more/ui/screens/more_screen.dart';

class HomeNavScreen extends StatefulWidget {
  const HomeNavScreen({super.key});

  @override
  State<HomeNavScreen> createState() => _HomeNavScreenState();
}

class _HomeNavScreenState extends State<HomeNavScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const CounterScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit()..getUserData(),
        ),
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit()..getProductsFormFirebase(),
        ),
      ],
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (i) {
            setState(() {
              currentIndex = i;
            });
          },
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
            BottomNavigationBarItem(label: 'Counter', icon: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
