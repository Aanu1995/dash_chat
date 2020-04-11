part of dash_chat;

/// MessageContainer is just a wrapper around [Text], [Image]
/// component to present the message
class MessageContainer extends StatelessWidget {
  /// Message Object that will be rendered
  /// Takes a [ChatMessage] object
  final ChatMessage message;

  /// [DateFormat] object to render the date in desired
  /// format, if no format is provided it use
  /// the default `HH:mm:ss`
  final DateFormat timeFormat;

  final Widget Function(String url) messageImageBuilder;

  /// Provides a custom style to the message container
  /// takes [BoxDecoration]
  final BoxDecoration messageContainerDecoration;

  /// Used to parse text to make it linkified text uses
  /// [flutter_parsed_text](https://pub.dev/packages/flutter_parsed_text)
  /// takes a list of [MatchText] in order to parse Email, phone, links
  /// and can also add custom pattersn using regex
  final List<MatchText> parsePatterns;

  /// A flag which is used for assiging styles
  final bool isUser;

  const MessageContainer({
    @required this.message,
    @required this.timeFormat,
    this.messageImageBuilder,
    this.messageContainerDecoration,
    this.parsePatterns = const <MatchText>[],
    this.isUser,
  });

  static var random = new Random();

  static List<Color> color = [
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.green,
    Colors.indigo,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    final nameColor = color[random.nextInt(7)];
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: Card(
        color: isUser ? Color.fromRGBO(225, 255, 199, 1.0) : Colors.white,
        margin: EdgeInsets.only(top: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              if (message.user.name != null && !isUser)
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    message.user.name,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: nameColor,
                    ),
                  ),
                ),
              if (message.text.isNotEmpty && message.text != null)
                ParsedText(
                  parse: parsePatterns,
                  text: message.text,
                  style: TextStyle(
                    fontSize: 15.5,
                    color: Colors.black87,
                  ),
                ),
              if (message.image != null)
                if (messageImageBuilder != null)
                  messageImageBuilder(message.image),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  timeFormat != null
                      ? timeFormat.format(message.createdAt)
                      : DateFormat('h:mm a').format(message.createdAt),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.black45,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
