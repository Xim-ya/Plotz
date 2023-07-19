enum BottomNavigationConstants {
  home(
    indexedKey: 0,
    label: '홈',
    iconPath: 'tab_home.svg',
  ),
  search(
    indexedKey: 1,
    label: '검색',
    iconPath: 'tab_search.svg',
  ),
  explore(
    indexedKey: 2,
    label: '탐색',
    iconPath: 'tab_explore.svg',
  ),
  myPage(
    indexedKey: 3,
    label: '마이페이지',
    iconPath: 'tab_my_page.svg',
  );

  final int indexedKey;
  final String label;
  final String iconPath;

  const BottomNavigationConstants({
    required this.indexedKey,
    required this.label,
    required this.iconPath,
  });
}
