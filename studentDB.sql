-- A relational database schema called studentDB that includes:
-- Well-structured tables to link all student records.
-- Proper constraints (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, CHECK & DEFAULT).
-- Relationships (One-to-One, One-to-Many, Many-to-Many, where applicable).
CREATE DATABASE studentDB;

CREATE TABLE registration_records(
    registrationID INT PRIMARY KEY AUTO_INCREMENT,
    regNumber VARCHAR(30) UNIQUE NOT NULL,
    academicYear VARCHAR(20) NOT NULL,
    registrationDate DATE DEFAULT '2024-10-25'
);

CREATE TABLE fee_payments(
    paymentID INT PRIMARY KEY AUTO_INCREMENT,
    controlNumber VARCHAR(50) UNIQUE NOT NULL,
    paymentCategory VARCHAR(20),
    amount INT CHECK (amount > 750000)
);

CREATE TABLE courses(
    courseID INT PRIMARY KEY AUTO_INCREMENT,
    courseName VARCHAR(100) NOT NULL,
    courseDuration INT
    durationUnit VARCHAR(20) CHECK (durationUnit IN ('weeks', 'months', 'years'))
);

CREATE TABLE modules(
    moduleID INT PRIMARY KEY,
    moduleName VARCHAR(100) NOT NULL,
);

CREATE TABLE course_modules(
    courseID INT,
    moduleID INT,
    PRIMARY KEY(courseID, moduleID),
    FOREIGN KEY (courseID) REFERENCES courses(courseID),
    FOREIGN KEY (moduleID) REFERENCES modules(moduleID)
);

CREATE TABLE instructors(
    instructorID INT PRIMARY KEY,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE instructor_modules(
    instructorID INT,
    moduleID INT,
    PRIMARY KEY(instructorID, moduleID),
    FOREIGN KEY (instructorID) REFERENCES instructors(instructorID),
    FOREIGN KEY (moduleID) REFERENCES modules(moduleID)
);

CREATE TABLE students(
    studentID INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    birthDate DATE,
    registrationID INT,
    paymentID INT,
    courseID INT,
    FOREIGN KEY (registrationID) REFERENCES registration_records(registrationID),
    FOREIGN KEY (paymentID) REFERENCES fee_payments(paymentID),
    FOREIGN KEY (courseID) REFERENCES courses(courseID) 
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE student_modules(
    studentID INT,
    moduleID INT,
    PRIMARY KEY(studentID, moduleID),
    FOREIGN KEY (studentID) REFERENCES students(student_id),
    FOREIGN KEY (moduleID) REFERENCES modules(moduleID)
);

CREATE TABLE departments(
    depID INT PRIMARY KEY,
    depName VARCHAR(100) NOT NULL
);

CREATE TABLE department_courses(
    depID INT,
    courseID INT,
    PRIMARY KEY(depID, courseID),
    FOREIGN KEY (depID) REFERENCES departments(depID),
    FOREIGN KEY (courseID) REFERENCES courses(courseID)
);

CREATE TABLE department_instructors(
    depID INT,
    instructorID INT,
    PRIMARY KEY(depID, instructorID),
    FOREIGN KEY (depID) REFERENCES departments(depID),
    FOREIGN KEY (instructorID) REFERENCES instructors(instructorID)
);
