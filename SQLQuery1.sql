IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Universitate')
BEGIN
CREATE DATABASE Universitate
 COLLATE SQL_Romanian_CP1250_CS_AS
END

 USE Universitate;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Orase')
BEGIN
	CREATE TABLE Orase  (
	Id int NOT NULL PRIMARY KEY IDENTITY,
	Denumire varchar(255) NOT NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Grupa')
BEGIN
 CREATE TABLE Grupa (
	Id int NOT NULL PRIMARY KEY IDENTITY,
	Denumire varchar(255) NOT NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Student')
BEGIN
 CREATE TABLE Student (
	Id int NOT NULL PRIMARY KEY IDENTITY,
	GrupaId int FOREIGN KEY REFERENCES Grupa(Id) NOT NULL,
	OrasId int FOREIGN KEY REFERENCES Orase(Id) NOT NULL,
	Nume varchar(255),
	Prenume varchar(255),
)
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Materie')
BEGIN
 CREATE TABLE Materie (
	Id int NOT NULL PRIMARY KEY IDENTITY,
	Nume varchar(255) NOT NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Note')
BEGIN
 CREATE TABLE Note (
	Id int NOT NULL PRIMARY KEY IDENTITY,
	StudentId int FOREIGN KEY REFERENCES Student(Id) ON DELETE CASCADE NOT NULL,
	MaterieId int FOREIGN KEY REFERENCES Materie(Id) NOT NULL,
	Nota int NOT NULL,
	CONSTRAINT Nota_Valida CHECK (Nota > 0 and Nota <= 10)
)
END


INSERT INTO Orase (Denumire) VALUES ('Ploiesti'), ('Pitești'), ('Constanța'), ('București'),
	('Călărași'), ('Iași'), ('Slobozia'), ('Sibiu'), ('Cluj-Napoca'), ('Brașov'), ('Fetești'),
	('Satu-Mare'), ('Oradea'), ('Cernavodă');

INSERT INTO Grupa (Denumire) VALUES ('A'), ('B'), ('C'), ('D');

INSERT INTO Materie (Nume) VALUES ('Geometrie'), ('Algebră'), ('Statistică'), ('Trigonometrie'), ('Muzică'),
	('Desen'), ('Sport'), ('Filozofie'), ('Literatură'), ('Engleză'), ('Fizică'), ('Franceză');

INSERT INTO Materie (Nume) VALUES ('Chimie')

INSERT INTO Student (GrupaId, OrasId, Nume, Prenume) VALUES (1, 1, 'Popescu', 'Mihai'), (1, 4, 'Ionescu', 'Andrei'),
	(1, 3, 'Ionescu', 'Andreea'), (1, 5, 'Dinu', 'Nicolae'), (2, 14, 'Constantin', 'Ionut'), (2, 6, 'Simion', 'Mihai'),
	(2, 14, 'Constantinescu', 'Ana-Maria'), (2, 6, 'Amăriuței', 'Eugen'), (2, 8, 'Știrbei', 'Alexandru'), (3, 10, 'Dumitru', 'Angela'),
	(3, 13, 'Dumitrache', 'Ion'), (3, 13, 'Șerban', 'Maria-Magdalena'), (3, 9, 'Chelaru', 'Violeta'), (3, 9, 'Sandu', 'Daniel'),
	(4, 12, 'Marinache', 'Alin'), (4, 12, 'Panait', 'Vasile'), (4, 11, 'Popa', 'Mirela'), (4, 11, 'Dascălu', 'Daniel Stefan'),
	(4, 11, 'Georgescu', 'Marian'), (4, 1, 'Dumitrașcu', 'Marius'), (4, 4, 'Dinu', 'Ionela')


INSERT INTO Note (StudentId, MaterieId, Nota) VALUES (1, 13, 7), (1, 11, 4), (1, 12, 7), (1, 11, 6), (2, 2, 5), (2, 3, 9), (2, 5, 6),
	(2, 11, 9), (2, 13, 10), (2, 7, 8), (3, 7, 1), (3, 9, 2), (3, 12, 9), (3, 7, 5), (3, 9, 4), (3, 9, 7), (4, 13, 8), (4, 2, 9), (4, 3, 10),
	(5, 2, 10), (5, 7, 10), (5, 11, 8), (6, 11, 8), (6, 2, 8), (6, 7, 3), (6, 7, 3), (6, 7, 1), (6, 7, 1), (7, 7, 5), (7, 11, 8), (7, 2, 2),
	(7, 2, 5), (8, 2, 6), (8, 7, 10), (8, 12, 7), (9, 13, 9), (9, 11, 2), (9, 7, 1), (9, 11, 2), (9, 11, 5), (9, 7, 6), (10, 6, 9), (10, 8, 7),
	(10, 10, 9), (11, 6, 8), (11, 3, 2), (11, 8, 7), (11, 3, 6), (12, 10, 7), (12, 8, 4), (12, 6, 8), (12, 8, 4), (12, 8, 4), (13, 12, 1),
	(13, 6, 3), (13, 10, 10), (13, 12, 6), (13, 6, 1), (14, 6, 3), (14, 8, 9), (14, 12, 4), (14, 6, 8), (14, 12, 5), (15, 6, 7), (15, 11, 8),
	(15, 10, 5), (16, 7, 5), (16, 6, 7), (16, 3, 10), (16, 11, 8), (16, 9, 6), (16, 8, 9), (17, 10, 3), (17, 12, 6), (17, 6, 6), (17, 10, 6),
	(18, 11, 4), (18, 12, 9), (18, 3, 10), (18, 11, 2), (18, 11, 1), (18, 11, 3), (18, 11, 5), (19, 12, 10), (19, 10, 10), (19, 11, 8), (20, 7, 5),
	(20, 2, 6), (20, 13, 2), (20, 13, 2), (20, 13, 5), (21, 5, 9), (21, 9, 8), (21, 7, 8)



/* 5 */
SELECT COUNT(Denumire) from Orase
WHERE Denumire != 'București';

/* 6 */
SELECT COUNT(*) FROM (
SELECT Id FROM Materie
WHERE Id NOT IN (SELECT MaterieId from Note)
) AS Materii;

/* 7 */
SELECT * FROM Student ORDER BY Nume ASC;

/* 8 */
SELECT Prenume FROM Student
WHERE LEN(Prenume) - LEN(REPLACE(Prenume, ' ', '')) = 1 OR Prenume LIKE '%-%';

/* 9 */
SELECT * FROM Student
WHERE OrasId NOT IN (SELECT Id FROM Orase WHERE Denumire='București');

/* 10 */
SELECT Denumire FROM Orase
WHERE Id NOT IN (SELECT OrasId FROM Student);

/* 11 */
SELECT Grupa.Denumire, COUNT(Student.GrupaId)
FROM Grupa
LEFT JOIN Student ON Grupa.Id = Student.GrupaId
GROUP BY Grupa.Denumire
HAVING COUNT(Student.GrupaId) >= 5

/* 12 */
SELECT TOP 1 Grupa.Denumire 
FROM Grupa
LEFT JOIN Student ON Grupa.Id = Student.GrupaId
GROUP BY Grupa.Denumire
ORDER BY COUNT(Student.GrupaId) DESC

/* 13 */
SELECT Materie.Nume
FROM Materie
LEFT JOIN Note On Note.MaterieId = Materie.Id
WHERE Note.MaterieId IS NULL

/* 14 */
SELECT Student.Nume, Student.Prenume
FROM Student
LEFT JOIN Note ON Note.StudentId = Student.Id
GROUP BY Student.Nume, Student.Prenume
HAVING COUNT(DISTINCT Note.MaterieId) > 3

/* 15 */
SELECT Student.Nume, Student.Prenume, AVG(Note.Nota) as Medie
FROM Student
LEFT JOIN Note ON Note.StudentId = Student.Id
GROUP BY Student.Nume, Student.Prenume

/* 16 */
SELECT TOP 1 Grupa.Denumire as Grupa
FROM Grupa
LEFT JOIN Student ON Grupa.Id = Student.GrupaId
LEFT JOIN Note ON Note.StudentId = Student.Id
GROUP BY  Grupa.Denumire
ORDER BY AVG(Cast(Note.Nota as Float)) DESC

/* 17 */
SELECT Student.Nume, Student.Prenume, AVG(Cast(Note.Nota as DECIMAL)) as Medie
FROM Student
LEFT JOIN Note ON Note.StudentId = Student.Id
GROUP BY Student.Nume, Student.Prenume
HAVING  AVG(Cast(Note.Nota as DECIMAL)) >= 8.5

/* 18 --*/
SELECT Student.Nume, Student.Prenume
FROM Student
LEFT JOIN Note ON Note.StudentId = Student.Id
LEFT JOIN Materie ON Materie.Id = Note.MaterieId
WHERE Note.MaterieId = 13 AND Note.Nota < 5

/* 19 */
SELECT TOP 1 Student.Nume, Student.Prenume, COUNT(Note.MaterieId) as Numar_Materii
FROM Student
LEFT JOIN Note ON Note.StudentId = Student.Id
LEFT JOIN Materie ON Materie.Id = Note.MaterieId
GROUP BY Student.Nume, Student.Prenume
ORDER BY COUNT(Note.MaterieId) DESC

/* 20 */
SELECT Student.Nume, Student.Prenume, Materie.Nume, COUNT(Note.MaterieId) as Examinari
FROM Student
LEFT JOIN Note ON Note.StudentId = Student.Id
LEFT JOIN Materie ON Materie.Id = Note.MaterieId
GROUP BY Student.Nume, Student.Prenume, Materie.Nume

/* 21 */
SELECT Student.Nume, Student.Prenume
FROM Student
LEFT JOIN Note ON Note.StudentId = Student.Id
GROUP BY Student.Nume, Student.Prenume
HAVING  AVG(Cast(Note.Nota as DECIMAL)) < 5


/* 22 */
INSERT INTO Grupa (Denumire) VALUES ('E')
UPDATE Student 
SET GrupaId = 5
WHERE Id IN (
    SELECT StudentId
    FROM Note
    GROUP BY StudentId
    HAVING AVG(CAST(Nota AS DECIMAL)) < 5
);

/* 23 */
DELETE FROM Student
WHERE Id IN (
	SELECT TOP 1 StudentId
	FROM  Note
	GROUP BY StudentId
	ORDER BY AVG(CAST(Nota AS DECIMAL)) ASC
)

/* 24 */
SELECT Student.Nume as Familia, STRING_AGG(ISNULL(Student.Prenume, ''), ', ') AS Fratii
FROM Student
GROUP BY Student.Nume
HAVING COUNT(*) > 1;







