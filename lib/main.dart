
import 'package:e_com_app/controllers/cart_controller/cart_bloc.dart';
import 'package:e_com_app/controllers/product_controller/product_bloc.dart';
import 'package:e_com_app/repository/product_repo.dart';
import 'package:e_com_app/views/products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => ProductBloc(ProductRepo()),),
      BlocProvider(create: (context) => CartBloc(),),
    ], child: const MyApp())
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      title: 'Ecommerce',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white
          ),
    
          backgroundColor: Colors.deepPurpleAccent,
          titleTextStyle: TextStyle(color: Colors.white,fontWeight:FontWeight.w800,fontSize: 20)
        )
      ),
      home: const HomeView(),
    );
  }
}
