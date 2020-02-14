import 'package:flutter/material.dart';

class Committee {
  final int id;
  final String title;
  final String image;
  final String description;
  final Color color;

  Committee({
    this.id,
    this.title,
    this.image,
    this.description,
    this.color,
  });
}

final List<String> cTitle = [
  'Developers',
  'Digital Marketing',
  'Human Resources (HR)',
  'Geeks',
  'Logistics',
  'Media',
  'Public Relations (PR)',
  'Supervisors'
];

final List<String> cImage = [
  'assets/images/developers.png',
  'assets/images/marketing.png',
  'assets/images/hr.png',
  'assets/images/geeks.png',
  'assets/images/logistics.png',
  'assets/images/media.png',
  'assets/images/pr.png',
  'assets/images/supervisors.png'
];

final List<String> cDescription = [
  /* Developers */
  'Developers desc...\n\n' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aenean et tortor at risus viverra adipiscing at in tellus.\n\n' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\n ' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Diam ut venenatis tellus in. Congue quisque egestas diam in arcu cursus euismod. Leo in vitae turpis massa sed. Nam at lectus urna duis convallis convallis tellus. Mattis enim ut tellus elementum. Vitae ultricies leo integer malesuada nunc vel risus commodo. Ac placerat vestibulum lectus mauris ultrices eros in cursus turpis. A pellentesque sit amet porttitor eget dolor morbi non. Ultrices neque ornare aenean euismod elementum nisi quis eleifend. Consequat ac felis donec et odio pellentesque diam. Sem et tortor consequat id porta. Diam vulputate ut pharetra sit amet. Donec enim diam vulputate ut pharetra sit amet aliquam id.',

  /* Digital Marketing */
  'Digital Marketing team.\n' +
      'They are in charge of planning and managing marketing campaigns that promote MSP\'s brand, Events, and services. Their duties include planning campaigns, content creation, introduction of the new online tools, and identifying trends.\n\n' +
      //
      'They typically have experience in content creation and social media platforms, so they are on two teams\n\n' +
      //
      '- Social Media Team.\n' +
      'This team is responsible for Managing and the moderation of our pages on different platforms (Facebook, Instagram, LinkedIn soon,...).\n' +
      'Also they responsible for planing our events and used tools, catching the trends, and branding our identity.\n\n' +
      //
      '- Content Creation Team.\n' +
      'They are the who is responsible for converting our theme and Plans on a written copy.\n' +
      'Transforming ideas into a suitable content which differ from any platform and anothers.\n\n' +
      //
      '\"They Work on the darkness to Serve the light\"',

  /* Human Resources (HR) */
  'Here we meet a lot of challenges. We deal with all of them, in HR committee we deal with team members, to achieve goals of committees and goals of team. We are responsible for coordinating between Heads and their members, and among all committees. We are also responsible for recruitment and selection, evaluating members in addition to participants and tracking their progress too. We have to motivate them else. If you are in HR committee you will learn a lot. HR coordinators always seek improvement.',

  /* Geeks */
  'Geeks desc...\n\n' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aenean et tortor at risus viverra adipiscing at in tellus.\n\n' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\n ' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Diam ut venenatis tellus in. Congue quisque egestas diam in arcu cursus euismod. Leo in vitae turpis massa sed. Nam at lectus urna duis convallis convallis tellus. Mattis enim ut tellus elementum. Vitae ultricies leo integer malesuada nunc vel risus commodo. Ac placerat vestibulum lectus mauris ultrices eros in cursus turpis. A pellentesque sit amet porttitor eget dolor morbi non. Ultrices neque ornare aenean euismod elementum nisi quis eleifend. Consequat ac felis donec et odio pellentesque diam. Sem et tortor consequat id porta. Diam vulputate ut pharetra sit amet. Donec enim diam vulputate ut pharetra sit amet aliquam id.',

  /* Logisics */
  'Logisics desc...\n\n' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aenean et tortor at risus viverra adipiscing at in tellus.\n\n' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\n ' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Diam ut venenatis tellus in. Congue quisque egestas diam in arcu cursus euismod. Leo in vitae turpis massa sed. Nam at lectus urna duis convallis convallis tellus. Mattis enim ut tellus elementum. Vitae ultricies leo integer malesuada nunc vel risus commodo. Ac placerat vestibulum lectus mauris ultrices eros in cursus turpis. A pellentesque sit amet porttitor eget dolor morbi non. Ultrices neque ornare aenean euismod elementum nisi quis eleifend. Consequat ac felis donec et odio pellentesque diam. Sem et tortor consequat id porta. Diam vulputate ut pharetra sit amet. Donec enim diam vulputate ut pharetra sit amet aliquam id.',

  /* Media */
  'Media desc...\n\n' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aenean et tortor at risus viverra adipiscing at in tellus.\n\n' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\n ' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Diam ut venenatis tellus in. Congue quisque egestas diam in arcu cursus euismod. Leo in vitae turpis massa sed. Nam at lectus urna duis convallis convallis tellus. Mattis enim ut tellus elementum. Vitae ultricies leo integer malesuada nunc vel risus commodo. Ac placerat vestibulum lectus mauris ultrices eros in cursus turpis. A pellentesque sit amet porttitor eget dolor morbi non. Ultrices neque ornare aenean euismod elementum nisi quis eleifend. Consequat ac felis donec et odio pellentesque diam. Sem et tortor consequat id porta. Diam vulputate ut pharetra sit amet. Donec enim diam vulputate ut pharetra sit amet aliquam id.',

  /* Public Relations (PR) */
  'Public Relations Committee is considered as the bridge between the team & any other outer party. Students, VIP or Media.' +
      '\nThis communication helps spreading the awareness about the team & it\'s vision besides contributing to achieve it.',

  /* Supervisors */
  'Supervisor desc...\n\n' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aenean et tortor at risus viverra adipiscing at in tellus.\n\n' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\n ' +
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Diam ut venenatis tellus in. Congue quisque egestas diam in arcu cursus euismod. Leo in vitae turpis massa sed. Nam at lectus urna duis convallis convallis tellus. Mattis enim ut tellus elementum. Vitae ultricies leo integer malesuada nunc vel risus commodo. Ac placerat vestibulum lectus mauris ultrices eros in cursus turpis. A pellentesque sit amet porttitor eget dolor morbi non. Ultrices neque ornare aenean euismod elementum nisi quis eleifend. Consequat ac felis donec et odio pellentesque diam. Sem et tortor consequat id porta. Diam vulputate ut pharetra sit amet. Donec enim diam vulputate ut pharetra sit amet aliquam id.',
];

final List<Color> cColor = [
  Color(0xFF3e9fd9),
  Color(0xFFf5a64a),
  Color(0xFF16b4ad),
  Color(0xFF357db4),
  Color(0xFF2b3a47),
  Color(0xFFc72b4f),
  Color(0xFF33484E),
  Color(0xFF576574),
];
