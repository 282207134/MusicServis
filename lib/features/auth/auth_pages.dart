import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/shared/widgets.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.hello);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MusicAppBar(title: 'WELCOME'),
      body: _PageScroll(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
              const AuraLogo(size: 78),
              const SizedBox(height: 24),
              const Text(
                'Create an account and listen to\nyour favorite music on any device',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                decoration: const InputDecoration(hintText: 'Email'),
                validator: _validateEmail,
              ),
              const SizedBox(height: 20),
              _PasswordField(
                controller: _password,
                obscure: _obscurePassword,
                onToggle: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                validator: _validatePassword,
                onSubmitted: (_) => _register(),
              ),
              const SizedBox(height: 40),
              GradientButton(
                label: 'REGISTER',
                height: 60,
                onPressed: _register,
              ),
              const SizedBox(height: 38),
              const _OrDivider(),
              const SizedBox(height: 24),
              _SocialButtons(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.hello),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController(text: 'Jane Foster');
  final _password = TextEditingController(text: 'password');
  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _name.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.hello);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MusicAppBar(title: 'LOGIN'),
      body: _PageScroll(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              TextFormField(
                controller: _name,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                decoration: const InputDecoration(labelText: 'Name'),
                validator: _validateRequired,
              ),
              const SizedBox(height: 20),
              _PasswordField(
                controller: _password,
                obscure: _obscurePassword,
                onToggle: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                validator: _validateRequired,
                onSubmitted: (_) => _login(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password reset instructions sent'),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    foregroundColor: AppColors.muted,
                  ),
                  child: const Text(
                    'Forgotten password?',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: _rememberMe,
                    onChanged: (value) => setState(() => _rememberMe = value),
                    activeThumbColor: Colors.white,
                    activeTrackColor: AppColors.cyan,
                  ),
                  const SizedBox(width: 8),
                  const Text('Remember me?', style: TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 48),
              GradientButton(label: 'LOGIN', height: 60, onPressed: _login),
              const SizedBox(height: 38),
              const _OrDivider(),
              const SizedBox(height: 24),
              _SocialButtons(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.hello),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PageScroll(
        top: true,
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 56),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Center(child: AuraLogo(size: 100)),
            const SizedBox(height: 64),
            Text(
              'Hello, Jane Foster.\nMy name is Aura.',
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 24),
            Text(
              'I want to know your\nmusical taste.',
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(height: 1.4),
            ),
            const Spacer(),
            GradientButton(
              label: 'START',
              height: 60,
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.preferences),
            ),
          ],
        ),
      ),
    );
  }
}

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final _selected = <String>{'Alternative'};

  void _next() => Navigator.pushNamed(context, AppRoutes.preferenceSong);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PageScroll(
        top: true,
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 56),
        child: Column(
          children: [
            _PreferenceHeader(title: 'What do you love?', onSkip: _next),
            const SizedBox(height: 36),
            _GenreCloud(
              selected: _selected,
              onToggle: (genre) => setState(() {
                if (!_selected.remove(genre)) _selected.add(genre);
              }),
            ),
            const Spacer(),
            GradientButton(label: 'NEXT', height: 60, onPressed: _next),
          ],
        ),
      ),
    );
  }
}

class PreferenceSongPage extends StatefulWidget {
  const PreferenceSongPage({super.key});

  @override
  State<PreferenceSongPage> createState() => _PreferenceSongPageState();
}

class _PreferenceSongPageState extends State<PreferenceSongPage> {
  static const _songs = [
    _Song('Hallow Fate', 'Gin Wigmore', 'assets/images/hallow_fate.png'),
    _Song('Nice For What', 'Drake', 'assets/images/rescue_me.png'),
    _Song('Psycho', 'Post Malone', 'assets/images/carry_you.png'),
  ];

  final _liked = <String>{};
  int _index = 0;
  bool _playing = true;

  void _nextSong() {
    setState(() {
      _index = (_index + 1) % _songs.length;
      _playing = false;
    });
  }

  void _complete() =>
      Navigator.pushNamed(context, AppRoutes.preferencesComplete);

  @override
  Widget build(BuildContext context) {
    final song = _songs[_index];
    final liked = _liked.contains(song.title);
    final contentWidth = (MediaQuery.sizeOf(context).width - 48).clamp(
      0.0,
      430.0,
    );
    final coverSize = (contentWidth * .72).clamp(190.0, 280.0);
    return Scaffold(
      body: _PageScroll(
        top: true,
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
        child: Column(
          children: [
            _PreferenceHeader(title: 'How about this song?', onSkip: _complete),
            const Spacer(),
            CoverImage(
              asset: song.cover,
              size: coverSize,
              circle: true,
              hole: true,
            ),
            const SizedBox(height: 32),
            Text(song.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(song.artist, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 38),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _RoundIconButton(icon: Icons.close, onPressed: _nextSong),
                PlayButton(
                  playing: _playing,
                  size: 66,
                  onPressed: () => setState(() => _playing = !_playing),
                ),
                _RoundIconButton(
                  icon: liked ? Icons.favorite : Icons.favorite_border,
                  color: liked ? AppColors.pink : context.palette.ink,
                  onPressed: () => setState(() {
                    if (!_liked.remove(song.title)) _liked.add(song.title);
                  }),
                ),
              ],
            ),
            const Spacer(),
            GradientButton(label: 'NEXT', height: 56, onPressed: _complete),
          ],
        ),
      ),
    );
  }
}

