

import 'package:uppercut_fantube/utilities/index.dart';

enum BottomNavigationConstants {
  home(
    label: 'Home',
    icon: Icon(Icons.home),
  ),
  business(
    label: 'Business',
    icon: Icon(Icons.business),
  ),
  school(
    label: 'School',
    icon: Icon(Icons.school),
  );

  final String label;
  final Icon icon;

  const BottomNavigationConstants({
    required this.label,
    required this.icon,
  });
}
