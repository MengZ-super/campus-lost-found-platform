import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/auth/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('校园失物招领'),
        centerTitle: false,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final nickname = state.maybeWhen(
            authenticated: (user) => user.nickname ?? user.username,
            orElse: () => '',
          );
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('你好，$nickname', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text('需要帮助吗？', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.outline)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _FeatureCard(
                        icon: Icons.report_problem_outlined,
                        label: '发布失物',
                        color: theme.colorScheme.error,
                        onTap: () => context.go('/publish'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _FeatureCard(
                        icon: Icons.check_circle_outline,
                        label: '发布招领',
                        color: theme.colorScheme.primary,
                        onTap: () => context.go('/publish'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _FeatureCard(
                        icon: Icons.list_alt_outlined,
                        label: '我的发布',
                        color: theme.colorScheme.tertiary,
                        onTap: () => context.go('/my/publishes'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _FeatureCard(
                        icon: Icons.person_outline,
                        label: '个人中心',
                        color: theme.colorScheme.secondary,
                        onTap: () => context.go('/my'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text('快捷入口', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('丢失了物品？'),
                  subtitle: const Text('发布寻物信息，让大家帮你找'),
                  trailing: const Icon(Icons.chevron_right),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  tileColor: theme.colorScheme.surfaceContainerHighest,
                  onTap: () => context.go('/publish'),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.volunteer_activism_outlined),
                  title: const Text('捡到了东西？'),
                  subtitle: const Text('发布招领信息，帮它找到主人'),
                  trailing: const Icon(Icons.chevron_right),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  tileColor: theme.colorScheme.surfaceContainerHighest,
                  onTap: () => context.go('/publish'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Icon(icon, size: 36, color: color),
              const SizedBox(height: 8),
              Text(label, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}
