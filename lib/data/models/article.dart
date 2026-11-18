class Article {
  const Article({
    required this.title,
    required this.sourceName,
    required this.url,
    required this.publishedAt,
    this.author,
    this.description,
    this.imageUrl,
    this.content,
    this.featured = false,
    this.launches = const [],
    this.events = const [],
  });

  final String title;
  final String sourceName;
  final String url;
  final DateTime? publishedAt;
  final String? author;
  final String? description;
  final String? imageUrl;
  final String? content;
  final bool featured;
  final List<dynamic> launches;
  final List<dynamic> events;

  String get cleanContent => (content ?? description ?? '').trim();

  bool get isValid =>
      title.isNotEmpty && title != '[Removed]' && url.isNotEmpty;

  @override
  bool operator ==(Object other) => other is Article && other.url == url;

  @override
  int get hashCode => url.hashCode;

  factory Article.fromJson(Map<String, dynamic> json) {
    final authors = json['authors'] as List<dynamic>? ?? [];

    return Article(
      title: json['title'] as String? ?? '',
      sourceName: json['news_site'] as String? ?? 'Unknown',
      url: json['url'] as String? ?? '',
      publishedAt: DateTime.tryParse(json['published_at'] as String? ?? ''),
      author: authors.isNotEmpty
          ? (authors.first as Map<String, dynamic>)['name'] as String?
          : null,
      description: json['summary'] as String?,
      imageUrl: json['image_url'] as String?,
      content: json['summary'] as String?,
      featured: json['featured'] as bool? ?? false,
      launches: json['launches'] as List<dynamic>? ?? const [],
      events: json['events'] as List<dynamic>? ?? const [],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'news_site': sourceName,
    'url': url,
    'published_at': publishedAt?.toIso8601String(),
    'summary': description,
    'image_url': imageUrl,
    'authors': author == null
        ? []
        : [
            {'name': author},
          ],
    'featured': featured,
    'launches': launches,
    'events': events,
  };

  static final dummy = Article(
    title: 'NASA Announces New Space Mission',
    sourceName: 'NASA',
    url: 'https://www.nasa.gov/',
    publishedAt: DateTime.now(),
    description: 'An exciting update from the space industry.',
    imageUrl: null,
  );
}
