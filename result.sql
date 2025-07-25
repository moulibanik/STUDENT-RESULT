create database results;
use results;
-- STEP 1: Create Tables
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Dept VARCHAR(50),
    Semester INT
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT
);

CREATE TABLE Grades (
    GradeID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Semester INT,
    Marks INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- STEP 2: Insert Sample Data
INSERT INTO Students VALUES 
(1, 'Amit', 'CSE', 1),
(2, 'Riya', 'IT', 1),
(3, 'Rahul', 'CSE', 1);

INSERT INTO Courses VALUES 
(101, 'Mathematics', 4),
(102, 'DBMS', 3),
(103, 'OS', 3);

INSERT INTO Grades VALUES 
(1, 1, 101, 1, 85),
(2, 1, 102, 1, 78),
(3, 1, 103, 1, 88),
(4, 2, 101, 1, 65),
(5, 2, 102, 1, 72),
(6, 2, 103, 1, 58),
(7, 3, 101, 1, 35),
(8, 3, 102, 1, 40),
(9, 3, 103, 1, 30);

-- STEP 3: GPA Calculation (Average Marks)
-- STEP 1: Create Tables
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Dept VARCHAR(50),
    Semester INT
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT
);

CREATE TABLE Grades (
    GradeID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Semester INT,
    Marks INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- STEP 2: Insert Sample Data
INSERT INTO Students VALUES 
(1, 'Amit', 'CSE', 1),
(2, 'Riya', 'IT', 1),
(3, 'Rahul', 'CSE', 1);

INSERT INTO Courses VALUES 
(101, 'Mathematics', 4),
(102, 'DBMS', 3),
(103, 'OS', 3);

INSERT INTO Grades VALUES 
(1, 1, 101, 1, 85),
(2, 1, 102, 1, 78),
(3, 1, 103, 1, 88),
(4, 2, 101, 1, 65),
(5, 2, 102, 1, 72),
(6, 2, 103, 1, 58),
(7, 3, 101, 1, 35),
(8, 3, 102, 1, 40),
(9, 3, 103, 1, 30);

-- STEP 3: GPA Calculation (Average Marks)
SELECT 
  StudentID,
  ROUND(AVG(Marks), 2) AS GPA
FROM Grades
GROUP BY StudentID;

-- STEP 4: Pass/Fail Report
SELECT 
  StudentID, CourseID, Marks,
  CASE 
    WHEN Marks >= 40 THEN 'Pass'
    ELSE 'Fail'
  END AS Result
FROM Grades;

-- STEP 5: Rank List Based on GPA
SET @rank := 0;
SET @prev_gpa := NULL;


SELECT
  StudentID,
  GPA,
  @rank := IF(@prev_gpa = GPA, @rank, @rank + 1) AS RankPosition,
  @prev_gpa := GPA
FROM (
  SELECT 
    StudentID,
    ROUND(AVG(Marks), 2) AS GPA
  FROM Grades
  GROUP BY StudentID
  ORDER BY GPA DESC
) AS ranked;

-- STEP 4: Pass/Fail Report
SELECT 
  StudentID, CourseID, Marks,
  CASE 
    WHEN Marks >= 40 THEN 'Pass'
    ELSE 'Fail'
  END AS Result
FROM Grades;