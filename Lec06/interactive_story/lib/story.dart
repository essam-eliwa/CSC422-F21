class Story {
  String storyText;
  String choice1;
  String choice2;
  String choice3;
  Story({
    required this.storyText,
    required this.choice1,
    required this.choice2,
    required this.choice3,
  });
}

class IStoryData {
  int storyLevel = 0;
  List<Story> storyDB = [
    Story(
        //0
        storyText: 'You see a ship in the ocean',
        choice1: 'Go aboard the ship',
        choice2: 'Look for another adventure',
        choice3: 'Just go home'),
    Story(
        //1
        storyText: 'It is a pirate ship',
        choice1: 'Wow, an amazing adventure',
        choice2: 'Run back home',
        choice3: 'Call the police'),
    Story(
        //2
        storyText: 'Enter dark forest',
        choice1: 'Yes',
        choice2: 'Run back home',
        choice3: 'Restart'),
    Story(
        //3
        storyText: 'You are adventurous, \n but watch your moral campus',
        choice1: "Restart",
        choice2: '',
        choice3: ''),
    Story(
        //4
        storyText: 'You are so brave',
        choice1: "Restart",
        choice2: '',
        choice3: ''),
    Story(
        //5
        storyText: 'This is a great option \n you should never join pirates',
        choice1: 'Look for another adventure',
        choice2: 'Restart',
        choice3: ''),
    Story(
        //6
        storyText: 'You need to explore more',
        choice1: "Restart",
        choice2: '',
        choice3: ''),
  ];

  List getStory() {
    return [
      storyDB[storyLevel].storyText,
      storyDB[storyLevel].choice1,
      storyDB[storyLevel].choice2,
      storyDB[storyLevel].choice3
    ];
  }

  void nextStory(int choice) {
    if (choice == 1 && storyLevel == 0) {
      storyLevel = 1;
    } else if (choice == 2 && storyLevel == 0) {
      storyLevel = 2;
    } else if (choice == 3 && storyLevel == 0) {
      storyLevel = 6;
    } else if (choice == 1 && storyLevel == 1) {
      storyLevel = 3;
    } else if (choice == 2 && storyLevel == 1) {
      storyLevel = 6;
    } else if (choice == 3 && storyLevel == 1) {
      storyLevel = 5;
    } else if (choice == 1 && storyLevel == 2) {
      storyLevel = 4;
    } else if (choice == 2 && storyLevel == 2) {
      storyLevel = 6;
    } else if (choice == 3 && storyLevel == 2) {
      restartGame();
    } else if (storyLevel >= 3) {
      restartGame();
    }
    print('Story Level $storyLevel');
  }

  void restartGame() {
    storyLevel = 0;
  }

  bool isVisible() {
    return !(storyLevel >= 3);
  }
}
