part of dash_chat;

class MessageListView extends StatefulWidget {
  final List<ChatMessage> messages;
  final ChatUser user;
  final bool showuserAvatar;
  final DateFormat dateFormat;
  final DateFormat timeFormat;
  final bool showAvatarForEverMessage;
  final Function(ChatUser) onPressAvatar;
  final Function(ChatUser) onLongPressAvatar;
  final bool renderAvatarOnTop;
  final Function(ChatMessage) onLongPressMessage;
  final Widget Function(ChatUser) avatarBuilder;

  final Widget Function(String url) messageImageBuilder;

  final Widget Function(String) dateBuilder;
  final Widget Function() renderMessageFooter;
  final BoxDecoration messageContainerDecoration;
  final List<MatchText> parsePatterns;
  final ScrollController scrollController;
  final EdgeInsets messageContainerPadding;
  final Function changeVisible;
  final bool visible;
  final bool showLoadMore;
  final bool shouldShowLoadEarlier;
  final bool isLoadingMore;
  final Function onLoadEarlier;
  final Function(bool) defaultLoadCallback;

  MessageListView({
    this.isLoadingMore,
    this.shouldShowLoadEarlier,
    this.onLoadEarlier,
    this.defaultLoadCallback,
    this.messageContainerPadding =
        const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
    this.scrollController,
    this.parsePatterns = const [],
    this.messageContainerDecoration,
    this.messages,
    this.user,
    this.showuserAvatar,
    this.dateFormat,
    this.timeFormat,
    this.showAvatarForEverMessage,
    this.onLongPressAvatar,
    this.onLongPressMessage,
    this.onPressAvatar,
    this.renderAvatarOnTop,
    this.renderMessageFooter,
    this.avatarBuilder,
    this.dateBuilder,
    this.changeVisible,
    this.messageImageBuilder,
    this.visible,
    this.showLoadMore,
  });

  @override
  _MessageListViewState createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Padding(
        padding: widget.messageContainerPadding,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          fit: StackFit.expand,
          children: [
            ListView.builder(
              controller: widget.scrollController,
              padding: EdgeInsets.all(0.0),
              shrinkWrap: true,
              reverse: true,
              itemCount: widget.messages.length,
              itemBuilder: (context, i) {
                final j = i + 1;

                bool first = false;
                bool last = false;
                bool showDate;

                /*  if (widget.messages.length == 0) {
                  first = true;
                } else if (widget.messages.length - 1 == i) {
                  last = true;
                }

               
                if (currentDate == null) {
                  currentDate = widget.messages[i].createdAt;
                  showDate = true;
                } else if (currentDate
                        .difference(widget.messages[i].createdAt)
                        .inDays !=
                    0) {
                  showDate = true;
                  currentDate = widget.messages[i].createdAt;
                } else {
                  showDate = false;
                }
 */
                return Align(
                  child: Column(
                    children: <Widget>[
                      /* if (showDate)
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0)),
                          padding: EdgeInsets.only(
                            bottom: 5.0,
                            top: 5.0,
                            left: 10.0,
                            right: 10.0,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            widget.dateFormat != null
                                ? widget.dateFormat.format(
                                    widget.messages[i].createdAt)
                                : DateFormat('MMM dd').format(
                                    widget.messages[i].createdAt),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ), */
                      Padding(
                        padding: EdgeInsets.only(
                          top: first ? 10.0 : 0.0,
                          bottom: last ? 10.0 : 0.0,
                        ),
                        child: Row(
                          mainAxisAlignment:
                              widget.messages[i].user.uid == widget.user.uid
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              width:
                                  widget.messages[i].user.uid == widget.user.uid
                                      ? MediaQuery.of(context).size.width * 0.04
                                      : 0.0,
                            ),
                            GestureDetector(
                              onLongPress: () {
                                if (widget.onLongPressMessage != null) {
                                  widget.onLongPressMessage(widget.messages[i]);
                                } else {
                                  showBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                ListTile(
                                                  leading:
                                                      Icon(Icons.content_copy),
                                                  title:
                                                      Text("Copy to clipboard"),
                                                  onTap: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: widget
                                                                .messages[i]
                                                                .text));
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            ),
                                          ));
                                }
                              },
                              child: MessageContainer(
                                isUser: widget.messages[i].user.uid ==
                                    widget.user.uid,
                                message: widget.messages[i],
                                messageImageBuilder: widget.messageImageBuilder,
                                timeFormat: widget.timeFormat,
                                messageContainerDecoration:
                                    widget.messageContainerDecoration,
                                parsePatterns: widget.parsePatterns,
                              ),
                            ),
                            SizedBox(
                              width:
                                  widget.messages[i].user.uid != widget.user.uid
                                      ? MediaQuery.of(context).size.width * 0.04
                                      : 0.0,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Container(
              height: 100.0,
            ),
            AnimatedPositioned(
              top: widget.showLoadMore ? 8.0 : -50.0,
              duration: Duration(milliseconds: 200),
              child: widget.isLoadingMore
                  ? SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                      ),
                    )
                  : LoadEarlierWidget(
                      onLoadEarlier: widget.onLoadEarlier,
                      defaultLoadCallback: widget.defaultLoadCallback,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
