import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef UploadImageCallback = Future<String> Function(File file);

class ImagePickerSheetResult {
  final List<File> files;
  final List<String> urls;

  ImagePickerSheetResult({required this.files, required this.urls});
}

Future<ImagePickerSheetResult?> showImagePickerSheet(
  BuildContext context, {
  required UploadImageCallback onUpload,
  int maxCount = 9,
}) {
  return showModalBottomSheet<ImagePickerSheetResult>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _ImagePickerSheetContent(
      onUpload: onUpload,
      maxCount: maxCount,
    ),
  );
}

class _ImagePickerSheetContent extends StatefulWidget {
  final UploadImageCallback onUpload;
  final int maxCount;

  const _ImagePickerSheetContent({
    required this.onUpload,
    required this.maxCount,
  });

  @override
  State<_ImagePickerSheetContent> createState() => _ImagePickerSheetContentState();
}

class _ImagePickerSheetContentState extends State<_ImagePickerSheetContent> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedFiles = [];
  bool _isUploading = false;
  double? _uploadProgress;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.onSurfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              _selectedFiles.isEmpty ? '选择图片' : '已选择 ${_selectedFiles.length} 张',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            // Image grid
            if (_selectedFiles.isNotEmpty) ...[
              _buildImageGrid(),
              const SizedBox(height: 12),
            ],

            // Upload progress
            if (_isUploading && _uploadProgress != null) ...[
              LinearProgressIndicator(value: _uploadProgress),
              const SizedBox(height: 8),
            ],

            // Action buttons
            Row(
              children: [
                if (_selectedFiles.length < widget.maxCount) ...[
                  _ActionChip(
                    icon: Icons.camera_alt_outlined,
                    label: '拍照',
                    onTap: _isUploading ? null : () => _pickImage(ImageSource.camera),
                  ),
                  const SizedBox(width: 12),
                  _ActionChip(
                    icon: Icons.photo_library_outlined,
                    label: '相册',
                    onTap: _isUploading ? null : () => _pickImage(ImageSource.gallery),
                  ),
                ],
                const Spacer(),
                if (_selectedFiles.isNotEmpty)
                  FilledButton(
                    onPressed: _isUploading ? null : _doUpload,
                    child: const Text('确定'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedFiles.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final file = _selectedFiles[index];
          return Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(file.path),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              if (!_isUploading)
                Positioned(
                  top: -6,
                  right: -6,
                  child: InkWell(
                    onTap: () => setState(() => _selectedFiles.removeAt(index)),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(Icons.close, size: 16, color: Colors.white),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final file = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (file != null) {
        setState(() => _selectedFiles.add(file));
      }
    } catch (_) {}
  }

  Future<void> _doUpload() async {
    if (_selectedFiles.isEmpty) return;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0;
    });

    final urls = <String>[];
    try {
      for (int i = 0; i < _selectedFiles.length; i++) {
        final url = await widget.onUpload(File(_selectedFiles[i].path));
        urls.add(url);
        if (mounted) {
          setState(() => _uploadProgress = (i + 1) / _selectedFiles.length);
        }
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('上传失败，请重试')),
        );
        setState(() {
          _isUploading = false;
          _uploadProgress = null;
        });
      }
      return;
    }

    if (mounted) {
      Navigator.of(context).pop(ImagePickerSheetResult(
        files: _selectedFiles.map((f) => File(f.path)).toList(),
        urls: urls,
      ));
    }
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionChip({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}
