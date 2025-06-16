
DROP DATABASE IF EXISTS quiz_rally;
CREATE DATABASE quiz_rally;
USE quiz_rally;

-- 画像がanswerの時はanswerはモデル名を保存
-- type: 0:文字列が答え, 1:画像が答え
CREATE TABLE `quiz` (
  `quizID` SMALLINT PRIMARY KEY,
  `problem` VARCHAR(512) NOT NULL,
  `answer` VARCHAR(64) NOT NULL,
  `type` TINYINT NOT NULL
);

-- userID=([a-z]|[A-Z]|[0-9]){16}
CREATE TABLE `correct_answer` (
  `userID` VARCHAR(16),
  `quizID` SMALLINT,
  `time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX user_id_index(`userID`),
  FOREIGN KEY (`quizID`) REFERENCES `quiz`(`quizID`) ON UPDATE CASCADE
);

