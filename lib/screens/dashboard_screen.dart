import 'package:esp32_control_app/widgets/connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/esp32_provider.dart';
import '../widgets/sensor_card.dart';
import '../widgets/control_panel.dart';
import '../widgets/chart_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 82, 224, 224),
        title: const Text(
          'ESP32 Dashboard',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromARGB(255, 5, 41, 71)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.connected_tv_rounded),
            tooltip: 'Connection Settings',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const ConnectionDialog(),
              );
            },
          ),
        ],
      ),
      body: Consumer<ESP32Provider>(
        builder: (context, esp32Provider, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 82, 224, 224),
                  Color.fromARGB(255, 5, 41, 71),
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionHeader(
                    title: 'Sensor Reading',
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: const [
                      SensorCard(
                        title: 'Temperature',
                        value: '25°C',
                        icon: Icons.thermostat,
                        backgroundColor: Colors.orangeAccent,
                      ),
                      SensorCard(
                        title: 'Humidity',
                        value: '60%',
                        icon: Icons.water_drop,
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                      SensorCard(
                        title: 'Light',
                        value: '80%',
                        icon: Icons.light_mode,
                        backgroundColor: Colors.yellowAccent,
                      ),
                      SensorCard(
                        title: 'Motion',
                        value: 'No',
                        icon: Icons.motion_photos_on,
                        backgroundColor: Colors.greenAccent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const _SectionHeader(title: 'Control'),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 75, 130, 146),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: ControlPanel(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const _SectionHeader(title: 'Temperature'),
                  const SizedBox(height: 16),
                  const SizedBox(
                    height: 200,
                    child: ChartWidget(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
    );
  }
}
