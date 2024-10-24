// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:app/suppliers/suppliersService.dart';
import 'suppliersCard.dart';

class ListaSuppliers extends StatefulWidget {
  const ListaSuppliers({super.key});

  @override
  State<ListaSuppliers> createState() => _ListaSuppliersState();
}

class _ListaSuppliersState extends State<ListaSuppliers> {
  Future<List<SuppliersCard>>?
      _futureSuppliers; // Cambia aquí el tipo a SuppliersCard
  List<SuppliersCard> _allSuppliers = []; // Lista completa de proveedores
  List<SuppliersCard> _filteredSuppliers = []; // Lista filtrada
  String _searchTerm = ''; // Término de búsqueda

  @override
  void initState() {
    super.initState();
    loadSuppliers(); // Cargar proveedores al iniciar
  }

  void loadSuppliers() {
    setState(() {
      _futureSuppliers = SupplierService.loadSuppliers(
        onDelete: () {
          loadSuppliers(); // Recargar la lista después de eliminar
        },
      ).then((suppliers) {
        _allSuppliers = suppliers
            .cast<SuppliersCard>(); // Guardar la lista completa de proveedores
        _filteredSuppliers = suppliers.cast<
            SuppliersCard>(); // Inicialmente, la lista filtrada es igual a la lista completa
        return suppliers.cast<
            SuppliersCard>(); // Retornar la lista de proveedores como SuppliersCard
      });
    });
  }

  void _filterSuppliers(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm.toLowerCase(); // Convertir a minúsculas
      _filteredSuppliers = _allSuppliers.where((supplier) {
        // Asegúrate de que SuppliersCard tenga propiedades accesibles
        return supplier.name.toLowerCase().contains(_searchTerm) ||
            supplier.lastname.toLowerCase().contains(_searchTerm);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos los proveedores',
            style: TextStyle(color: Color(0xFFFAFAFA))),
        backgroundColor: const Color(0xFF09184D),
        centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<SuppliersCard>>(
        future: _futureSuppliers,
        builder: (BuildContext context,
            AsyncSnapshot<List<SuppliersCard>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Guardar la lista completa de proveedores
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: _filterSuppliers,
                    decoration: InputDecoration(
                      labelText: 'Buscar proveedores',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                      children: _filteredSuppliers), // Usar la lista filtrada
                ),
              ],
            );
          } else {
            return const Center(child: Text("No hay datos disponibles."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddSupplierDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddSupplierDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String name = '';
    String phone = '';
    String email = '';
    String city = '';
    String brand = '';
    String lastname = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar nuevo proveedor'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
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
                    decoration: const InputDecoration(labelText: 'Apellido'),
                    onSaved: (value) => lastname = value ?? '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el apellido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Teléfono'),
                    onSaved: (value) => phone = value ?? '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el teléfono';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Correo'),
                    onSaved: (value) => email = value ?? '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el correo';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Ciudad'),
                    onSaved: (value) => city = value ?? '',
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Marca'),
                    onSaved: (value) => brand = value ?? '',
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
              child: const Text('Agregar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _addSupplier(
                      context, name, phone, email, city, brand, lastname);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _addSupplier(BuildContext context, String name, String phone,
      String email, String city, String brand, String lastname) {
    SupplierService.addSupplier({
      'name': name,
      'phone': phone,
      'email': email,
      'city': city,
      'brand': brand,
      'lastname': lastname,
    }).then((_) {
      // After adding a supplier, reload the list
      loadSuppliers();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proveedor agregado exitosamente')),
    );
  }
}
