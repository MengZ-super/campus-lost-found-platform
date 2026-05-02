import 'dart:async';
import 'package:flutter/material.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import '../config/amap_config.dart';
import '../services/amap_service.dart';

/// 地图选点返回结果
class MapPickerResult {
  final double latitude;
  final double longitude;
  final String address;

  const MapPickerResult({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

/// 全屏地图选点页面
///
/// 用法：
/// ```dart
/// final result = await Navigator.push<MapPickerResult>(
///   context,
///   MaterialPageRoute(builder: (_) => const MapPickerPage()),
/// );
/// if (result != null) { /* 使用 result.latitude, result.longitude, result.address */ }
/// ```
class MapPickerPage extends StatefulWidget {
  /// 初始位置（可选，用于编辑时定位到已有坐标）
  final double? initialLat;
  final double? initialLng;

  const MapPickerPage({super.key, this.initialLat, this.initialLng});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  final _amapService = AmapService();
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();

  AMapController? _mapController;

  /// 当前地图中心坐标
  double _currentLat = AmapConfig.defaultLat;
  double _currentLng = AmapConfig.defaultLng;

  /// 当前中心点地址
  String _currentAddress = '正在获取地址...';

  /// 搜索建议
  List<AmapTip> _suggestions = [];

  /// 是否显示搜索建议列表
  bool _showSuggestions = false;

  /// 搜索防抖 timer
  Timer? _debounceTimer;

  /// 标记点（搜索结果位置）
  Marker? _marker;

  @override
  void initState() {
    super.initState();
    if (widget.initialLat != null && widget.initialLng != null) {
      _currentLat = widget.initialLat!;
      _currentLng = widget.initialLng!;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateAddress();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  // ---------------- 地址更新 ----------------

  Future<void> _updateAddress() async {
    try {
      final result = await _amapService.reverseGeocode(
        latitude: _currentLat,
        longitude: _currentLng,
      );
      if (mounted) {
        setState(() => _currentAddress = result.address);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _currentAddress = '${_currentLat.toStringAsFixed(6)}, ${_currentLng.toStringAsFixed(6)}');
      }
    }
  }

  // ---------------- 搜索 ----------------

  void _onSearchChanged(String text) {
    _debounceTimer?.cancel();
    if (text.trim().isEmpty) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        final tips = await _amapService.inputTips(keywords: text.trim());
        if (mounted) {
          setState(() {
            _suggestions = tips;
            _showSuggestions = tips.isNotEmpty;
          });
        }
      } catch (_) {
        // 静默失败
      }
    });
  }

  void _onSuggestionTap(AmapTip tip) {
    _searchController.text = tip.name;
    _searchFocus.unfocus();
    setState(() => _showSuggestions = false);

    _moveToLocation(tip.latitude, tip.longitude);
  }

  void _onSearchSubmit() {
    _searchFocus.unfocus();
    // 使用 POI 搜索
  }

  // ---------------- 地图操作 ----------------

  void _moveToLocation(double lat, double lng) {
    _currentLat = lat;
    _currentLng = lng;
    _mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 17),
      ),
    );
    _updateAddress();
    _updateMarker(lat, lng);
  }

  void _updateMarker(double lat, double lng) {
    setState(() {
      _marker = Marker(
        position: LatLng(lat, lng),
      );
    });
  }

  void _onMapCreated(AMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _currentLat = position.target.latitude;
    _currentLng = position.target.longitude;
  }

  void _onCameraMoveEnd(CameraPosition position) {
    _currentLat = position.target.latitude;
    _currentLng = position.target.longitude;
    _updateAddress();
  }

  // ---------------- 确认 ----------------

  void _onConfirm() {
    Navigator.of(context).pop(MapPickerResult(
      latitude: _currentLat,
      longitude: _currentLng,
      address: _currentAddress,
    ));
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // 地图层
          _buildMap(),

          // 准星（地图中央）
          _buildCrosshair(),

          // 搜索栏
          _buildSearchBar(theme),

          // 搜索建议列表
          if (_showSuggestions) _buildSuggestionsList(theme),

          // 底部面板
          _buildBottomPanel(theme),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Positioned.fill(
      child: AMapWidget(
        apiKey: AMapApiKey(
          androidKey: AmapConfig.androidKey,
          iosKey: AmapConfig.iosKey,
        ),
        initialCameraPosition: CameraPosition(
          target: LatLng(_currentLat, _currentLng),
          zoom: AmapConfig.defaultZoom,
        ),
        onMapCreated: _onMapCreated,
        onCameraMove: _onCameraMove,
        onCameraMoveEnd: _onCameraMoveEnd,
        markers: _marker != null ? {_marker!} : {},
      ),
    );
  }

  Widget _buildCrosshair() {
    return const Center(
      child: IgnorePointer(
        child: Icon(Icons.add_location, size: 40, color: Colors.red),
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocus,
                  decoration: const InputDecoration(
                    hintText: '搜索地点',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onChanged: _onSearchChanged,
                  onSubmitted: (_) => _onSearchSubmit(),
                ),
              ),
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _suggestions = [];
                      _showSuggestions = false;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionsList(ThemeData theme) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 56,
      left: 12,
      right: 12,
      bottom: 0,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: _suggestions.length.clamp(0, 5),
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final tip = _suggestions[index];
            return ListTile(
              dense: true,
              leading: const Icon(Icons.location_on, color: Colors.blue),
              title: Text(tip.name, style: const TextStyle(fontSize: 14)),
              subtitle: Text(tip.address, style: const TextStyle(fontSize: 12)),
              onTap: () => _onSuggestionTap(tip),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomPanel(ThemeData theme) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          16,
          12,
          16,
          MediaQuery.of(context).padding.bottom + 12,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _currentAddress,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${_currentLat.toStringAsFixed(6)}, ${_currentLng.toStringAsFixed(6)}',
              style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _onConfirm,
              icon: const Icon(Icons.check),
              label: const Text('确认选点'),
            ),
          ],
        ),
      ),
    );
  }
}
