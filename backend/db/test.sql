
USE quiz_rally;
INSERT INTO `quiz`(`quizID`, `problem`, `answer`, `type`) VALUES
(0, "1+1は？", "田", 0),
(1, "天照大神、月読命、素戔嗚尊、この三柱をまとめて何という？", "三貴子", 0),
(2, "世はまさに大航海時代", "test.pt", 1);

INSERT INTO `correct_answer`(`userID`, `quizID`) SELECT "aller", quizID FROM `quiz`;
INSERT INTO `correct_answer`(`userID`, `quizID`) VALUES ("onetwo", 2), ("onetwo", 1);
