create database if not exists StudentHealth;

use StudentHealth;

CREATE TABLE IF NOT EXISTS exercise (
    exercise_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    exercise_name VARCHAR(256) UNIQUE,
    exercise_type VARCHAR(128),
    metabolic_equivalent_score DOUBLE,
    exercise_video_link VARCHAR(256) UNIQUE
    );

CREATE TABLE IF NOT EXISTS meditation (
    meditation_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    meditation_name VARCHAR(256) UNIQUE,
    meditation_type VARCHAR(128),
    meditation_sound_link VARCHAR(256) UNIQUE
    );

CREATE TABLE IF NOT EXISTS student (
    student_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(256) UNIQUE,
    email VARCHAR(256) UNIQUE,
    school VARCHAR(256),
    weight DOUBLE
    );


INSERT INTO exercise (exercise_name, exercise_type, metabolic_equivalent_score)
VALUES ('Slow Walking (1 to 2 mph)', 'Anaerobic', 2);

INSERT INTO exercise (exercise_name, exercise_type, metabolic_equivalent_score)
VALUES ('Brisk Walking (3.5 to 4 mph)', 'Aerobic', 5);

INSERT INTO exercise (exercise_name, exercise_type, metabolic_equivalent_score)
VALUES ('Fast Walking (4.5 to 5 mph)', 'Aerobic', 6.3);

INSERT INTO exercise (exercise_name, exercise_type, metabolic_equivalent_score)
VALUES ('Running (7 mph)', 'Aerobic', 11.5);

INSERT INTO exercise (exercise_name, exercise_type, metabolic_equivalent_score)
VALUES ('Light Weight Lifting', 'Anaerobic', 3.5);

INSERT INTO exercise (exercise_name, exercise_type, metabolic_equivalent_score)
VALUES ('Heavy Weight Lifting', 'Anaerobic', 5);

INSERT INTO exercise (exercise_name, exercise_type, metabolic_equivalent_score)
VALUES ('Soccer', 'Aerobic', 10);

CREATE TABLE IF NOT EXISTS userExercising (
    user_exercising_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    student_id int,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    exercise_id int,
    FOREIGN KEY (exercise_id) REFERENCES exercise(exercise_id),
    started_ DATETIME,
    ended_at DATETIME,
    calories_burned DOUBLE
    );

CREATE TABLE IF NOT EXISTS userMeditating (
    user_exercising_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    student_id int,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    meditation_id int,
    FOREIGN KEY (meditation_id) REFERENCES meditation(meditation_id),
    started_at DATETIME,
    ended_at DATETIME
    );














