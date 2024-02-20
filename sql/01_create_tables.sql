CREATE DATABASE IF NOT EXISTS OnlineLearningDB;
USE OnlineLearningDB;

DROP TABLE IF EXISTS UserOnlineHistory;
DROP TABLE IF EXISTS OnlineCourses;
DROP TABLE IF EXISTS Subjects;
DROP TABLE IF EXISTS Users;

-- Create Users table
CREATE TABLE IF NOT EXISTS Users (
    userId INT NOT NULL AUTO_INCREMENT,
    userUid CHAR(36) NOT NULL UNIQUE,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    PRIMARY KEY (userId)
);

-- Create Subjects table
CREATE TABLE IF NOT EXISTS Subjects (
    subjectId INT NOT NULL AUTO_INCREMENT,
    subjectUid CHAR(36) NOT NULL UNIQUE,
    subjectName VARCHAR(255) NOT NULL,
    PRIMARY KEY (subjectId)
);

-- Create OnlineCourses table
CREATE TABLE IF NOT EXISTS OnlineCourses (
    onlineCourseId INT NOT NULL AUTO_INCREMENT,
    onlineCourseUid CHAR(36) NOT NULL UNIQUE,
    onlineCourseTitle VARCHAR(255) NOT NULL,
    onlineCourseSubjectUid CHAR(36) NOT NULL,
    PRIMARY KEY (onlineCourseId),
    FOREIGN KEY (onlineCourseSubjectUid) REFERENCES Subjects(subjectUid)
);

-- Create UserOnlineHistory table
CREATE TABLE IF NOT EXISTS UserOnlineHistory (
    historyId INT NOT NULL AUTO_INCREMENT,
    historyUid CHAR(36) NOT NULL UNIQUE,
    userUid CHAR(36) NOT NULL,
    onlineCourseUid CHAR(36) NOT NULL,
    grade DOUBLE NOT NULL,
    gradeMaxVal DOUBLE NOT NULL,
    pct DOUBLE NOT NULL,
    completed DATETIME NOT NULL,
    PRIMARY KEY (historyId),
    FOREIGN KEY (userUid) REFERENCES Users(userUid),
    FOREIGN KEY (onlineCourseUid) REFERENCES OnlineCourses(onlineCourseUid)
);