-- creating a schema that is a database
CREATE SCHEMA lib ;
-- using the created database
use lib;
-- creating books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    course VARCHAR(255),
    available_copies INT,
    publication_year INT,
    cover_image BLOB,
    genre VARCHAR(255),
    format VARCHAR(255)
);

-- Members Table
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    address VARCHAR(255),
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Transactions Table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    transaction_date DATE,
    due_date DATE,
    return_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Reservation Table
CREATE TABLE Reservation (
    reservation_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    request_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Feedback/Surveys Table
CREATE TABLE Feedback_Surveys (
    feedback_id INT PRIMARY KEY,
    member_id INT,
    feedback_text TEXT,
    suggestion_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- User Profile Table
CREATE TABLE User_Profile (
    profile_id INT PRIMARY KEY,
    member_id INT,
    profile_data TEXT,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Loan Requests Table
CREATE TABLE Loan_Requests (
    loan_request_id INT PRIMARY KEY,
    requester_member_id INT,
    laptop_id INT,
    request_date DATE,
    status VARCHAR(50)
);

-- Administration_Users Table
CREATE TABLE Administration_Users (
    admin_id INT PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255),
    full_name VARCHAR(255),
    email VARCHAR(255)
);

-- Roles Table
CREATE TABLE Roles (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(50),
    permissions TEXT
);

-- Admin_Roles Bridge Table
CREATE TABLE Admin_Roles (
    admin_id INT,
    role_id INT,
    PRIMARY KEY (admin_id, role_id),
    FOREIGN KEY (admin_id) REFERENCES Administration_Users(admin_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Logging Table
CREATE TABLE Logging (
    log_id INT PRIMARY KEY,
    user_id INT,
    activity_description TEXT,
    timestamp DATETIME,
    FOREIGN KEY (user_id) REFERENCES Members(member_id)
);

-- Laptop Table
CREATE TABLE Laptop (
    laptop_id INT PRIMARY KEY,
    company_name VARCHAR(255),
    processor_type VARCHAR(255)
);
-- phone_number Table
CREATE TABLE phone_number (
  Phone_no VARCHAR(20) NOT NULL,
  member_id INT NOT NULL,
  PRIMARY KEY (Phone_no, member_id),
  FOREIGN KEY (member_id)REFERENCES members(member_id)
);
    
-- Inserting data into the tables
-- books table
INSERT INTO Books (book_id, title, author, course, available_copies, publication_year, cover_image, genre, format) VALUES
(1, 'Book1', 'Author1', 'Course1', 5, 2020, NULL, 'Fiction', 'Paperback'),
(2, 'Book2', 'Author2', 'Course2', 3, 2019, NULL, 'Science', 'Hardcover'),
(3, 'Book3', 'Author3', 'Course3', 8, 2021, NULL, 'History', 'E-book'),
(4, 'Book4', 'Author4', 'Course4', 2, 2018, NULL, 'Biography', 'Paperback'),
(5, 'Book5', 'Author5', 'Course5', 6, 2022, NULL, 'Mystery', 'Hardcover'),
(6, 'Book6', 'Author6', 'Course6', 4, 2023, NULL, 'Romance', 'E-book'),
(7, 'Book7', 'Author7', 'Course7', 7, 2024, NULL, 'Thriller', 'Paperback'),
(8, 'Book8', 'Author8', 'Course8', 9, 2025, NULL, 'Self-help', 'Hardcover'),
(9, 'Book9', 'Author9', 'Course9', 1, 2026, NULL, 'Poetry', 'E-book'),
(10, 'Book10', 'Author10', 'Course10', 10, 2027, NULL, 'Drama', 'Paperback');

-- Members table
INSERT INTO Members (member_id, name, email, phone_number, address, role_id) VALUES
(1, 'Meenakshi Miryala', 'Meenakshi.Miryala1@marist.edu', 'Phone Number 1', 'Address 1', 1),
(2, 'Snithika Reddy Gaddam', 'SnithikaReddy.Gaddam1@marist.edu', 'Phone Number 2', 'Address 2', 2),
(3, 'Rajesh Onteru', 'Rajesh.Onteru1@marist.edu', 'Phone Number 3', 'Address 3', 2),
(11, 'Member1', 'member1@example.com', '1234567890', 'Address1', 1),
(22, 'Member2', 'member2@example.com', '2345678901', 'Address2', 2),
(33, 'Member3', 'member3@example.com', '3456789012', 'Address3', 1),
(4, 'Member4', 'member4@example.com', '4567890123', 'Address4', 2),
(5, 'Member5', 'member5@example.com', '5678901234', 'Address5', 1),
(6, 'Member6', 'member6@example.com', '6789012345', 'Address6', 2),
(7, 'Member7', 'member7@example.com', '7890123456', 'Address7', 1),
(8, 'Member8', 'member8@example.com', '8901234567', 'Address8', 2),
(9, 'Member9', 'member9@example.com', '9012345678', 'Address9', 1),
(10, 'Member10', 'member10@example.com', '0123456789', 'Address10', 2);

-- Transactions table
INSERT INTO Transactions (transaction_id, book_id, member_id, transaction_date, due_date, return_date, status) VALUES
(1, 1, 1, '2023-10-01', '2023-10-15', '2023-10-13', 'Returned'),
(2, 2, 2, '2023-10-02', '2023-10-16', '2023-10-14', 'Returned'),
(3, 3, 3, '2023-10-03', '2023-10-17', '2023-10-15', 'Returned'),
(4, 4, 4, '2023-10-04', '2023-10-18', '2023-10-16', 'Returned'),
(5, 5, 5, '2023-10-05', '2023-10-19', '2023-10-17', 'Returned'),
(6, 6, 6, '2023-10-06', '2023-10-20', '2023-10-18', 'Returned'),
(7, 7, 7, '2023-10-07', '2023-10-21', '2023-10-19', 'Returned'),
(8, 8, 8, '2023-10-08', '2023-10-22', '2023-10-20', 'Returned'),
(9, 9, 9, '2023-10-09', '2023-10-23', '2023-10-21', 'Returned'),
(10, 10, 10, '2023-10-10', '2023-10-24', '2023-10-22', 'Returned');

-- Reservation table
INSERT INTO Reservation (reservation_id, book_id, member_id, request_date, status) VALUES
(1, 1, 1, '2023-10-01', 'Pending'),
(2, 2, 2, '2023-10-02', 'Pending'),
(3, 3, 3, '2023-10-03', 'Pending'),
(4, 4, 4, '2023-10-04', 'Pending'),
(5, 5, 5, '2023-10-05', 'Pending'),
(6, 6, 6, '2023-10-06', 'Pending'),
(7, 7, 7, '2023-10-07', 'Pending'),
(8, 8, 8, '2023-10-08', 'Pending'),
(9, 9, 9, '2023-10-09', 'Pending'),
(10, 10, 10, '2023-10-10', 'Pending');

-- Feedback_Surveys table
INSERT INTO Feedback_Surveys (feedback_id, member_id, feedback_text, suggestion_date) VALUES
(1, 1, 'Feedback1', '2023-10-01'),
(2, 2, 'Feedback2', '2023-10-02'),
(3, 3, 'Feedback3', '2023-10-03'),
(4, 4, 'Feedback4', '2023-10-04'),
(5, 5, 'Feedback5', '2023-10-05'),
(6, 6, 'Feedback6', '2023-10-06'),
(7, 7, 'Feedback7', '2023-10-07'),
(8, 8, 'Feedback8', '2023-10-08'),
(9, 9, 'Feedback9', '2023-10-09'),
(10, 10, 'Feedback10', '2023-10-10');

-- User_Profile table
INSERT INTO User_Profile (profile_id, member_id, profile_data) VALUES
(1, 1, 'ProfileData1'),
(2, 2, 'ProfileData2'),
(3, 3, 'ProfileData3'),
(4, 4, 'ProfileData4'),
(5, 5, 'ProfileData5'),
(6, 6, 'ProfileData6'),
(7, 7, 'ProfileData7'),
(8, 8, 'ProfileData8'),
(9, 9, 'ProfileData9'),
(10, 10, 'ProfileData10');

-- Loan_Requests table
INSERT INTO Loan_Requests (loan_request_id, requester_member_id, laptop_id, request_date, status) VALUES
(1, 1, 1, '2023-10-01', 'Approved'),
(2, 2, 2, '2023-10-02', 'Approved'),
(3, 3, 3, '2023-10-03', 'Approved'),
(4, 4, 4, '2023-10-04', 'Approved'),
(5, 5, 5, '2023-10-05', 'Approved'),
(6, 6, 6, '2023-10-06', 'Approved'),
(7, 7, 7, '2023-10-07', 'Approved'),
(8, 8, 8, '2023-10-08', 'Approved'),
(9, 9, 9, '2023-10-09', 'Approved'),
(10, 10, 10, '2023-10-10', 'Approved');

-- Administration_Users table
INSERT INTO Administration_Users (admin_id, username, password, full_name, email) VALUES
(1, 'admin1', 'password1', 'Admin User1', 'admin1@example.com'),
(2, 'admin2', 'password2', 'Admin User2', 'admin2@example.com'),
(3, 'admin3', 'password3', 'Admin User3', 'admin3@example.com'),
(4, 'admin4', 'password4', 'Admin User4', 'admin4@example.com'),
(5, 'admin5', 'password5', 'Admin User5', 'admin5@example.com'),
(6, 'admin6', 'password6', 'Admin User6', 'admin6@example.com'),
(7, 'admin7', 'password7', 'Admin User7', 'admin7@example.com'),
(8, 'admin8', 'password8', 'Admin User8', 'admin8@example.com'),
(9, 'admin9', 'password9', 'Admin User9', 'admin9@example.com'),
(10, 'admin10', 'password10', 'Admin User10', 'admin10@example.com');

-- Roles table
INSERT INTO Roles (role_id, role_name, permissions) VALUES
(1, 'Role1', 'Permission1'),
(2, 'Role2', 'Permission2'),
(3, 'Role3', 'Permission3'),
(4, 'Role4', 'Permission4'),
(5, 'Role5', 'Permission5'),
(6, 'Role6', 'Permission6'),
(7, 'Role7', 'Permission7'),
(8, 'Role8', 'Permission8'),
(9, 'Role9', 'Permission9'),
(10, 'Role10', 'Permission10');

-- Admin_Roles table
INSERT INTO Admin_Roles (admin_id, role_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Logging table
INSERT INTO Logging (log_id, user_id, activity_description, timestamp) VALUES
(1, 1, 'Activity1', '2023-10-01 10:00:00'),
(2, 2, 'Activity2', '2023-10-02 11:00:00'),
(3, 3, 'Activity3', '2023-10-03 12:00:00'),
(4, 4, 'Activity4', '2023-10-04 13:00:00'),
(5, 5, 'Activity5', '2023-10-05 14:00:00'),
(6, 6, 'Activity6', '2023-10-06 15:00:00'),
(7, 7, 'Activity7', '2023-10-07 16:00:00'),
(8, 8, 'Activity8', '2023-10-08 17:00:00'),
(9, 9, 'Activity9', '2023-10-09 18:00:00'),
(10, 10, 'Activity10', '2023-10-10 19:00:00');

-- Laptop table
INSERT INTO Laptop (laptop_id, company_name, processor_type) VALUES
(1, 'Company1', 'ProcessorType1'),
(2, 'Company2', 'ProcessorType2'),
(3, 'Company3', 'ProcessorType3'),
(4, 'Company4', 'ProcessorType4'),
(5, 'Company5', 'ProcessorType5'),
(6, 'Company6', 'ProcessorType6'),
(7, 'Company7', 'ProcessorType7'),
(8, 'Company8', 'ProcessorType8'),
(9, 'Company9', 'ProcessorType9'),
(10, 'Company10', 'ProcessorType10');

-- phone number table
INSERT INTO Phone_number (phone_no, member_id)
VALUES
    ('Phone Number1', 1),
    ('Phone Number2', 2),
    ('Phone Number3', 3),
    ('1234567890', 11),
    ('2345678901', 22),
    ('3456789012', 33),
    ('4567890123', 4),
    ('5678901234', 5),
    ('6789012345', 6),
    ('7890123456', 7),
    ('8901234567', 8),
    ('9012345678', 9),
    ('0123456789', 10);
-- performing joins for better understanding
SELECT Books.title, Books.author, Members.name
FROM Books
INNER JOIN Transactions ON Books.book_id = Transactions.book_id
INNER JOIN Members ON Transactions.member_id = Members.member_id;

SELECT Books.title, Books.author, Transactions.transaction_date
FROM Books
LEFT JOIN Transactions ON Books.book_id = Transactions.book_id;


SELECT Transactions.transaction_id, Transactions.transaction_date, Books.title
FROM Transactions
RIGHT JOIN Books ON Transactions.book_id = Books.book_id;

SELECT Members.name, Books.title, Transactions.transaction_date
FROM Members
LEFT JOIN Transactions ON Members.member_id = Transactions.member_id
LEFT JOIN Books ON Transactions.book_id = Books.book_id
ORDER BY Members.name;

SELECT Members.name, COUNT(Transactions.transaction_id) AS total_transactions
FROM Members
INNER JOIN Transactions ON Members.member_id = Transactions.member_id
GROUP BY Members.name;
USE lib;

-- Select queries for all tables

-- Books table
SELECT * FROM Books;

-- Members table
SELECT * FROM Members;

-- Transactions table
SELECT * FROM Transactions;

-- Reservation table
SELECT * FROM Reservation;

-- Feedback_Surveys table
SELECT * FROM Feedback_Surveys;

-- User_Profile table
SELECT * FROM User_Profile;

-- Loan_Requests table
SELECT * FROM Loan_Requests;

-- Administration_Users table
SELECT * FROM Administration_Users;

-- Roles table
SELECT * FROM Roles;

-- Admin_Roles table
SELECT * FROM Admin_Roles;

-- Logging table
SELECT * FROM Logging;

-- Laptop table
SELECT * FROM Laptop;

-- phone number table
select*from phone_number;
-- implementing foregin key constraints 

-- members table
ALTER TABLE Members
ADD CONSTRAINT fk_role_id
FOREIGN KEY (role_id) REFERENCES Roles(role_id);

-- transactions table
ALTER TABLE Transactions
ADD CONSTRAINT fk_book_id
FOREIGN KEY (book_id) REFERENCES Books(book_id);

ALTER TABLE Transactions
ADD CONSTRAINT fk_member_id
FOREIGN KEY (member_id) REFERENCES Members(member_id);

-- reservation table
ALTER TABLE Reservation
ADD CONSTRAINT fk_book1_id
FOREIGN KEY (book_id) REFERENCES Books(book_id);

ALTER TABLE Reservation
ADD CONSTRAINT fk_member_id1
FOREIGN KEY (member_id) REFERENCES Members(member_id);

-- Feedback_Surveys Table
ALTER TABLE Feedback_Surveys
ADD CONSTRAINT fk_member_id2
FOREIGN KEY (member_id) REFERENCES Members(member_id);

-- User_Profile Table
ALTER TABLE User_Profile
ADD CONSTRAINT fk_member_id3
FOREIGN KEY (member_id) REFERENCES Members(member_id);

-- Loan_Requests Table
ALTER TABLE Loan_Requests
ADD CONSTRAINT fk_requester_member_id
FOREIGN KEY (requester_member_id) REFERENCES Members(member_id);

ALTER TABLE Loan_Requests
ADD CONSTRAINT fk_laptop_id1
FOREIGN KEY (laptop_id) REFERENCES Laptop(laptop_id);

-- Admin_Roles Table
ALTER TABLE Admin_Roles
ADD CONSTRAINT fk_admin_id
FOREIGN KEY (admin_id) REFERENCES Administration_Users(admin_id);

ALTER TABLE Admin_Roles
ADD CONSTRAINT fk_role_id1
FOREIGN KEY (role_id) REFERENCES Roles(role_id);

-- Logging Table
ALTER TABLE Logging
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) REFERENCES Members(member_id);

--  a view for managing members, providing details such as contact information and roles.
CREATE VIEW MemberManagementView AS
SELECT 
    m.name as member_name, 
    m.email, 
    m.phone_number, 
    m.address, 
    r.role_name
FROM Members m
INNER JOIN Roles r ON m.role_id = r.role_id;

--  a view for book management
CREATE VIEW BookManagementView AS
SELECT 
    b.title as book_title, 
    b.author as book_author, 
    m.name as member_name, 
    t.transaction_date as transaction_date
FROM Books b
INNER JOIN Transactions t ON b.book_id = t.book_id
INNER JOIN Members m ON t.member_id = m.member_id;

--  a view for managing transactions
CREATE VIEW TransactionManagementView AS
SELECT 
    t.transaction_id, 
    b.title as book_title, 
    m.name as member_name, 
    t.transaction_date, 
    t.due_date, 
    t.return_date, 
    t.status
FROM Transactions t
INNER JOIN Books b ON t.book_id = b.book_id
INNER JOIN Members m ON t.member_id = m.member_id;


--  a view for managing book reservations, including request details and member information.
CREATE VIEW ReservationManagementView AS
SELECT 
    r.reservation_id, 
    b.title as book_title, 
    m.name as member_name, 
    r.request_date, 
    r.status
FROM Reservation r
INNER JOIN Books b ON r.book_id = b.book_id
INNER JOIN Members m ON r.member_id = m.member_id;

--  a view for managing feedback and surveys, displaying member feedback and suggestions.
CREATE VIEW FeedbackSurveyView AS
SELECT 
    f.feedback_id, 
    m.name as member_name, 
    f.feedback_text, 
    f.suggestion_date
FROM Feedback_Surveys f
INNER JOIN Members m ON f.member_id = m.member_id;

--  a view for managing administration users, including roles and associated permissions.
CREATE VIEW AdminUserView AS
SELECT 
    a.admin_id, 
    a.username, 
    a.full_name, 
    a.email, 
    r.role_name
FROM Administration_Users a
INNER JOIN Admin_Roles ar ON a.admin_id = ar.admin_id
INNER JOIN Roles r ON ar.role_id = r.role_id;

-- as we didn't add any passwords for members table we are altering it
ALTER TABLE lib.Members ADD password varchar(255) NOT NULL;
select *from members;
UPDATE lib.Members
SET password = 'Meena@2002'
WHERE member_id = 1;
UPDATE lib.Members
SET password = 'Sni@2002'
WHERE member_id = 2;
UPDATE lib.Members
SET password = 'Rajesh@1993'
WHERE member_id = 3;
UPDATE lib.Members
SET password = 'Mem@11'
WHERE member_id = 11;









