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

// Get committee title
List<String> get cTitle {
  List<String> list = List<String>();

  list.add('Developers');
  list.add('Digital Marketing');
  list.add('Human Resources (HR)');
  list.add('Geeks');
  list.add('Logistics');
  list.add('Media');
  list.add('Public Relations (PR)');
  list.add('FR');

  return list;
}


// Get committee image
List<String> get cImage {
  List<String> list = List<String>();

  list.add('assets/images/developers.png');
  list.add('assets/images/marketing.png');
  list.add('assets/images/hr.png');
  list.add('assets/images/geeks.png');
  list.add('assets/images/logistics.png');
  list.add('assets/images/media.png');
  list.add('assets/images/pr.png');
  list.add('assets/images/supervisors.png');

  return list;
}

List<String> get cDescription {
  List<String> list = List<String>();

  //! Developers !//
  list.add(r"""
The developers committee is divided into three sections :-

1. **The Web Committee**, which is the committee that creates websites in many different forms and ideas, using design languages ​​like HTML & CSS and others, and programming languages ​​such as JavaScript, Node JS & PHP, etc.
And it is divided into two parts
    - *Front-End Developer*
    - *Back-End Developer*

2. **The Mobile Application Committee**, and it is the committee that makes many applications with different ideas and by using many programming languages ​​and libraries such as the Flutter Library

3. **Testing Committee**, and it is a committee that performs a check on the applications and websites in a manual way until you discover any Bugs so that all projects are properly presented.
  """);

  //! Digital Marketing !//
  list.add(r"""
They are in charge of planning and managing marketing campaigns that promote MSP's brand, Events, and services. Their duties include planning campaigns, content creation, introduction of the new online tools, and identifying trends.

They typically have experience in content creation and social media platforms, so they are on two teams:

- **Social Media Team**.

  This team is responsible for Managing and the moderation of our pages on different platforms (Facebook, Instagram, LinkedIn, ...).

  Also they responsible for planing our events and used tools, catching the trends, and branding our identity.

- **Content Creation Team**.

  They are the who is responsible for converting our theme and Plans on a written copy.

  Transforming ideas into a suitable content which differ from any platform and anothers.

	

	

***"They Work on the darkness to Serve the light"***
 
 
  """);

  //! Human Resources (HR) !//
  list.add(r"""
Here we meet a lot of challenges. 

We deal with all of them, in HR committee we deal with team members, to achieve goals of committees and goals of team. 

We are responsible for coordinating between Heads and their members, and among all committees. 

We are also responsible for recruitment and selection, evaluating members in addition to participants and tracking their progress too. 

We have to motivate them else. If you are in HR committee you will learn a lot. 

HR coordinators always seek improvement.
  """);

  //! Geeks !//
  list.add(r"""
**One of the technical committees. Found before as "IT committee". It contains six tracks as follows:**  
  
**1. Java**  
  
Java is a general-purpose programming language that is class-based, object-oriented, and designed to have as few implementation dependencies as possible. It is intended to let application developers write once, run anywhere (WORA),meaning that compiled Java code can run on all platforms that support Java without the need for recompilation.Java applications are typically compiled to bytecode that can run on any Java virtual machine (JVM) regardless of the underlying computer architecture.  
  
**2. Embedded Systems**  
  
An embedded system is a combination of computer hardware and software designed for a specific function or functions within a larger system. The systems can be programmable or with fixed functionality. Industrial machines, consumer electronics, agricultural and process industry devices, automobiles, medical equipment, cameras, household appliances, airplanes, vending machines and toys, as well as mobile devices, are possible locations for an embedded system.  
  
**3. Network**  
  
A network engineer is a technology professional who is highly skilled in maintaining the connectivity of networks in terms of data, voice, calls, videos and wireless network services. These network engineers are also referred to as network architects.Our Network engineering description includes being accountable for formulating, implementing and executing the entirety of computer networks within an organization.  
  
Additionally, our network engineering description addresses their role making sure all the systems are functioning properly as intended. The fundamental goal of a network engineer is to provide maximum network infrastructure, security and performance to the end users. Depending on an organization’s requirement or network complexity, the organization will sometimes have global network engineers across countries who take care of technological advancements throughout the firm. This international web of engineers proves cost-effective for the organization while also meeting needs for users and the business.  
  
**4. DataBase**  
  
A database is an organized collection of structured information, or data, typically stored electronically in a computer system. A database is usually controlled by a database management system (DBMS). Together, the data and the DBMS, along with the applications that are associated with them, are referred to as a database system, often shortened to just database.  
  
Data within the most common types of databases in operation today is typically modeled in rows and columns in a series of tables to make processing and data querying efficient. The data can then be easily accessed, managed, modified, updated, controlled, and organized. Most databases use structured query language (SQL) for writing and querying data.  
  
**5. AI**  
  
An artificial intelligence engineer is an individual who works with traditional machine learning techniques like natural language processing and neural networks to build models that power AI–based applications.  
  
The type of applications created by AI engineers include:
  - Contextual advertising based on sentiment analysis.
  - Language translation.
  - Visual identification or perception.
  
	

**6. Security**  
  
Security engineering is the field of engineering dealing with the security and integrity of real-world systems.  
  
It is similar to systems engineering in that its motivation is to make a system meet requirements, but with the added dimension of enforcing a security policy.  
  
It has existed as an informal field for centuries, in the fields of locksmithing and security printing.  
  
Technological advances, principally in the field of computers, have now allowed the creation of far more complex systems, with new and complex security problems.  
  
Because modern systems cut across many areas of human endeavor, security engineers not only need consider the mathematical and physical properties of systems; they also need to consider attacks on the people who use and form parts of those systems using social engineering attacks.  
  
Secure systems have to resist not only technical attacks, but also coercion, fraud, and deception by confidence tricksters.  
  
For this reason it involves aspects of social science, psychology and economics, as well as physics, chemistry and mathematics.  
  
Some of the techniques used, such as fault tree analysis, are derived from safety engineering.  
  
	
  
	
  
**The committee contributes to explaining its specializations during the camps and training workshops in addition to the ICDL throughout the semester**
    """);

  //! Logisics !//
  list.add(r"""
The committee contributes to the organization of meetings of the team through the preparation of the necessary giveaway, also organizing events.

This committee is responsible for supplies, it contributes to the optimal use of availabe financial resources and provide logistic needs.

Premaring gifts from the simplest tools wih the best quality, cityning for community 
  """);

  //! Media !//
  list.add(r"""
There are effective more than we can actually imagine, with every word, every thought, every little perfect thing that our eyes can capture and every creative idea that comes up to our minds, so media committee is a place for those ones who you can be creative and to think out of the box!

Responsibilities became after MSP'20 season include: 
  - Graphic Design 
  - Illustration 
  - Video Editing 
  - Photo/Videography 
  - Motion Graphics 
  - Scriptwriting 
  - VO and more.
  """);

  //! Public Relations (PR) !//
  list.add(r"""
Public Relations Committee is considered as the bridge between the team & any other outer party. Students, VIP or Media.

This communication helps spreading the awareness about the team & it's vision besides contributing to achieve it.
  """);

  //! FR !//
  list.add(r"""
FR is acronym for fundraising and it's part of of non -profit marketing.

It is a process that aims to provide support to non -profit institutions and activities for students or even your own project whether it is material or non-material support to achieve the goals of the institution.
    """);

  return list;
}


// Background colors
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
