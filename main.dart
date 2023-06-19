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
                  "imageUrl": "https://lh3.googleusercontent.com/a/AAcHTtcPpZJO414X0zTX0SEr-BHyyRfMO_LPw15H5tO9=s96-c"
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