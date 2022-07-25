create database if not exists StudentHealth;

drop user 'root'@'%';

create user 'root'@'%' identified by 'thisismypassword';

grant all on StudentHealth.* to 'root'@'%';

use StudentHealth;

CREATE TABLE IF NOT EXISTS exercise (
	exerciseid int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	exercisename VARCHAR(256) UNIQUE,
	exercisetype VARCHAR(128),
	metabolicequivalentscore DOUBLE
);

CREATE TABLE IF NOT EXISTS meditation (
	meditationid int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	meditationname VARCHAR(256) UNIQUE,
	meditationtype VARCHAR(128),
	audiolink VARCHAR(256) UNIQUE,
	imagelink VARCHAR(256)
);

CREATE TABLE IF NOT EXISTS student (
	studentid int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(256) UNIQUE,
	email VARCHAR(256) UNIQUE,
	school VARCHAR(256),
	weight DOUBLE
);


INSERT INTO exercise (exercisename, exercisetype, metabolicequivalentscore)
VALUES ('Slow Walking (1 to 2 mph)', 'Anaerobic', 2);

INSERT INTO exercise (exercisename, exercisetype, metabolicequivalentscore)
VALUES ('Brisk Walking (3.5 to 4 mph)', 'Aerobic', 5);

INSERT INTO exercise (exercisename, exercisetype, metabolicequivalentscore)
VALUES ('Fast Walking (4.5 to 5 mph)', 'Aerobic', 6.3);

INSERT INTO exercise (exercisename, exercisetype, metabolicequivalentscore)
VALUES ('Running (7 mph)', 'Aerobic', 11.5);

INSERT INTO exercise (exercisename, exercisetype, metabolicequivalentscore)
VALUES ('Light Weight Lifting', 'Anaerobic', 3.5);

INSERT INTO exercise (exercisename, exercisetype, metabolicequivalentscore)
VALUES ('Heavy Weight Lifting', 'Anaerobic', 5);

INSERT INTO exercise (exercisename, exercisetype, metabolicequivalentscore)
VALUES ('Soccer', 'Aerobic', 10);

CREATE TABLE IF NOT EXISTS userexercising (
	userexercisingid int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	studentid int,
    FOREIGN KEY (studentid) REFERENCES student(studentid),
	exerciseid int,
    FOREIGN KEY (exerciseid) REFERENCES exercise(exerciseid),
	startedat DATETIME,
	endedat DATETIME,
	totaltime int,
	caloriesburned DOUBLE
);

CREATE TABLE IF NOT EXISTS usermeditating (
	usermeditatingid int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	studentid int,
    FOREIGN KEY (studentid) REFERENCES student(studentid),
	meditationid int,
    FOREIGN KEY (meditationid) REFERENCES meditation(meditationid),
	startedat DATETIME,
	endedat DATETIME,
	totaltime int
);

CREATE TABLE IF NOT EXISTS passexercise (
	passexerciseid int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	exercisename VARCHAR(256),
	username VARCHAR(256),
	startedat VARCHAR(256),
	endedat VARCHAR(256),
	totaltime int,
	caloriesburned DOUBLE
);

CREATE TABLE IF NOT EXISTS passmeditation (
	massmeditationid int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	meditationname VARCHAR(256),
	username VARCHAR(256),
	startedat VARCHAR(256),
	endedat VARCHAR(256),
	totaltime int,
	soundused VARCHAR(256)
);

INSERT INTO meditation (meditationname, meditationtype, audiolink, imagelink)
VALUES ('Unguided metal fest', 'Unguided meditation', 'audio/MoriaSuffer.mp3', 'https://media.giphy.com/media/1gXJ0MrlsUBSQPq2kV/giphy-downsized-large.gif');

INSERT INTO meditation (meditationname, meditationtype, audiolink, imagelink)
VALUES ('Unguided ambient noise', 'Unguided meditation', 'https://luan.xyz/files/audio/ambient_c_motion.mp3', 'https://media.giphy.com/media/YhW0qsOoz8vb37vxFO/giphy.gif');

INSERT INTO meditation (meditationname, meditationtype, audiolink, imagelink)
VALUES ('Unguided nasa mission', 'Unguided meditation', 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3', 'https://media.giphy.com/media/RT3S8fkHUxECJJpwvT/giphy.gif');

INSERT INTO meditation (meditationname, meditationtype, audiolink, imagelink)
VALUES ('Guided mindfulness', 'Guided meditation', 'audio/Guided_Meditation_for_Deep_Relaxati.mp3', 'https://media.giphy.com/media/9WHE2bo5Na9Gg/giphy.gif');