import 'package:flutter/material.dart';
import 'db_helper.dart';

class FormPage extends StatefulWidget {
  final Map<String, dynamic>? data;
  const FormPage({super.key, this.data});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nama = TextEditingController();
  final jabatan = TextEditingController();
  final gaji = TextEditingController();
  final tunjangan = TextEditingController();
  final potongan = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      nama.text = widget.data!['nama'];
      jabatan.text = widget.data!['jabatan'];
      gaji.text = widget.data!['gaji_pokok'].toString();
      tunjangan.text = widget.data!['tunjangan'].toString();
      potongan.text = widget.data!['potongan'].toString();
    }
  }

  void simpan() async {
    int gajiPokok = int.tryParse(gaji.text) ?? 0;
    int tun = int.tryParse(tunjangan.text) ?? 0;
    int pot = int.tryParse(potongan.text) ?? 0;

    int total = gajiPokok + tun - pot;

    var data = {
      'nama': nama.text,
      'jabatan': jabatan.text,
      'gaji_pokok': gajiPokok,
      'tunjangan': tun,
      'potongan': pot,
      'total_gaji': total,
    };

    if (widget.data == null) {
      await DBHelper.insert(data);
    } else {
      await DBHelper.update(widget.data!['id'], data);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Karyawan")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nama, decoration: const InputDecoration(labelText: "Nama")),
            TextField(controller: jabatan, decoration: const InputDecoration(labelText: "Jabatan")),
            TextField(controller: gaji, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Gaji Pokok")),
            TextField(controller: tunjangan, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Tunjangan")),
            TextField(controller: potongan, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Potongan")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: simpan, child: const Text("Simpan"))
          ],
        ),
      ),
    );
  }
}