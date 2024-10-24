import 'package:app/productos/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Asegúrate de importar el servicio

class DetalleProductoPage extends StatelessWidget {
  final Map<String, dynamic> producto;
  final ProductoService productoService = Get.find<ProductoService>();

  DetalleProductoPage({
    required this.producto,
  });

  Color morado = Color(0xFF09184D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          producto['NAME'],
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: morado,
      iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFF09184D),
                  child: Icon(
                    Icons.menu,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                // Nombre centrado
                Text(
                  producto['NAME'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Centrar el texto
                ),
                const SizedBox(height: 5),
                Text(
                  '\$${producto['PRICE']}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                _buildDetailRow(Icons.shopping_cart, 'ID del producto', producto['ID'].toString()), // Conversión a String
                const SizedBox(height: 10),
                _buildDetailRow(Icons.description, 'Descripción', producto['DESCRIPTION']),
                const SizedBox(height: 10),
                _buildDetailRow(Icons.category, 'Categoría', producto['CATEGORY_ID'].toString()), // Conversión a String
                const SizedBox(height: 10),
                _buildDetailRow(Icons.account_box, 'Proveedor', producto['SUPPLIER_ID'].toString()), // Conversión a String
                const SizedBox(height: 10),
                _buildDetailRow(Icons.shopping_cart, 'Cantidad', producto['QUANTITY'].toString()), // Conversión a String
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showEditProductDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: morado,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Editar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await productoService.DeleteProduct(context, producto['ID']);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Eliminar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) { // Cambiar a String
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: morado),
        const SizedBox(width: 10),
        Expanded( // Permitir que el texto se ajuste y ocupe el espacio restante
          child: Text(
            '$label: $value',
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis, // Manejo de texto que excede
            maxLines: 3, // Limitar a 3 líneas
          ),
        ),
      ],
    );
  }

  void _showEditProductDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String name = producto['NAME'];
    double price = producto['PRICE'].toDouble(); // Cambiar a double
    String description = producto['DESCRIPTION'];
    String quantity = producto['QUANTITY'].toString(); // Conversión a String
    String categoryId = producto['CATEGORY_ID'].toString(); // Conversión a String
    String supplierId = producto['SUPPLIER_ID'].toString(); // Conversión a String

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Producto'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: name,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    onSaved: (value) => name = value ?? '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el nombre';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: price.toString(), // Conversión a String
                    decoration: const InputDecoration(labelText: 'Precio'),
                    onSaved: (value) => price = double.tryParse(value ?? '0') ?? 0.0, // Guardar como double
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el precio';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: description,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                    onSaved: (value) => description = value ?? '',
                  ),
                  TextFormField(
                    initialValue: quantity, // Ya es String
                    decoration: const InputDecoration(labelText: 'Cantidad'),
                    onSaved: (value) => quantity = value ?? '',
                  ),
                  TextFormField(
                    initialValue: categoryId, // Ya es String
                    decoration: const InputDecoration(labelText: 'Categoría ID'),
                    onSaved: (value) => categoryId = value ?? '',
                  ),
                  TextFormField(
                    initialValue: supplierId, // Ya es String
                    decoration: const InputDecoration(labelText: 'Proveedor ID'),
                    onSaved: (value) => supplierId = value ?? '',
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Actualizar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _updateProduct(
                    context,
                    producto['ID'].toString(),
                    name,
                    price.toInt(),
                    description,
                    int.tryParse(quantity),
                    int.tryParse(categoryId),
                    int.tryParse(supplierId),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _updateProduct(BuildContext context, String id, String name, int price, String description, int? quantity, int? categoryId, int? supplierId) {
    // Lógica para actualizar el producto en tu servicio
    productoService.updateProduct({
      'name': name,
      'price': price.toString(),
      'description': description,
      'quantity': quantity.toString(),
      'categoryId': categoryId.toString(),
      'supplierId': supplierId.toString(),
    }, id).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto actualizado exitosamente')),
      );
      // Aquí podrías actualizar la UI o hacer algo más después de la actualización
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar el producto')),
      );
    });
  }
}
