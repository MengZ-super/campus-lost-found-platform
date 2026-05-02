import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LostFoundListPage extends StatelessWidget {
  const LostFoundListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('失物招领')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: '搜索物品...',
              prefixIcon: const Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                Icon(Icons.inbox_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline),
                const SizedBox(height: 16),
                Text('暂无物品信息', style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => GoRouter.of(context).go('/publish'),
        icon: const Icon(Icons.add),
        label: const Text('发布'),
      ),
    );
  }
}
