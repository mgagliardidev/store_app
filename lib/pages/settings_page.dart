import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/providers/logic_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static const _settingLeadingTitleStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(60)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      'Use Dark Mode',
                      style: _settingLeadingTitleStyle,
                    ),
                    const Spacer(),
                    CupertinoSwitch(
                        value: ref.watch(useDarkThemeProvider),
                        onChanged: (value) {
                          ref
                              .read(useDarkThemeProvider.notifier)
                              .update((state) => value);
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
