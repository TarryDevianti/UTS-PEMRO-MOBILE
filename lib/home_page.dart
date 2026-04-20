import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> data = [];

  void loadData() async {
    data = await DBHelper.getData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void hapus(int id) async {
    await DBHelper.delete(id);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistem Penggajian"),
        backgroundColor: Colors.blue,
      ),
      body: data.isEmpty
          ? const Center(child: Text("Belum ada data"))
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(data[index]['nama']),
                    subtitle: Text(data[index]['jabatan']),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rp ${data[index]['total_gaji']}",
                          style: const TextStyle(color: Colors.green),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        FormPage(data: data[index]),
                                  ),
                                );
                                loadData();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  hapus(data[index]['id']),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormPage()),
          );
          loadData();
        },
      ),
    );
  }
}