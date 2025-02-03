import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/esp32_provider.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final esp32Provider = context.watch<ESP32Provider>();
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color.fromARGB(
          255, 175, 205, 215), // Warna latar kartu yang lembut
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Control Panel',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            const Divider(
              thickness: 1.5,
              height: 20,
              color: Colors.grey,
            ),
            SwitchListTile(
              title: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.amber),
                  SizedBox(width: 8),
                  Text('LED 1'),
                ],
              ),
              value: esp32Provider.led1Status,
              onChanged: (value) {
                context.read<ESP32Provider>().toggleLED1();
              },
              activeColor: Colors.amber,
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.lightBlue),
                  SizedBox(width: 8),
                  Text('LED 2'),
                ],
              ),
              value: esp32Provider.led2Status,
              onChanged: (value) {
                context.read<ESP32Provider>().toggleLED2();
              },
              activeColor: Colors.lightBlue,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.speed, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Fan Speed', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Text(
                  '${esp32Provider.fanSpeed.round()}%',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
            Slider(
              value: esp32Provider.fanSpeed,
              min: 0,
              max: 100,
              divisions: 10,
              label: '${esp32Provider.fanSpeed.round()}%',
              activeColor: Colors.green,
              onChanged: (value) {
                context.read<ESP32Provider>().setFanSpeed(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
