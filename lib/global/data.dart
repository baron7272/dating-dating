List slideList = [
  {
    "name": "Artifat",
    "image": "assets/images/people.jpg",
    "me": true,
    "group": true,
  },
  {
    "name": "MaryAnn",
    "age": "30",
    "username": "annie",
    "image": "assets/images/img1.jpg",
    "me": false,
    "group": false,
  },
  {
    "name": "Jenna",
    "age": "18",
    "username": "jennie",
    "image": "assets/images/img2.jpg",
    "me": true,
    "group": false,
  },
  {
    "name": "Annie",
    "age": "19",
    "username": "annie22",
    "image": "assets/images/img3.jpg",
    "me": false,
    "group": false,
  },
  {
    "name": "Gracie",
    "age": "39",
    "username": "gracies",
    "image": "assets/images/img4.jpg",
    "me": true,
    "group": false,
  },
];

List group = [
  {
    "name": "May",
    "image": "assets/images/img5.jpg",
    "age": "30",
  },
  {
    "name": "MaryAnn",
    "age": "30",
    "image": "assets/images/img1.jpg",
  },
  {
    "name": "Jenna",
    "age": "18",
    "image": "assets/images/img2.jpg",
  },
  {
    "name": "Annie",
    "age": "19",
    "image": "assets/images/img3.jpg",
  },
  {
    "name": "Gracie",
    "age": "39",
    "image": "assets/images/img4.jpg",
  },
];

List<String> gender = ['Female', 'Male', 'Others'];
List<String> religion = ['Christain', 'Muslim', 'Others'];
List<String> politics = ['Democrat', 'Republican', 'Others'];
List<String> color = ['Black', 'White', 'Others'];
List<String> level = ['No', 'Low', 'Medium', 'High'];
List<String> zodiac = ['Pisces', 'White', 'Others'];
List<String> relationship = ['Casual', 'Exclusive', 'Others'];

enum ChatSettings { clear, settings,edit,exit,invite,share,block }
List<String> occupation = [
  'Student',
  'smile',
  'seat',
  'hello',
  'happy',
  'dance',
  'jump',
  'clap',
  'rope',
  'flip',
  'ribs',
  'head'
];

List chatData = [
  {
    'text': 'Hi',
    'me': false,
    'isImage': false,
  },
  {
    'text': 'Hello',
    'me': true,
    'seen': true,
    'isImage': false,
  },
  {
    'text': 'How are you today?',
    'me': true,
    'seen': true,
    'isImage': false,
  },
  {
    'text': 'Am doing ok',
    'me': false,
    'isImage': false,
  },
  {
    'text':
        'Just want to update you that i have the sample image like we discussed',
    'me': false,
    'isImage': false,
  },
  {
    'image': 'assets/images/people.jpg',
    'me': false,
    'isImage': true,
  },
  {
    'text': 'This is really nice Chloe',
    'me': true,
    'seen': false,
    'isImage': false,
  },
  {
    'image': 'assets/images/img3.jpg',
    'me': true,
    'seen': false,
    'isImage': true,
  },
];
