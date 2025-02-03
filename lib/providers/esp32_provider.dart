import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class ESP32Provider with ChangeNotifier {
  WebSocketChannel? _channel;
  bool _connected = false;
  bool _led1Status = false;
  bool _led2Status = false;
  double _fanSpeed = 0;
  String _temperature = '25';
  String _humidity = '60';
  String _light = '80';
  bool _motion = false;

  bool get connected => _connected;
  bool get led1Status => _led1Status;
  bool get led2Status => _led2Status;
  double get fanSpeed => _fanSpeed;
  String get temperature => _temperature;
  String get humidity => _humidity;
  String get light => _light;
  bool get motion => _motion;

  void connect(String ipAddress) {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://$ipAddress:81'),
      );
      _connected = true;
      _listenToWebSocket();
      notifyListeners();
    } catch (e) {
      _connected = false;
      notifyListeners();
    }
  }

  void disconnect() {
    _channel?.sink.close();
    _connected = false;
    notifyListeners();
  }

  void _listenToWebSocket() {
    _channel?.stream.listen(
      (message) {
        final data = jsonDecode(message);
        _temperature = data['temperature'];
        _humidity = data['humidity'];
        _light = data['light'];
        _motion = data['motion'];
        notifyListeners();
      },
      onError: (error) {
        _connected = false;
        notifyListeners();
      },
      onDone: () {
        _connected = false;
        notifyListeners();
      },
    );
  }

  void toggleLED1() {
    _led1Status = !_led1Status;
    _sendCommand('led1', _led1Status ? '1' : '0');
    notifyListeners();
  }

  void toggleLED2() {
    _led2Status = !_led2Status;
    _sendCommand('led2', _led2Status ? '1' : '0');
    notifyListeners();
  }

  void setFanSpeed(double speed) {
    _fanSpeed = speed;
    _sendCommand('fan', speed.round().toString());
    notifyListeners();
  }

  void _sendCommand(String command, String value) {
    if (_connected) {
      final message = jsonEncode({
        'command': command,
        'value': value,
      });
      _channel?.sink.add(message);
    }
  }
}