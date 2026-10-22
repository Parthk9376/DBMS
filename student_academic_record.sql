-- Student Academic Record Management System (MySQL 8.0.16+)
-- Local MySQL: create/select this database. On hosted MySQL, use the database
-- name provided by your host and omit CREATE DATABASE/USE if not permitted.
CREATE DATABASE IF NOT EXISTS student_academic_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE student_academic_db;

CREATE TABLE IF NOT EXISTS courses (
  course_id INT AUTO_INCREMENT PRIMARY KEY,
  course_code VARCHAR(20) NOT NULL UNIQUE,
  course_name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS students (
  student_id INT AUTO_INCREMENT PRIMARY KEY,
  roll_number VARCHAR(30) NOT NULL UNIQUE,
  student_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE,
  course_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_student_course (student_id, course_id),
  CONSTRAINT fk_students_course FOREIGN KEY (course_id)
    REFERENCES courses(course_id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS subjects (
  subject_id INT AUTO_INCREMENT PRIMARY KEY,
  subject_code VARCHAR(20) NOT NULL UNIQUE,
  subject_name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS course_subjects (
  course_id INT NOT NULL,
  subject_id INT NOT NULL,
  semester TINYINT NOT NULL,
  academic_year VARCHAR(9) NOT NULL,
  PRIMARY KEY (course_id, subject_id, semester, academic_year),
  CONSTRAINT chk_cs_semester CHECK (semester BETWEEN 1 AND 12),
  CONSTRAINT fk_cs_course FOREIGN KEY (course_id) REFERENCES courses(course_id),
  CONSTRAINT fk_cs_subject FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS assessments (
  assessment_id INT AUTO_INCREMENT PRIMARY KEY,
  course_id INT NOT NULL,
  subject_id INT NOT NULL,
  semester TINYINT NOT NULL,
  academic_year VARCHAR(9) NOT NULL,
  assessment_name VARCHAR(80) NOT NULL,
  max_marks DECIMAL(6,2) NOT NULL,
  assessment_date DATE,
  UNIQUE KEY uq_assessment (course_id, subject_id, semester, academic_year, assessment_name),
  UNIQUE KEY uq_assessment_course (assessment_id, course_id),
  CONSTRAINT chk_assessment_semester CHECK (semester BETWEEN 1 AND 12),
  CONSTRAINT chk_max_marks CHECK (max_marks > 0),
  CONSTRAINT fk_assessment_cs FOREIGN KEY (course_id, subject_id, semester, academic_year)
    REFERENCES course_subjects(course_id, subject_id, semester, academic_year)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS marks (
  student_id INT NOT NULL,
  assessment_id INT NOT NULL,
  course_id INT NOT NULL,
  marks_obtained DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (student_id, assessment_id),
  CONSTRAINT chk_marks_nonnegative CHECK (marks_obtained >= 0),
  CONSTRAINT fk_marks_student_course FOREIGN KEY (student_id, course_id)
    REFERENCES students(student_id, course_id) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_marks_assessment_course FOREIGN KEY (assessment_id, course_id)
    REFERENCES assessments(assessment_id, course_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_students_course ON students(course_id);
CREATE INDEX idx_assessment_subject_year ON assessments(subject_id, academic_year, semester);

SHOW TABLES;
