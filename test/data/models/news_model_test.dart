import "package:flutter_2/features/daily_news/data/models/news_model.dart";
import "package:flutter_test/flutter_test.dart";
void main() {
  const testNewsModel = NewsModel(
    author: "author",
    content: "comtent",
    description: "discription",
    id: 1499,
    publishedAt: "Today",
    title: "Title",
    url: "http://anyurl.com",
    urlToImage: "https://yandex.ru/images/search?from=tabbar&img_url=https%3A%2F%2Favatars.mds.yandex.net%2Fget-mpic%2F6780724%2Fimg_id5398870021742881284.jpeg%2Forig&lr=213&pos=3&rpt=simage&text=defaultImage",
  );

  test("Must be an object of NewsModel", () async {
    expect(testNewsModel, isA<NewsModel>());
  });
}