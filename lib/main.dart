import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'data/local/hive_setup.dart';
import 'data/repositories/schedule_repository_impl.dart';
import 'presentation/providers/display_config_provider.dart';
import 'presentation/providers/saved_schedules_provider.dart';
import 'presentation/providers/schedule_provider.dart';

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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = context.watch<ScheduleProvider>();
    final textController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SchedBuilder - Test Parser'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<DisplayConfigProvider>().toggleDarkMode();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input field
            TextField(
              controller: textController,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Paste Schedule Text',
                hintText:
                    'CS101 Computer Science Intro * 8:00 AM - 9:30 AM Room 204 M W F * DOE, JOHN john@example.com 3',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                scheduleProvider.updateInput(value);
              },
            ),

            const SizedBox(height: 16),

            // Parse button
            ElevatedButton.icon(
              onPressed: scheduleProvider.isLoading
                  ? null
                  : () {
                      scheduleProvider.parseAndArrange();
                    },
              icon: scheduleProvider.isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.play_arrow),
              label: Text(
                scheduleProvider.isLoading ? 'Parsing...' : 'Parse Schedule',
              ),
            ),

            const SizedBox(height: 16),

            // Results
            Expanded(child: _buildResults(scheduleProvider)),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(ScheduleProvider provider) {
    final parseResult = provider.parseResult;
    final scheduleTable = provider.scheduleTable;

    if (parseResult == null) {
      return const Center(
        child: Text(
          'Enter schedule text and tap Parse',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    if (!parseResult.isSuccess) {
      return SingleChildScrollView(
        child: Card(
          color: Colors.red.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Parsing Errors:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...parseResult.errors!.map(
                  (error) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $error'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (scheduleTable == null || scheduleTable.isEmpty) {
      return const Center(child: Text('No schedule to display'));
    }

    // Success! Show parsed classes
    final classes = scheduleTable.getAllClasses();

    return SingleChildScrollView(
      child: Card(
        color: Colors.green.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Parsing Successful!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Found ${classes.length} classes:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...classes.map(
                (classData) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${classData.code} - ${classData.subject}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Title: ${classData.title}'),
                      if (classData.teacher != null)
                        Text('Teacher: ${classData.teacher!.fullName}'),
                      Text('Units: ${classData.units}'),
                      Text('Schedule: ${classData.schedule.length} period(s)'),
                      ...classData.schedule.map(
                        (period) => Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: Text(
                            '${period.start.format(false)} - ${period.end.format(false)} | ${period.room} | ${period.weekdays.map((d) => d.shortName).join(" ")}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Text('Schedule Grid: ${scheduleTable.rows.length} time slots'),
            ],
          ),
        ),
      ),
    );
  }
}
