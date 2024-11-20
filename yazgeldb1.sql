-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 20, 2024 at 05:11 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `yazgeldb1`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `admin_full_name` varchar(128) DEFAULT NULL,
  `admin_email` varchar(128) NOT NULL,
  `admin_password` varchar(128) DEFAULT NULL,
  `admin_type` enum('super_admin','normal_admin') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_full_name`, `admin_email`, `admin_password`, `admin_type`) VALUES
(1, 'Insiya Maryam', 'Insiya@example.com', 'password123', 'super_admin'),
(2, 'Jane Smith', 'janesmith@example.com', 'securepass456', 'normal_admin');

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

CREATE TABLE `announcement` (
  `announcement_id` int(11) NOT NULL,
  `announcement_title` varchar(256) NOT NULL,
  `announcement_content` varchar(1000) NOT NULL,
  `announcement_file` varchar(300) DEFAULT NULL,
  `announcement_author` varchar(256) NOT NULL,
  `announcement_datetime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internship_acceptance_certificate`
--

CREATE TABLE `internship_acceptance_certificate` (
  `id` int(11) NOT NULL,
  `student_number` varchar(32) NOT NULL,
  `acceptance_certificate` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internship_application`
--

CREATE TABLE `internship_application` (
  `application_id` int(11) NOT NULL,
  `semester` enum('fall','spring') NOT NULL,
  `student_number` varchar(32) NOT NULL,
  `internship_start_date` date NOT NULL,
  `internship_end_date` date NOT NULL,
  `work_days` int(11) NOT NULL,
  `works_on_saturday` enum('yes','no') NOT NULL,
  `social_security_scope` enum('yes','no') NOT NULL,
  `receives_health_services` enum('yes','no') NOT NULL,
  `age_25` enum('yes','no') NOT NULL,
  `iban` varchar(32) NOT NULL,
  `company_name` varchar(128) NOT NULL,
  `company_email` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internship_application_details`
--

CREATE TABLE `internship_application_details` (
  `application_id` int(11) NOT NULL,
  `application_type` enum('internship1','internship2') NOT NULL,
  `student_number` varchar(32) NOT NULL,
  `start_date` varchar(64) NOT NULL,
  `end_date` varchar(64) NOT NULL,
  `work_day` int(11) NOT NULL,
  `works_on_saturday` enum('yes','no') DEFAULT NULL,
  `gss_coverage` enum('yes','no') NOT NULL,
  `health_service` enum('yes','no') NOT NULL,
  `age_25` enum('yes','no') NOT NULL,
  `company_name` varchar(256) NOT NULL,
  `company_email` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internship_approval_certificate`
--

CREATE TABLE `internship_approval_certificate` (
  `id` int(11) NOT NULL,
  `internship_type` enum('internship1','internship2') NOT NULL,
  `student_number` varchar(32) NOT NULL,
  `student_internship_approval_certificate` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internship_documents`
--

CREATE TABLE `internship_documents` (
  `student_id` int(11) NOT NULL,
  `student_number` varchar(32) NOT NULL,
  `internship_report` varchar(300) NOT NULL,
  `internship_evaluation_form` varchar(300) NOT NULL,
  `internship_audit_form` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internship_files`
--

CREATE TABLE `internship_files` (
  `id` int(11) NOT NULL,
  `internship_type` enum('internship1','internship2') NOT NULL,
  `student_number` varchar(32) NOT NULL,
  `internship_report` varchar(300) NOT NULL,
  `internship_evaluation_form` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internship_followup`
--

CREATE TABLE `internship_followup` (
  `id` int(11) NOT NULL,
  `internship_type` enum('internship1','internship2') NOT NULL,
  `student_number` varchar(32) NOT NULL,
  `internship_status` enum('done','document_upload','evaluation') NOT NULL,
  `feedback` varchar(1000) DEFAULT NULL,
  `teacher_number` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internship_report`
--

CREATE TABLE `internship_report` (
  `id` int(11) NOT NULL,
  `internship_type` enum('internship1','internship2') NOT NULL,
  `student_number` varchar(32) NOT NULL,
  `report` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internship_students`
--

CREATE TABLE `internship_students` (
  `period_id` int(11) NOT NULL,
  `student_number` varchar(32) NOT NULL,
  `internship_period` enum('fall','spring') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internship_tracking`
--

CREATE TABLE `internship_tracking` (
  `student_id` int(11) NOT NULL,
  `semester` enum('fall','spring') NOT NULL,
  `student_number` varchar(32) NOT NULL,
  `internship_status` enum('done','document_upload','evaluation','other') NOT NULL,
  `teacher_number` varchar(32) NOT NULL,
  `feedback` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `newuser`
--

CREATE TABLE `newuser` (
  `user_id` int(11) NOT NULL,
  `user_fullName` varchar(128) NOT NULL,
  `user_password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `newuser`
--

INSERT INTO `newuser` (`user_id`, `user_fullName`, `user_password`) VALUES
(1, 'irshad@example.com', 'e10adc3949ba59abbe56e057f20f883e');

-- --------------------------------------------------------

--
-- Table structure for table `pdf_file`
--

CREATE TABLE `pdf_file` (
  `id` int(11) NOT NULL,
  `pdf` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `user_id` int(11) NOT NULL,
  `student_full_name` varchar(128) NOT NULL,
  `student_tc` varchar(15) NOT NULL,
  `student_nationality` varchar(64) NOT NULL,
  `student_phone` varchar(15) NOT NULL,
  `student_email` varchar(128) NOT NULL,
  `student_password` varchar(128) NOT NULL,
  `student_school_name` varchar(256) NOT NULL,
  `student_faculty_name` varchar(128) NOT NULL,
  `student_department_name` varchar(128) NOT NULL,
  `student_class` varchar(16) NOT NULL,
  `student_school_no` varchar(64) NOT NULL,
  `student_address` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`user_id`, `student_full_name`, `student_tc`, `student_nationality`, `student_phone`, `student_email`, `student_password`, `student_school_name`, `student_faculty_name`, `student_department_name`, `student_class`, `student_school_no`, `student_address`) VALUES
(1, 'John Doe', '12345678901', 'Indian', '+90 123 456 789', 'john.doe@example.com', 'password123', 'MJCET University', 'Engineering', 'Computer Science', '1st Year', '123456', '123 Main St, Hyderabad'),
(2, 'Ali Yılmaz', '11223344556', 'Indian', '+90 555 987 654', 'ali.yilmaz@example.com', 'aliPass123', 'MJCET University', 'Engineering', 'ML Engineering', '4th Year', '789012', '789 Pine St, Hyderabad'),
(3, 'Maria ', '33221199887', 'Spanish', '+34 612 345 678', 'maria@example.com', 'mariaPass123', 'MJCET University', 'Engineering', 'Civil Engineering', '4th Year', '345678', '101 Maple St, Punjab');

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `teacher_id` int(11) NOT NULL,
  `teacher_full_name` varchar(128) NOT NULL,
  `teacher_tc` varchar(20) NOT NULL,
  `teacher_email` varchar(128) NOT NULL,
  `teacher_phone` varchar(20) NOT NULL,
  `teacher_school_no` varchar(20) NOT NULL,
  `teacher_password` varchar(128) NOT NULL,
  `teacher_faculty_name` varchar(128) NOT NULL,
  `teacher_department_name` varchar(128) NOT NULL,
  `role` enum('teacher','commission') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`teacher_id`, `teacher_full_name`, `teacher_tc`, `teacher_email`, `teacher_phone`, `teacher_school_no`, `teacher_password`, `teacher_faculty_name`, `teacher_department_name`, `role`) VALUES
(1, 'Mirfath Ali', '12345678901', 'mirfath@example.com', '555-1010', 'T001', 'password123', 'Engineering Faculty', 'Computer Science Department', 'teacher'),
(2, 'Nameera Khan', '23456789012', 'nameera@example.com', '555-2020', 'T002', 'password456', 'Engineering Faculty', 'Electrical Engineering Department', 'teacher'),
(3, 'Mubeen Ahmad', '34567890123', 'mubeen@example.com', '555-3030', 'T003', 'password789', 'Science Faculty', 'Physics Department', 'teacher'),
(4, 'Saniya Shaikh', '45678901234', 'saniya@example.com', '555-4040', 'T004', 'password145', 'Management Faculty', 'Business Administration Department', 'commission');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `announcement`
--
ALTER TABLE `announcement`
  ADD PRIMARY KEY (`announcement_id`);

--
-- Indexes for table `internship_acceptance_certificate`
--
ALTER TABLE `internship_acceptance_certificate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `internship_application`
--
ALTER TABLE `internship_application`
  ADD PRIMARY KEY (`application_id`);

--
-- Indexes for table `internship_application_details`
--
ALTER TABLE `internship_application_details`
  ADD PRIMARY KEY (`application_id`);

--
-- Indexes for table `internship_approval_certificate`
--
ALTER TABLE `internship_approval_certificate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `internship_documents`
--
ALTER TABLE `internship_documents`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `internship_files`
--
ALTER TABLE `internship_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `internship_followup`
--
ALTER TABLE `internship_followup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `internship_report`
--
ALTER TABLE `internship_report`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `internship_students`
--
ALTER TABLE `internship_students`
  ADD PRIMARY KEY (`period_id`);

--
-- Indexes for table `internship_tracking`
--
ALTER TABLE `internship_tracking`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `newuser`
--
ALTER TABLE `newuser`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `pdf_file`
--
ALTER TABLE `pdf_file`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`teacher_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `announcement`
--
ALTER TABLE `announcement`
  MODIFY `announcement_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internship_acceptance_certificate`
--
ALTER TABLE `internship_acceptance_certificate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internship_application`
--
ALTER TABLE `internship_application`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internship_application_details`
--
ALTER TABLE `internship_application_details`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internship_approval_certificate`
--
ALTER TABLE `internship_approval_certificate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internship_documents`
--
ALTER TABLE `internship_documents`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internship_files`
--
ALTER TABLE `internship_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internship_followup`
--
ALTER TABLE `internship_followup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internship_report`
--
ALTER TABLE `internship_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internship_students`
--
ALTER TABLE `internship_students`
  MODIFY `period_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internship_tracking`
--
ALTER TABLE `internship_tracking`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `newuser`
--
ALTER TABLE `newuser`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pdf_file`
--
ALTER TABLE `pdf_file`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
