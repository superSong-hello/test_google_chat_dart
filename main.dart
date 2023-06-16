import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  final app = Router();

  // 定义路由和对应的处理函数
  app.get('/hello', helloHandler);

  app.get('/text', textHandler);

  app.post('/google-chat/messages', googleChatHandler);

  // 创建服务器并启动
  final server = await io.serve(app, 'localhost', 8081);
  print('Server running on ${server.address}:${server.port}');
}

// 定义处理函数
Response helloHandler(Request request) {
  return Response.ok(jsonEncode(cardJson1), headers: headers);
}

Response googleChatHandler(Request request) {
  return Response.ok(jsonEncode(cardJson), headers: headers);
}

Response textHandler(Request req) {
  return Response.ok(jsonEncode({'text': 'hello banto'}), headers: headers);
}

Map<String, Object> headers = {
  'content-type': 'application/json'
};

Map<String, dynamic> cardJson = {
  "cardsV2": [
    {
      "cardId": "avatarCard",
      "card": {
        "name": "Avatar Card",
        "header": {
          "title": "Hello !",
          "subtitle": "Software Engineer",
          "imageUrl": "https://developers.google.com/chat/images/quickstart-app-avatar.png",
          "imageType": "CIRCLE",
          "imageAltText": "Avatar for Sasha"
        },
        "sections": [
          {
            "widgets": [
              {
                "textParagraph": {
                  "text": "Your avatar picture: "
                }
              },
              {
                "image": {
                  "imageUrl": "https://img2.baidu.com/it/u=2048195462,703560066&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1687021200&t=c5a7030b97ed8c35ec8f9340f93e65d3"
                }
              }
            ]
          }
        ]
      }
    }
  ]
};

Map<String, dynamic> cardJson1 = {
  "cardsV2": [
    {
      "cardId": "avatarCard",
      "card": {
        "name": "Avatar Card",
        "header": {
          "title": "Hello",
          "subtitle": "Software Engineer",
          "imageUrl": "https://developers.google.com/chat/images/quickstart-app-avatar.png",
          "imageType": "CIRCLE",
          "imageAltText": "Avatar for Sasha"
        },
        "sections": [
          {
            "widgets": [
              {
                "textParagraph": {
                  "text": "Your avatar picture: "
                }
              }
            ]
          }
        ]
      }
    }
  ]
};