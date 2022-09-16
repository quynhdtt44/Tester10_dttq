DROP DATABASE IF EXISTS Testing_System_Assignment_1;
CREATE DATABASE Testing_System_Assignment_1;
USE Testing_System_Assignment_1;

CREATE TABLE Department (
department_id 		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
department_name 	VARCHAR(50)
);

CREATE TABLE `Position` (
position_id 		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
position_name 		ENUM('Dev','Test','Scrum Master','PM')
);

CREATE TABLE `Account` (
account_id 			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
email 				VARCHAR(30) NOT NULL UNIQUE KEY,
user_name 			VARCHAR(30) NOT NULL UNIQUE KEY,
full_name 			VARCHAR(30),
department_id 		SMALLINT UNSIGNED NOT NULL,
position_id 		SMALLINT UNSIGNED NOT NULL,
create_date 		DATE,
FOREIGN KEY (department_id) REFERENCES Department(department_id),
FOREIGN KEY (position_id) REFERENCES `Position`(position_id)
);

CREATE TABLE `Group` (
group_id 			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
group_name 			VARCHAR(50),
creator_id 			INT UNSIGNED NOT NULL,
create_date 		DATE,
FOREIGN KEY (creator_id) REFERENCES `Account`(account_id)
);

CREATE TABLE GroupAccount (
group_id 			SMALLINT UNSIGNED,
account_id 			INT UNSIGNED NOT NULL,
join_date 			DATE,
PRIMARY KEY (group_id, account_id),
FOREIGN KEY (group_id) REFERENCES `Group`(group_id),
FOREIGN KEY (account_id) REFERENCES `Account`(account_id)
);

CREATE TABLE TypeQuestion (
type_id 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
type_name 			ENUM('Essay','Multiple-Choice')
);

CREATE TABLE CategoryQuestion (
category_id 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
category_name 		VARCHAR(30)
);

CREATE TABLE Question (
question_id 		MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
content 			VARCHAR(200) NOT NULL,
category_id 		INT UNSIGNED NOT NULL,
type_id 			TINYINT UNSIGNED NOT NULL,
creator_id 			INT UNSIGNED NOT NULL,
create_date 		DATE,
FOREIGN KEY (category_id)  REFERENCES CategoryQuestion(category_id),
FOREIGN KEY (creator_id) REFERENCES `Account`(account_id)
);

CREATE TABLE Answer (
answer_id 			MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
content 			VARCHAR(200),
question_id 		MEDIUMINT UNSIGNED NOT NULL,
is_correct 			BOOLEAN,
FOREIGN KEY (question_id)  REFERENCES Question(question_id)
);

CREATE TABLE Exam (
exam_id 			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`code` 				CHAR(20) NOT NULL,
title 				VARCHAR(30) NOT NULL,
category_id 		INT UNSIGNED NOT NULL,
duration 			TIME,
creator_id 			INT UNSIGNED NOT NULL,
create_date 		DATE,
FOREIGN KEY (category_id)  REFERENCES CategoryQuestion(category_id),
FOREIGN KEY (creator_id) REFERENCES `Account`(account_id)
);

CREATE TABLE ExamQuestion (
exam_id 			SMALLINT UNSIGNED NOT NULL,
question_id 		MEDIUMINT UNSIGNED NOT NULL,
PRIMARY KEY (exam_id, question_id),
FOREIGN KEY (exam_id)  REFERENCES Exam(exam_id),
FOREIGN KEY (question_id)  REFERENCES Question(question_id)
);