import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_management_app/features/room/domain/entities/room.dart';
import 'package:rental_management_app/features/room/presentation/providers/room_provider.dart';

class RoomFormPage extends ConsumerStatefulWidget {
  final String buildingId;
  final Room? roomToEdit;

  const RoomFormPage({super.key, required this.buildingId, this.roomToEdit});

  @override
  ConsumerState<RoomFormPage> createState() => _RoomFormPageState();
}

class _RoomFormPageState extends ConsumerState<RoomFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _roomNumberController;
  late TextEditingController _roomTypeController;
  late TextEditingController _areaController;
  late TextEditingController _priceController;
  late TextEditingController _depositController;
  late TextEditingController _descriptionController;

  bool _wifi = false;
  bool _airCon = false;
  bool _fridge = false;
  bool _washing = false;
  bool _balcony = false;
  bool _toilet = false;
  bool _hotWater = false;

  @override
  void initState() {
    super.initState();
    final roomToEdit = widget.roomToEdit;
    _roomNumberController = TextEditingController(text: roomToEdit?.roomNumber ?? '');
    _roomTypeController = TextEditingController(text: roomToEdit?.roomType ?? '');
    _areaController = TextEditingController(text: (roomToEdit?.area ?? 0.0).toString());
    _priceController = TextEditingController(text: (roomToEdit?.basePrice ?? 0.0).toString());
    _depositController = TextEditingController(text: (roomToEdit?.depositAmount ?? 0.0).toString());
    _descriptionController = TextEditingController(text: roomToEdit?.description ?? '');

    // Prepopulate amenities if editing
    if (roomToEdit != null) {
      _wifi = roomToEdit.amenities.wifi;
      _airCon = roomToEdit.amenities.airConditioner;
      _fridge = roomToEdit.amenities.fridge;
      _washing = roomToEdit.amenities.washingMachine;
      _balcony = roomToEdit.amenities.balcony;
      _toilet = roomToEdit.amenities.privateToilet;
      _hotWater = roomToEdit.amenities.hotWater;
    }
  }

  @override
  void dispose() {
    _roomNumberController.dispose();
    _roomTypeController.dispose();
    _areaController.dispose();
    _priceController.dispose();
    _depositController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveRoom() async {
    if (_formKey.currentState?.validate() ?? false) {
      final repository = ref.read(roomRepositoryProvider);
      final room = Room(
        id: widget.roomToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        buildingId: widget.buildingId,
        roomNumber: _roomNumberController.text,
        roomType: _roomTypeController.text,
        area: double.tryParse(_areaController.text) ?? 0.0,
        basePrice: double.tryParse(_priceController.text) ?? 0.0,
        depositAmount: double.tryParse(_depositController.text) ?? 0.0,
        status: 'Available',
        description: _descriptionController.text,
        amenities: Amenities(
          wifi: _wifi,
          airConditioner: _airCon,
          fridge: _fridge,
          washingMachine: _washing,
          balcony: _balcony,
          privateToilet: _toilet,
          hotWater: _hotWater,
        ),
        maxOccupants: 2,
        floor: 1,
        createdAt: widget.roomToEdit?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        currentTenant: widget.roomToEdit?.currentTenant,
      );

      try {
        if (widget.roomToEdit == null) {
          await repository.createRoom(room);
        } else {
          await repository.updateRoom(room);
        }
        final notifier = ref.read(roomNotifierProvider.notifier);
        await notifier.loadRooms(widget.buildingId);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving room: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.roomToEdit == null ? 'Thêm phòng' : 'Sửa phòng')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _roomNumberController,
                decoration: const InputDecoration(labelText: 'Số phòng'),
                validator: (value) => (value?.isEmpty ?? true) ? 'Vui lòng nhập số phòng' : null,
              ),
              TextFormField(
                controller: _roomTypeController,
                decoration: const InputDecoration(labelText: 'Loại phòng'),
                validator: (value) => (value?.isEmpty ?? true) ? 'Vui lòng nhập loại phòng' : null,
              ),
              TextFormField(
                controller: _areaController,
                decoration: const InputDecoration(labelText: 'Diện tích'),
                keyboardType: TextInputType.number,
                validator: (value) => (value?.isEmpty ?? true) || double.tryParse(value!) == null
                    ? 'Vui lòng nhập diện tích hợp lệ'
                    : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Giá'),
                keyboardType: TextInputType.number,
                validator: (value) => (value?.isEmpty ?? true) || double.tryParse(value!) == null
                    ? 'Vui lòng nhập giá hợp lệ'
                    : null,
              ),
              TextFormField(
                controller: _depositController,
                decoration: const InputDecoration(labelText: 'Tiền cọc'),
                keyboardType: TextInputType.number,
                validator: (value) => (value?.isEmpty ?? true) || double.tryParse(value!) == null
                    ? 'Vui lòng nhập tiền cọc hợp lệ'
                    : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Mô tả'),
              ),
              const SizedBox(height: 16),
              const Text('Tiện nghi:', style: TextStyle(fontWeight: FontWeight.bold)),
              CheckboxListTile(
                value: _wifi,
                onChanged: (v) => setState(() => _wifi = v!),
                title: const Text('Wifi'),
              ),
              CheckboxListTile(
                value: _airCon,
                onChanged: (v) => setState(() => _airCon = v!),
                title: const Text('Máy lạnh'),
              ),
              CheckboxListTile(
                value: _fridge,
                onChanged: (v) => setState(() => _fridge = v!),
                title: const Text('Tủ lạnh'),
              ),
              CheckboxListTile(
                value: _washing,
                onChanged: (v) => setState(() => _washing = v!),
                title: const Text('Máy giặt'),
              ),
              CheckboxListTile(
                value: _balcony,
                onChanged: (v) => setState(() => _balcony = v!),
                title: const Text('Ban công'),
              ),
              CheckboxListTile(
                value: _toilet,
                onChanged: (v) => setState(() => _toilet = v!),
                title: const Text('Toilet riêng'),
              ),
              CheckboxListTile(
                value: _hotWater,
                onChanged: (v) => setState(() => _hotWater = v!),
                title: const Text('Nước nóng'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRoom,
                child: const Text('Lưu phòng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}