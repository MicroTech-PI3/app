import 'package:flutter/material.dart';
import 'package:app/suppliers/suppliersService.dart';

class Supplierssingle extends StatefulWidget {
  final String id;
  String name;
  String lastname;
  String phone;
  String email;
  String city;
  String brand;
  final Function callback;

  Supplierssingle({
    required this.id,
    required this.name,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.city,
    required this.brand,
    required this.callback,
    super.key,
  });

  @override
  State<Supplierssingle> createState() => _SupplierssingleState();
}

class _SupplierssingleState extends State<Supplierssingle> {
  Color morado = Color(0xFF09184D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name} ${widget.lastname}', style: TextStyle(color: Color(0xFFFAFAFA))),
        backgroundColor: morado,
        centerTitle: true,
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
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${widget.name} ${widget.lastname}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.brand,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.phone, color: morado),
                    const SizedBox(width: 10),
                    Text(widget.phone),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.email, color: morado),
                    const SizedBox(width: 10),
                    Text(widget.email),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_city, color: morado),
                    const SizedBox(width: 10),
                    Text(widget.city),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: morado,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                      style: TextStyle(color: Colors.white), 'Volver'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEditSupplierDialog(context);
        },
        backgroundColor: morado,
        child: const Icon(Icons.edit,
                    color: Colors.white),
      ),
    );
  }

  void _showEditSupplierDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String name = widget.name;
    String phone = widget.phone;
    String email = widget.email;
    String city = widget.city;
    String brand = widget.brand;
    String lastname = widget.lastname;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar proveedor'),
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
                    initialValue: lastname,
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
                    initialValue: phone,
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
                    initialValue: email,
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
                    initialValue: city,
                    decoration: const InputDecoration(labelText: 'Ciudad'),
                    onSaved: (value) => city = value ?? '',
                  ),
                  TextFormField(
                    initialValue: brand,
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
              child: const Text('Actualizar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _updateSupplier(context, widget.id, name, phone, email, city,
                      brand, lastname);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _updateSupplier(BuildContext context, String id, String name,
      String phone, String email, String city, String brand, String lastname) {
    SupplierService.updateSupplier({
      'name': name,
      'phone': phone,
      'email': email,
      'city': city,
      'brand': brand,
      'lastname': lastname,
    }, id)
        .then((_) {
      setState(() {
        widget.callback();
        widget.name = name;
        widget.lastname = lastname;
        widget.phone = phone;
        widget.email = email;
        widget.city = city;
        widget.brand = brand;
      });
      // After updating a supplier, you can show a confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proveedor actualizado exitosamente')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar el proveedor')),
      );
    });
  }
}
