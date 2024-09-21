import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthub_2024_9/features/home/cubit/products_states.dart';
import 'package:icthub_2024_9/features/home/data/data_source/products_data_source.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoading());

  final ProductsDataSource _productsDataSource = ProductsDataSource();

  void getProductsFormFirebase() async {
    try {
      final products = await _productsDataSource.getProductsFormFirebase();

      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void getProductsFakeStoreApi() async {
    try {
      final products = await _productsDataSource.getProductsFakeStoreApi();

      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
