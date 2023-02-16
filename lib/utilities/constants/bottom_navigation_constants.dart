import 'package:soon_sak/utilities/index.dart';

enum BottomNavigationConstants {
  home(
    label: '홈',
    icon: Icon(Icons.home),
  ),
  business(
    label: '탐색',
    icon: Icon(Icons.video_collection),
  ),
  curation(
    label: '큐레이션',
    icon: Icon(Icons.video_call),
  ),
  school(
    label: '마에페이지',
    icon: Icon(Icons.person),
  );

  final String label;
  final Icon icon;

  const BottomNavigationConstants({
    required this.label,
    required this.icon,
  });
}
