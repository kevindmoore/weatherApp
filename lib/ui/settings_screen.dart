import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers.dart';

import '../misc.dart';

@RoutePage()
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  TemperatureUnit currentUnit = TemperatureUnit.fahrenheit;

  @override
  void initState() {
    super.initState();
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs.containsKey('temperatureUnit')) {
      final unit = prefs.getString('temperatureUnit');
      if (unit == 'celsius') {
        currentUnit = TemperatureUnit.celsius;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              colors: [Color(0xff42C8F9), Color(0xffFFCF90)]),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Settings', style: screenTitleStyle),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<TemperatureUnit>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text('Fahrenheit', style: smallDateStyle),
                    tileColor: Colors.white,
                    value: TemperatureUnit.fahrenheit,
                    groupValue: currentUnit,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          currentUnit = value;
                          ref.read(sharedPreferencesProvider).setString(
                              'temperatureUnit',
                              currentUnit == TemperatureUnit.celsius
                                  ? 'celsius'
                                  : 'fahrenheit');
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RadioListTile<TemperatureUnit>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text('Celsius', style: smallDateStyle),
                    tileColor: Colors.white,
                    value: TemperatureUnit.celsius,
                    groupValue: currentUnit,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          currentUnit = value;
                          ref.read(sharedPreferencesProvider).setString(
                              'temperatureUnit',
                              currentUnit == TemperatureUnit.celsius
                                  ? 'celsius'
                                  : 'fahrenheit');
                        }
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