class PreferencesCompletePage extends StatelessWidget {
  const PreferencesCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.cyan, AppColors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _PageScroll(
          top: true,
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 34),
          child: Column(
            children: [
              const Text(
                'Complete!',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(height: 80),
              const AuraLogo(size: 100, light: true),
              const SizedBox(height: 52),
              const Text(
                'Rebel',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              const SizedBox(height: 4),
              const Text(
                'You are an energetic and purposeful person\nwho needs downhole guitar reefs.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.25,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                ),
                child: const Text(
                  'VIEW RECOMMENDATIONS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: .4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageScroll extends StatelessWidget {
  const _PageScroll({
    required this.child,
    this.top = false,
    this.padding = const EdgeInsets.fromLTRB(24, 20, 24, 32),
  });

  final Widget child;
  final bool top;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: padding,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: IntrinsicHeight(child: child),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.obscure,
    required this.onToggle,
    required this.validator,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;
  final String? Function(String?) validator;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      autocorrect: false,
      enableSuggestions: false,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.muted,
            size: 20,
          ),
        ),
      ),
      validator: validator,
      onFieldSubmitted: onSubmitted,
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFD8DDE0))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Text('or', style: TextStyle(color: AppColors.muted)),
        ),
        Expanded(child: Divider(color: Color(0xFFD8DDE0))),
      ],
    );
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SocialButton(
            label: 'Google',
            icon: const Text(
              'G',
              style: TextStyle(
                color: AppColors.blue,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _SocialButton(
            label: 'Facebook',
            icon: const Icon(
              Icons.facebook,
              color: Color(0xFF3B5998),
              size: 24,
            ),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18349EF2),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 9),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreferenceHeader extends StatelessWidget {
  const _PreferenceHeader({required this.title, required this.onSkip});

  final String title;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        ),
        TextButton(
          onPressed: onSkip,
          style: TextButton.styleFrom(foregroundColor: AppColors.muted),
          child: const Text('skip', style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }
}

class _GenreCloud extends StatelessWidget {
  const _GenreCloud({required this.selected, required this.onToggle});

  static const _bubbles = [
    _GenreBubble('Alternative', .17, .10, .44, [
      Color(0xFF66648B),
      Color(0xFF4A2E67),
    ]),
    _GenreBubble('Rock', .64, .26, .29, [Color(0xFF51447D), AppColors.cyan]),
    _GenreBubble('Metal', .08, .48, .32, [
      Color(0xFFF43F78),
      Color(0xFFFF758F),
    ]),
    _GenreBubble('Blues', .42, .44, .32, [
      Color(0xFFFAD18A),
      Color(0xFFF58D84),
    ]),
    _GenreBubble('Rap', .73, .66, .28, [AppColors.cyan, AppColors.blue]),
    _GenreBubble('Jazz', .58, .00, .23),
    _GenreBubble('Punk', .00, .34, .23),
    _GenreBubble('Pop', .35, .75, .21),
    _GenreBubble('R&B', .80, .45, .22),
    _GenreBubble('Electronics', .00, .69, .24),
  ];

  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: .95,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          return Stack(
            children: [
              for (final bubble in _bubbles)
                Positioned(
                  left: width * bubble.x,
                  top: height * bubble.y,
                  width: width * bubble.size,
                  height: width * bubble.size,
                  child: _Bubble(
                    data: bubble,
                    selected: selected.contains(bubble.name),
                    onTap: () => onToggle(bubble.name),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final _GenreBubble data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colored = data.colors != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: selected ? 1.04 : 1,
        duration: const Duration(milliseconds: 160),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colored ? null : context.palette.faint,
            gradient: colored ? LinearGradient(colors: data.colors!) : null,
            border: selected ? Border.all(color: Colors.white, width: 3) : null,
            boxShadow: [
              BoxShadow(
                color: selected
                    ? const Color(0x40349EF2)
                    : const Color(0x18349EF2),
                blurRadius: selected ? 20 : 12,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: FittedBox(
                  child: Text(
                    data.name,
                    style: TextStyle(
                      color: colored ? Colors.white : AppColors.muted,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              if (selected)
                const Positioned(
                  top: 9,
                  right: 9,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Icon(Icons.check, color: AppColors.cyan, size: 13),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onPressed,
    this.color,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: context.palette.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x26349EF2),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color ?? context.palette.ink, size: 27),
      ),
    );
  }
}

class _GenreBubble {
  const _GenreBubble(this.name, this.x, this.y, this.size, [this.colors]);

  final String name;
  final double x;
  final double y;
  final double size;
  final List<Color>? colors;
}

class _Song {
  const _Song(this.title, this.artist, this.cover);

  final String title;
  final String artist;
  final String cover;
}

String? _validateRequired(String? value) {
  if (value == null || value.trim().isEmpty) return 'This field is required';
  return null;
}

String? _validateEmail(String? value) {
  if (_validateRequired(value) != null) return 'Enter your email';
  if (!value!.contains('@') || !value.contains('.')) {
    return 'Enter a valid email';
  }
  return null;
}

String? _validatePassword(String? value) {
  if (value == null || value.length < 6) return 'Use at least 6 characters';
  return null;
}
