import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'data/local/hive_setup.dart';
import 'data/repositories/schedule_repository_impl.dart';
import 'presentation/providers/display_config_provider.dart';
import 'presentation/providers/saved_schedules_provider.dart';
import 'presentation/providers/schedule_provider.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive CE
  await initHive();

  // Create repository
  final scheduleRepo = ScheduleRepositoryImpl();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => DisplayConfigProvider()),
        ChangeNotifierProvider(
          create: (_) => SavedSchedulesProvider(repository: scheduleRepo),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final displayConfig = context.watch<DisplayConfigProvider>();
    final isDarkMode = displayConfig.isDarkMode;

    return MaterialApp(
      title: 'SchedBuilder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: const HomeScreen(),
    );
  }
}
