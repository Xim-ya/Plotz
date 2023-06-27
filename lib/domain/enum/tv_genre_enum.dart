enum TvGenre {
  actionAndAdventure(id: 10759, name: 'Action & Adventure'),
  animation(id: 16, name: '애니메이션'),
  comedy(id: 35, name: '코미디'),
  crime(id: 80, name: '범죄'),
  documentary(id: 99, name: '다큐멘터리'),
  drama(id: 18, name: '드라마'),
  family(id: 10751, name: '가족'),
  kids(id: 10762, name: 'Kids'),
  mystery(id: 9648, name: '미스터리'),
  news(id: 10763, name: 'News'),
  reality(id: 10764, name: 'Reality'),
  sciFiAndFantasy(id: 10765, name: 'Sci-Fi & Fantasy'),
  soap(id: 10766, name: 'Soap'),
  talk(id: 10767, name: 'Talk'),
  warAndPolitics(id: 10768, name: 'War & Politics'),
  western(id: 37, name: '서부');

  final String name;
  final int id;

  const TvGenre({
    required this.id,
    required this.name,
  });
}
