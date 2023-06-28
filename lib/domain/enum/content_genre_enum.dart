enum ContentGenre {
  action(id: 28, name: '액션'),
  adventure(id: 12, name: '모험'),
  comedy(id: 35, name: '코미디'),
  crime(id: 80, name: '범죄'),
  documentary(id: 99, name: '다큐멘터리'),
  drama(id: 18, name: '드라마'),
  family(id: 10751, name: '가족'),
  fantasy(id: 14, name: '판타지'),
  history(id: 36, name: '역사'),
  horror(id: 27, name: '공포'),
  music(id: 10402, name: '음악'),
  mystery(id: 9648, name: '미스터리'),
  romance(id: 10749, name: '로맨스'),
  scienceFiction(id: 878, name: 'SF'),
  tvMovie(id: 10770, name: 'TV 영화'),
  thriller(id: 53, name: '스릴러'),
  war(id: 10752, name: '전쟁'),
  western(id: 37, name: '서부'),
  actionAndAdventure(id: 10759, name: 'Action & Adventure'),
  animation(id: 16, name: '애니메이션'),
  kids(id: 10762, name: 'Kids'),
  news(id: 10763, name: 'News'),
  reality(id: 10764, name: 'Reality'),
  sciFiAndFantasy(id: 10765, name: 'Sci-Fi & Fantasy'),
  soap(id: 10766, name: 'Soap'),
  talk(id: 10767, name: 'Talk'),
  warAndPolitics(id: 10768, name: 'War & Politics');

  final String name;
  final int id;

  const ContentGenre({
    required this.id,
    required this.name,
  });

  static ContentGenre getContentFromJson(String name) {
    switch (name) {
      case 'action':
        return ContentGenre.action;
      case 'adventure':
        return ContentGenre.adventure;
      case 'comedy':
        return ContentGenre.comedy;
      case 'crime':
        return ContentGenre.crime;
      case 'documentary':
        return ContentGenre.documentary;
      case 'drama':
        return ContentGenre.drama;
      case 'family':
        return ContentGenre.family;
      case 'fantasy':
        return ContentGenre.fantasy;
      case 'history':
        return ContentGenre.history;
      case 'horror':
        return ContentGenre.horror;
      case 'music':
        return ContentGenre.music;
      case 'mystery':
        return ContentGenre.mystery;
      case 'romance':
        return ContentGenre.romance;
      case 'scienceFiction':
        return ContentGenre.scienceFiction;
      case 'tvMovie':
        return ContentGenre.tvMovie;
      case 'thriller':
        return ContentGenre.thriller;
      case 'war':
        return ContentGenre.war;
      case 'western':
        return ContentGenre.western;
      case 'actionAndAdventure':
        return ContentGenre.actionAndAdventure;
      case 'animation':
        return ContentGenre.animation;
      case 'kids':
        return ContentGenre.kids;
      case 'news':
        return ContentGenre.news;
      case 'reality':
        return ContentGenre.reality;
      case 'sciFiAndFantasy':
        return ContentGenre.sciFiAndFantasy;
      case 'soap':
        return ContentGenre.soap;
      case 'talk':
        return ContentGenre.talk;
      case 'warAndPolitics':
        return ContentGenre.warAndPolitics;
      default:
        throw Exception('Invalid ContentGenre name: $name');
    }
  }

  static ContentGenre getContentGenre(String name) {
    switch (name) {
      case '액션':
        return ContentGenre.action;
      case '모험':
        return ContentGenre.adventure;
      case '코미디':
        return ContentGenre.comedy;
      case '범죄':
        return ContentGenre.crime;
      case '다큐멘터리':
        return ContentGenre.documentary;
      case '드라마':
        return ContentGenre.drama;
      case '가족':
        return ContentGenre.family;
      case '판타지':
        return ContentGenre.fantasy;
      case '역사':
        return ContentGenre.history;
      case '공포':
        return ContentGenre.horror;
      case '음악':
        return ContentGenre.music;
      case '미스터리':
        return ContentGenre.mystery;
      case '로맨스':
        return ContentGenre.romance;
      case 'SF':
        return ContentGenre.scienceFiction;
      case 'TV 영화':
        return ContentGenre.tvMovie;
      case '스릴러':
        return ContentGenre.thriller;
      case '전쟁':
        return ContentGenre.war;
      case '서부':
        return ContentGenre.western;
      case 'Action & Adventure':
        return ContentGenre.actionAndAdventure;
      case '애니메이션':
        return ContentGenre.animation;
      case 'Kids':
        return ContentGenre.kids;
      case 'News':
        return ContentGenre.news;
      case 'Reality':
        return ContentGenre.reality;
      case 'Sci-Fi & Fantasy':
        return ContentGenre.sciFiAndFantasy;
      case 'Soap':
        return ContentGenre.soap;
      case 'Talk':
        return ContentGenre.talk;
      case 'War & Politics':
        return ContentGenre.warAndPolitics;
      default:
        throw ArgumentError('Invalid genre name: $name');
    }
  }
}
