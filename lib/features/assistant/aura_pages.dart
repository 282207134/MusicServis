import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/data/demo_data.dart';
import 'package:music_servis/shared/widgets.dart';

class AuraPage extends StatelessWidget {
  const AuraPage({super.key});

  void _openChat(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.auraChat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 16, 0),
              child: _AuraHeader(
                onClose: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  }
                },
              ),
            ),
            const SizedBox(height: 34),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: _AssistantBubble(
                text: 'Hello, Jane Foster.\nHere are songs for you now.',
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              height: 194,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemCount: DemoData.singles.length,
                separatorBuilder: (_, _) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final album = DemoData.singles[index];
                  return _LargeRecord(
                    album: album,
                    onTap: () => _openChat(context),
                  );
                },
              ),
            ),
            const Spacer(),
            Material(
              color: context.palette.background,
              child: InkWell(
                onTap: () => _openChat(context),
                child: Container(
                  width: double.infinity,
                  height: 66,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: context.palette.faint),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Ask me anything',
                    style: TextStyle(color: AppColors.muted, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuraChatPage extends StatefulWidget {
  const AuraChatPage({super.key});

  @override
  State<AuraChatPage> createState() => _AuraChatPageState();
}

class _AuraChatPageState extends State<AuraChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [
    const _ChatMessage('Find my favorite song)', true),
    const _ChatMessage('I think it will give you pleasure', false),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _replyFor(String text) {
    final query = text.toLowerCase();
    if (query.contains('hello') || query.contains('hi')) {
      return 'Hello, Jane. What would you like to hear?';
    }
    if (query.contains('rock')) {
      return 'I added a little rock energy to your mix.';
    }
    if (query.contains('favorite') || query.contains('favourite')) {
      return 'I found another song that matches your favorites.';
    }
    return 'Here is another song chosen for your mood.';
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final reply = _replyFor(text);
    setState(() {
      _messages.add(_ChatMessage(text, true));
      _messages.add(_ChatMessage(reply, false));
    });
    _controller.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 16, 0),
              child: _AuraHeader(
                onClose: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, AppRoutes.aura);
                  }
                },
              ),
            ),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(25, 32, 25, 20),
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: _AssistantBubble(
                      text: 'Hello, Jane Foster.\nHere are songs for you now.',
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: DemoData.singles.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 22),
                      itemBuilder: (_, index) => CoverImage(
                        asset: DemoData.singles[index].cover,
                        size: 58,
                        circle: true,
                        hole: true,
                      ),
                    ),
                  ),
                  ...List.generate(_messages.length, (index) {
                    final message = _messages[index];
                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 42 : 18),
                      child: message.isUser
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: _UserBubble(text: message.text),
                            )
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: index == 1
                                  ? const _AssistantRecommendation()
                                  : _AssistantBubble(text: message.text),
                            ),
                    );
                  }),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: context.palette.background,
                border: Border(top: BorderSide(color: context.palette.faint)),
              ),
              padding: const EdgeInsets.fromLTRB(25, 2, 10, 2),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: const InputDecoration(
                        hintText: 'Ask me anything',
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _send,
                    icon: const Icon(
                      Icons.send_rounded,
                      color: AppColors.cyan,
                      size: 21,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuraHeader extends StatelessWidget {
  const _AuraHeader({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AuraLogo(size: 60),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close, color: AppColors.muted, size: 30),
        ),
      ],
    );
  }
}

class _LargeRecord extends StatelessWidget {
  const _LargeRecord({required this.album, required this.onTap});

  final Album album;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            CoverImage(asset: album.cover, size: 130, circle: true, hole: true),
            const SizedBox(height: 13),
            Text(
              album.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 2),
            Text(
              album.artist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _AssistantBubble extends StatelessWidget {
  const _AssistantBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 290),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
        decoration: BoxDecoration(
          color: context.palette.faint,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * .7,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: appGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x29349EF2),
              blurRadius: 16,
              offset: Offset(0, 7),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class _AssistantRecommendation extends StatelessWidget {
  const _AssistantRecommendation();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 306),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: context.palette.faint,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'I think it will give you pleasure',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                const CoverImage(
                  asset: DemoData.saint,
                  size: 58,
                  circle: true,
                  hole: true,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Let Me Live My Life',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Saint Asonia',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                PlayButton(
                  size: 44,
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Playing Let Me Live My Life'),
                        ),
                      );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage(this.text, this.isUser);

  final String text;
  final bool isUser;
}
