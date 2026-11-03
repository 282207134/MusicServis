class Track {
  const Track(this.title, this.artist, this.cover, [this.duration = '3:05']);

  final String title;
  final String artist;
  final String cover;
  final String duration;
}

class Album {
  const Album(this.title, this.artist, this.cover, [this.year = '2018']);

  final String title;
  final String artist;
  final String cover;
  final String year;
}

abstract final class DemoData {
  static const saint = 'assets/images/saint_asonia.png';
  static const ember = 'assets/images/ember.png';
  static const imagine = 'assets/images/imagine_dragons.png';

  static const tracks = [
    Track('Nice For What', 'Drake', 'assets/images/rescue_me.png', '4:22'),
    Track(
      'Psycho',
      'Post Malone feat. Ty Dolla Sign',
      'assets/images/carry_you.png',
      '3:41',
    ),
    Track(
      'Never Be The Same',
      'Camila Cabello',
      'assets/images/heart_shaped_box.png',
      '3:47',
    ),
    Track('Mine', 'Bazzi', 'assets/images/backbone.png', '2:14'),
    Track(
      'Powerglide',
      'Rae Sremmurd feat. Juicy J',
      'assets/images/numb.png',
      '5:34',
    ),
    Track(
      'One Kiss',
      'Calvin Harris & Dua Lipa',
      'assets/images/hugsja.png',
      '3:34',
    ),
    Track(
      'X (Spanglish Version)',
      'Nicky Jam x J Balvin',
      'assets/images/piece_of_me.png',
      '2:57',
    ),
    Track(
      'Friends',
      'Marshmello & Anne-Marie',
      'assets/images/route_one.png',
      '3:22',
    ),
    Track(
      'Remind Me To Forget',
      'Kygo & Miguel',
      'assets/images/dark_before_dawn.png',
      '3:37',
    ),
    Track(
      'No Tears Left To Cry',
      'Ariana Grande',
      'assets/images/dear_agony.png',
      '3:25',
    ),
  ];

  static const singles = [
    Album('Rescue Me', 'Thirty Seconds to Mars', 'assets/images/rescue_me.png'),
    Album('Carry You', 'Ruelle, Fleurie', 'assets/images/carry_you.png'),
    Album(
      'Heart-Shaped Box',
      'Ramin Djawadi',
      'assets/images/heart_shaped_box.png',
    ),
    Album('Backbone', 'Daughtry', 'assets/images/backbone.png'),
    Album('Numb', 'Meg Myers', 'assets/images/numb.png'),
    Album(
      'Hug sjá',
      'Ivar Bjornson & Einar Selvik',
      'assets/images/hugsja.png',
    ),
    Album(
      'Piece Of Me',
      'Bullet For My Valentine',
      'assets/images/piece_of_me.png',
    ),
    Album('Route One', 'Sigur Rós', 'assets/images/route_one.png'),
  ];

  static const albums = [
    Album('Epitaph', 'God Is an Astronaut', 'assets/images/epitaph.png'),
    Album(
      'When Legends Rise',
      'Godsmack',
      'assets/images/when_legends_rise.png',
    ),
    Album('Vortex', 'Toundra', 'assets/images/vortex.png'),
    Album(
      'Last Man Standing',
      'Willie Nelson',
      'assets/images/last_man_standing.png',
    ),
    Album(
      'With the 21st Century...',
      'Foreigner',
      'assets/images/with_the_21st_century.png',
    ),
    Album('Big Things', 'Skindred', 'assets/images/big_things.png'),
  ];

  static const emberTracks = [
    'Lyra',
    'Feed the Wolf',
    'Red Cold River',
    'Tourniquet',
    'Psycho',
    'The Dark of You',
    'Down',
    'Torn in Two',
    'Blood',
    'Save Yourself',
    'Close Your Eyes',
    'Vega',
  ];

  static const popularTracks = [
    Track(
      'Angels Fall',
      'Dark Before Dawn',
      'assets/images/dark_before_dawn.png',
      '3:48',
    ),
    Track(
      'Failure',
      'Dark Before Dawn',
      'assets/images/dark_before_dawn.png',
      '3:34',
    ),
    Track(
      'So Cold',
      'We Are Not Alone',
      'assets/images/dear_agony.png',
      '3:05',
    ),
    Track('Red Cold River', 'Ember', ember, '3:38'),
    Track('Blood', 'Ember', ember, '4:01'),
  ];

  static const eventTracks = [
    Track('Whatever It Takes', 'Evolve', imagine, '3:21'),
    Track('Believer', 'Evolve', imagine, '3:24'),
    Track('Born To Be Yours', 'Evolve', imagine, '3:13'),
    Track('Thunder', 'Evolve', imagine, '3:07'),
  ];

  static const genres = [
    'Rock',
    'Rock and roll',
    'Progressive',
    'Post-rock',
    'New Wave',
    'Folk-rock',
    'Stoner',
    'Hard',
    'Dancing',
    'Electronics',
    'R&B',
    'Rap and hip-hop',
    'Reggae',
    'Jazz',
    'Blues',
    'Ska',
    'Punk',
    'Stage',
    'Classic',
    'Chanson',
    'Country',
    'Light music',
    'Art song',
    'Soundtracks',
    'Nursery',
    'World music',
  ];

  static const lyrics = [
    'I am scared of the face in the mirror',
    'All the cracks in the glass, getting clearer',
    'I always overthink make it so hard',
    'On no one else but myself',
    '',
    'Let me live my life',
    'I can go get my knife',
    'Or I can pull out the one that you stuck in my back',
    'For my suffering, you\'ve got nothing to gain',
    'My pain is your entertainment',
    '',
    'I feel the fear in my head, it\'s so heavy',
    'Holding down both my hands to keep them steady',
    'On myself, no one else',
    'When I stop shaking, everything\'s so easy',
    'Let me live my life',
    'I can go get my knife',
    'Or I can pull out the one that you stuck in my back',
    'For my suffering, you\'ve got nothing to gain',
    'My pain is your entertainment',
  ];
}
