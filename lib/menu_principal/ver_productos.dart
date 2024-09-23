import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductoService extends GetxController {
  final RxList<Map<String, dynamic>> _productos = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get productos => _productos;

  Future<void> obtenerProductos() async {
    try {
<<<<<<< Updated upstream:lib/menu_principal/ver_productos.dart
      const url = 'http://microtech.icu:6969/allProducts';
=======
      const url = 'http://microtech.icu:2007/products/allProducts';
>>>>>>> Stashed changes:lib/productos/all_products.dart
      final response = await http.get(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _productos.clear();
        data.forEach((producto) {
          producto['IMAGE'] =
<<<<<<< Updated upstream:lib/menu_principal/ver_productos.dart
              'http://microtech.icu:6969/product/${producto['IMAGE']}';
          _productos.add(Map<String, dynamic>.from(producto));
=======
              'http://microtech.icu:2007/product/${producto['IMAGE']}';
          productos.add(Map<String, dynamic>.from(producto));
>>>>>>> Stashed changes:lib/productos/all_products.dart
        });
      } else {
        Get.snackbar('Error', 'No se pudieron cargar los productos.');
      }
    } catch (e) {
      print(e);
      Get.snackbar(
          'Error', 'Ocurrió un error al intentar cargar los productos.');
    }
  }

  Future<void> DeleteProduct(BuildContext context, int codigoProducto) async {
    try {
<<<<<<< Updated upstream:lib/menu_principal/ver_productos.dart
      final url = 'http://microtech.icu:6969/product/$codigoProducto';
=======
      final url = 'http://microtech.icu:2007/products/delete/$codigoProducto';
>>>>>>> Stashed changes:lib/productos/all_products.dart
      final response = await http.delete(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Eliminar el producto de la lista localmente
        _productos.removeWhere((producto) => producto['ID'] == codigoProducto);
        Get.snackbar('Producto Eliminado', 'Producto eliminado correctamente.');
      } else {
        Get.snackbar('Error', 'No se pudo eliminar el producto.');
      }
    } catch (e) {
      print('Error occurred: $e');
      Get.snackbar(
          'Error', 'Ocurrió un error al intentar eliminar el producto.');
    }
  }
}

class VerProductosPage extends StatelessWidget {
  final ProductoService carritoService = Get.put(ProductoService());

  @override
  Widget build(BuildContext context) {
    carritoService.obtenerProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: Obx(() {
        if (carritoService.productos.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: carritoService.productos.length,
          itemBuilder: (context, index) {
            final producto = carritoService.productos[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading:
                    Image.network(producto['IMAGE'], width: 50, height: 50),
                title: Text(producto['NAME']),
                subtitle: Text('Precio: \$${producto['PRICE'].toString()}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await carritoService.DeleteProduct(context, producto['ID']);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
