import 'package:flutter/material.dart';

void main() => runApp(const AdministrationTapApp());

class AdministrationTapApp extends StatelessWidget {
  const AdministrationTapApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF176B5B);
    return MaterialApp(
      title: 'Administration TAP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        scaffoldBackgroundColor: const Color(0xFFF5F7F8),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFE7ECEB)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0E7E5)),
          ),
        ),
      ),
      home: const AdministrationShell(),
    );
  }
}

class AdministrationShell extends StatefulWidget {
  const AdministrationShell({super.key});

  @override
  State<AdministrationShell> createState() => _AdministrationShellState();
}

class _AdministrationShellState extends State<AdministrationShell> {
  int _selectedIndex = 0;

  static const _destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.space_dashboard_outlined),
      selectedIcon: Icon(Icons.space_dashboard_rounded),
      label: 'Vue d’ensemble',
    ),
    NavigationDestination(
      icon: Icon(Icons.groups_outlined),
      selectedIcon: Icon(Icons.groups_rounded),
      label: 'Membres',
    ),
    NavigationDestination(
      icon: Icon(Icons.account_balance_wallet_outlined),
      selectedIcon: Icon(Icons.account_balance_wallet_rounded),
      label: 'Finances',
    ),
    NavigationDestination(
      icon: Icon(Icons.apartment_outlined),
      selectedIcon: Icon(Icons.apartment_rounded),
      label: 'Biens',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final pages = <Widget>[
      const DashboardPage(),
      const FeaturePlaceholder(
        title: 'Membres',
        description: 'La gestion des membres sera connectée au backend.',
        icon: Icons.groups_rounded,
      ),
      const FeaturePlaceholder(
        title: 'Finances',
        description: 'Les recettes et dépenses seront chargées depuis la base de données.',
        icon: Icons.account_balance_wallet_rounded,
      ),
      const FeaturePlaceholder(
        title: 'Biens',
        description: 'L’inventaire des biens sera connecté au backend.',
        icon: Icons.apartment_rounded,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (wide)
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) =>
                    setState(() => _selectedIndex = index),
                labelType: NavigationRailLabelType.all,
                leading: const Padding(
                  padding: EdgeInsets.fromLTRB(8, 20, 8, 28),
                  child: _BrandMark(compact: true),
                ),
                destinations: _destinations
                    .map(
                      (destination) => NavigationRailDestination(
                        icon: destination.icon,
                        selectedIcon: destination.selectedIcon,
                        label: Text(destination.label),
                      ),
                    )
                    .toList(),
              ),
            Expanded(
              child: Column(
                children: [
                  _TopBar(
                    title: _destinations[_selectedIndex].label,
                    wide: wide,
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _selectedIndex,
                      children: pages,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) =>
                  setState(() => _selectedIndex = index),
              destinations: _destinations,
            ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title, required this.wide});

  final String title;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(wide ? 32 : 20, 18, wide ? 32 : 20, 12),
      child: Row(
        children: [
          if (!wide) ...[
            const _BrandMark(),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Espace de gestion',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF687875),
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Notifications (bientôt disponible)',
            onPressed: () => _showNotice(context),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundColor: Color(0xFFD9ECE6),
            foregroundColor: Color(0xFF176B5B),
            child: Icon(Icons.person_outline_rounded),
          ),
        ],
      ),
    );
  }

  void _showNotice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Les notifications seront ajoutées plus tard.')),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFF176B5B),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.account_balance_rounded, color: Colors.white),
        ),
        if (!compact) ...[
          const SizedBox(width: 10),
          const Text(
            'TAP Admin',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ],
      ],
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;
        final horizontal = wide ? 32.0 : 20.0;
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(horizontal, 12, horizontal, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(wide ? 28 : 22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF176B5B), Color(0xFF238875)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bonjour, administrateur',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Retrouvez ici les indicateurs essentiels de votre organisation.',
                            style: TextStyle(color: Color(0xFFE0F2EC), height: 1.4),
                          ),
                          const SizedBox(height: 18),
                          const _DemoBadge(),
                        ],
                      ),
                    ),
                    if (wide) ...[
                      const SizedBox(width: 18),
                      const Icon(
                        Icons.query_stats_rounded,
                        color: Color(0xFFD1F0E6),
                        size: 72,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Indicateurs clés',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                'Valeurs fictives en attendant la connexion au backend.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF687875),
                    ),
              ),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: wide ? 4 : (constraints.maxWidth >= 480 ? 2 : 1),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: wide ? 1.35 : (constraints.maxWidth >= 480 ? 1.55 : 2.2),
                children: const [
                  _MetricCard(
                    title: 'Membres',
                    value: '—',
                    detail: 'Données non connectées',
                    icon: Icons.groups_rounded,
                    tint: Color(0xFFE4F3ED),
                    iconColor: Color(0xFF176B5B),
                  ),
                  _MetricCard(
                    title: 'Recettes',
                    value: '—',
                    detail: 'Période en cours',
                    icon: Icons.trending_up_rounded,
                    tint: Color(0xFFE8EFFD),
                    iconColor: Color(0xFF315DB8),
                  ),
                  _MetricCard(
                    title: 'Dépenses',
                    value: '—',
                    detail: 'Période en cours',
                    icon: Icons.trending_down_rounded,
                    tint: Color(0xFFFFEDE2),
                    iconColor: Color(0xFFB95B23),
                  ),
                  _MetricCard(
                    title: 'Biens suivis',
                    value: '—',
                    detail: 'Inventaire non connecté',
                    icon: Icons.apartment_rounded,
                    tint: Color(0xFFF0E8FC),
                    iconColor: Color(0xFF7846AD),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Text(
                'Activité récente',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.inbox_outlined,
                        size: 34,
                        color: Color(0xFF81908D),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Aucune activité à afficher',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Les événements apparaîtront ici après la connexion des services.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF687875), height: 1.4),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DemoBadge extends StatelessWidget {
  const _DemoBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
      ),
      child: const Text(
        'APERÇU — DONNÉES DE DÉMONSTRATION',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.detail,
    required this.icon,
    required this.tint,
    required this.iconColor,
  });

  final String title;
  final String value;
  final String detail;
  final IconData icon;
  final Color tint;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: tint,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: iconColor),
                ),
                const Spacer(),
                const Icon(Icons.more_horiz_rounded, color: Color(0xFF9AA7A4)),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 3),
            Text(
              detail,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF687875),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturePlaceholder extends StatelessWidget {
  const FeaturePlaceholder({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: const Color(0xFFE4F3ED),
                    child: Icon(icon, size: 32, color: const Color(0xFF176B5B)),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF687875),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Chip(
                    avatar: Icon(Icons.construction_outlined, size: 18),
                    label: Text('Module à implémenter'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
