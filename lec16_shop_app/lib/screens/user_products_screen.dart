import 'package:flutter/material.dart';
import 'package:lec16_shop/providers/product.dart';
import 'package:provider/provider.dart';

import 'package:lec16_shop/providers/products.dart';
import 'package:lec16_shop/widgets/user_product_item.dart';
import 'package:lec16_shop/widgets/app_drawer.dart';
import 'package:lec16_shop/screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<List<Product>?> _refreshProducts(BuildContext context) async {
    return await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(filterByUser: true);
  }

  @override
  Widget build(BuildContext context) {
    print('user_product_screen build called');
    //final productsData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<Product>?>(
          future: _refreshProducts(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Consumer<Products>(
                        builder: (context, productsData, child) =>
                            ListView.builder(
                          itemCount: productsData.items!.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              UserProductItem(
                                productsData.items![i].id,
                                productsData.items![i].title,
                                productsData.items![i].imageUrl,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
