import 'package:flutter/material.dart';
import '../../widgets/map_picker.dart';

class PublishLostFoundPage extends StatefulWidget {
  const PublishLostFoundPage({super.key});

  @override
  State<PublishLostFoundPage> createState() => _PublishLostFoundPageState();
}

class _PublishLostFoundPageState extends State<PublishLostFoundPage> {
  double? _latitude;
  double? _longitude;
  String? _address;

  Future<void> _openMapPicker() async {
    final result = await Navigator.of(context).push<MapPickerResult>(
      MaterialPageRoute(
        builder: (_) => MapPickerPage(
          initialLat: _latitude,
          initialLng: _longitude,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        _latitude = result.latitude;
        _longitude = result.longitude;
        _address = result.address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('发布信息')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 地图选点入口
          _buildLocationPicker(),
          // 其余表单项由 Task C8 完成
        ],
      ),
    );
  }

  Widget _buildLocationPicker() {
    return Card(
      child: InkWell(
        onTap: _openMapPicker,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: _address != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('物品位置', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(_address!, style: const TextStyle(fontSize: 14)),
                          Text(
                            '$_latitude, $_longitude',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      )
                    : const Text('点击选择物品位置（可选）', style: TextStyle(color: Colors.grey)),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
