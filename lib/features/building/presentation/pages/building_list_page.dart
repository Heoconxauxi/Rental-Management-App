import 'package:flutter/material.dart';
import 'building_form_page.dart';

class Building {
  final String id;
  final String name;
  final String address;

  Building({
    required this.id,
    required this.name,
    required this.address,
  });
}

class BuildingListPage extends StatefulWidget {
  const BuildingListPage({super.key});

  @override
  State<BuildingListPage> createState() => _BuildingListPageState();
}

class _BuildingListPageState extends State<BuildingListPage> {
  // Dữ liệu mẫu, giả sử lấy từ repo/firestore sau này
  final List<Building> _buildings = [
    Building(id: '1', name: 'Cơ sở A', address: '123 Đường ABC'),
    Building(id: '2', name: 'Cơ sở B', address: '456 Đường DEF'),
  ];

  void _addBuilding() async {
    // Mở trang form thêm mới, sau khi pop sẽ refresh list (giả lập)
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const BuildingFormPage()),
    );

    // Giả sử result trả về một Building mới, ở đây tạm tạo thêm
    if (result != null && result is Building) {
      setState(() {
        _buildings.add(result);
      });
    }
  }

  void _editBuilding(Building building) async {
    // Mở form sửa với dữ liệu hiện tại
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BuildingFormPage(
          initialName: building.name,
          initialAddress: building.address,
          initialDescription: '', // giả sử chưa có
        ),
      ),
    );

    // Giả sử result trả về Building đã sửa
    if (result != null && result is Building) {
      setState(() {
        final index = _buildings.indexWhere((b) => b.id == building.id);
        if (index != -1) {
          _buildings[index] = result;
        }
      });
    }
  }

  void _deleteBuilding(String id) {
    setState(() {
      _buildings.removeWhere((b) => b.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách Cơ sở'),
      ),
      body: _buildings.isEmpty
          ? const Center(child: Text('Chưa có cơ sở nào'))
          : ListView.builder(
              itemCount: _buildings.length,
              itemBuilder: (context, index) {
                final building = _buildings[index];
                return ListTile(
                  title: Text(building.name),
                  subtitle: Text(building.address),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editBuilding(building),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteBuilding(building.id),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Mở trang chi tiết nếu cần (phòng trọ trong cơ sở)
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBuilding,
        child: const Icon(Icons.add),
      ),
    );
  }
}
