import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  final app = Router();

  // 定义路由和对应的处理函数
  app.get('/hello', helloHandler);

  app.get('/example', textHandler);

  app.post('/google-chat/messages', googleChatHandler);

  app.post('/buttons', buttonHandler);

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

Future<Response> buttonHandler(Request request) async {

  final bodyString = await request.readAsString();
  if (bodyString.isNotEmpty) {
    final bodyParams = jsonDecode(bodyString) as Map<String, dynamic>;
    print(bodyParams);
    if (bodyParams['type'] == 'CARD_CLICKED') {
      return Response.ok(jsonEncode(cardJson), headers: headers);
    }
  }

  return Response.ok(jsonEncode({
    "cardsV2": [
      {
        "cardId": "exampleCard",
        "card": {
          "sections": [
            {
              "widgets": [
                {
                  "buttonList": {
                    "buttons": [
                      {
                        "text": "Open a hyperlink",
                        "onClick": {
                          "openLink": {
                            "url": "https://developers.google.com/chat",
                          }
                        }
                      },
                      {
                        "text": "Open User Info",
                        "onClick": {
                          "action": {
                            "function": "goToNewView",
                            "parameters": [
                              {
                                "key": "viewType",
                                "value": "BIRD EYE VIEW",
                              }
                            ],
                          }
                        }
                      }
                    ]
                  }
                }
              ]
            }
          ]
        }
      }
    ]
  }), headers: headers);
}

Response textHandler(Request req) {
  return Response.ok(jsonEncode(
      {
        "cardsV2": [
          {
            "cardId": "unique-card-id",
            "card": {
              "header": {
                "title": "Sasha",
                "subtitle": "Software Engineer",
                "imageUrl":
                "https://developers.google.com/chat/images/quickstart-app-avatar.png",
                "imageType": "CIRCLE",
                "imageAltText": "Avatar for Sasha",
              },
              "sections": [
                {
                  "header": "Contact Info",
                  "collapsible": true,
                  "uncollapsibleWidgetsCount": 1,
                  "widgets": [
                    {
                      "decoratedText": {
                        "startIcon": {
                          "knownIcon": "EMAIL",
                        },
                        "text": "sasha@example.com",
                      }
                    },
                    {
                      "decoratedText": {
                        "startIcon": {
                          "knownIcon": "PERSON",
                        },
                        "text": "<font color=\"#80e27e\">Online</font>",
                      },
                    },
                    {
                      "decoratedText": {
                        "startIcon": {
                          "knownIcon": "PHONE",
                        },
                        "text": "+1 (555) 555-1234",
                      }
                    },
                    {
                      "buttonList": {
                        "buttons": [
                          {
                            "text": "Share",
                            "onClick": {
                              "openLink": {
                                "url": "https://example.com/share",
                              }
                            }
                          },
                          {
                            "text": "Open New Card",
                            "onClick": {
                              "action": {
                                "function": "goToView",
                                "parameters": [
                                  {
                                    "key": "viewType",
                                    "value": "EDIT",
                                  }
                                ],
                              }
                            }
                          },
                          {
                            "text": "Open New Card Return {}",
                            "onClick": {
                              "action": {
                                "function": "goToView1",
                                "parameters": [
                                  {
                                    "key": "viewType",
                                    "value": "EDIT",
                                  }
                                ],
                              }
                            }
                          },
                        ],
                      }
                    },
                  ],
                },
              ],
            },
          }
        ],
      }
      ), headers: headers);
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
          "title": "Hello",
          "subtitle": "Software Engineer",
          "imageUrl": "https://lh3.googleusercontent.com/a/AAcHTtcPpZJO414X0zTX0SEr-BHyyRfMO_LPw15H5tO9=k-no",
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

Map<String, dynamic> buttonJson = {
  "cardsV2": [
    {
      "cardId": "newCard",
      "card": {
        "header": {
          "title": "New Card",
          "subtitle": "This is a new card"
        },
        "sections": [
          {
            "widgets": [
              {
                "textParagraph": {
                  "text": "This is the content of the new card"
                }
              }
            ]
          }
        ]
      }
    }
  ]
};
