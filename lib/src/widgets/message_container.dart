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

  /// [messageTextBuilder] function takes a function with this
  /// structure [Widget Function(String)] to render the text inside
  /// the container.
  final Widget Function(String) messageTextBuilder;

  /// [messageImageBuilder] function takes a function with this
  /// structure [Widget Function(String)] to render the image inside
  /// the container.
  final Widget Function(String) messageImageBuilder;

  /// [messageTimeBuilder] function takes a function with this
  /// structure [Widget Function(String)] to render the time text inside
  /// the container.
  final Widget Function(String) messageTimeBuilder;

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
    this.messageTextBuilder,
    this.messageTimeBuilder,
    this.messageContainerDecoration,
    this.parsePatterns = const <MatchText>[],
    this.isUser,
  });

  @override
  Widget build(BuildContext context) {
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
                  messageImageBuilder(message.image)
                else
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: FadeInImage.memoryNetwork(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.7,
                      fit: BoxFit.contain,
                      placeholder: kTransparentImage,
                      image: message.image,
                    ),
                  ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  timeFormat != null
                      ? timeFormat.format(message.createdAt)
                      : DateFormat('HH:mm:ss').format(message.createdAt),
                  style: TextStyle(
                    fontSize: 11.5,
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
