class Story {
  final String id;
  final String title;
  final String category;
  final String description;
  final String author;
  final String date;
  final String imageUrl;
  final bool trending;

  Story({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.author,
    required this.date,
    required this.imageUrl,
    this.trending = false,
  });
}

class GalleryItem {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final String description;

  GalleryItem({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.description,
  });
}

class VideoItem {
  final String id;
  final String title;
  final String category;
  final String description;
  final String duration;
  final String thumbnailUrl;
  final String views;

  VideoItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.duration,
    required this.thumbnailUrl,
    required this.views,
  });
}

class TriviaItem {
  final String id;
  final String question;
  final String answer;
  final String category;
  final String difficulty;
  final List<String> options;

  TriviaItem({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
    required this.difficulty,
    required this.options,
  });
}

class EventItem {
  final String id;
  final String title;
  final String category;
  final String date;
  final String location;
  final String imageUrl;
  final int attendeesCount;
  final String description;

  EventItem({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.attendeesCount,
    this.description = '',
  });
}