-- --------------------------------------------------------------------------------
-- Name: Erich Wagner
-- Class: SQL #2
-- Assignment: Homework 9- Rank and Row_Number
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbsSummerSQL2;			-- Get out of the master database
SET NOCOUNT ON;				-- Report only errors

-- --------------------------------------------------------------------------------
--Drop Tables
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- PROBLEM 1
-- --------------------------------------------------------------------------------

IF OBJECT_ID( 'TUserFavoriteSongs' )					IS NOT NULL DROP TABLE TUserFavoriteSongs

IF OBJECT_ID( 'TSongs' )								IS NOT NULL DROP TABLE TSongs

IF OBJECT_ID( 'TUsers' )								IS NOT NULL DROP TABLE TUsers

IF OBJECT_ID( 'TGenres' )								IS NOT NULL DROP TABLE TGenres

-- --------------------------------------------------------------------------------
-- PROBLEM 2
-- --------------------------------------------------------------------------------

IF OBJECT_ID( 'TCourseStudents' )						IS NOT NULL DROP TABLE TCourseStudents

IF OBJECT_ID( 'TGrades' )								IS NOT NULL DROP TABLE TGrades

IF OBJECT_ID( 'TStudents' )								IS NOT NULL DROP TABLE TStudents

IF OBJECT_ID( 'TCourses' )								IS NOT NULL DROP TABLE TCourses

IF OBJECT_ID( 'TRooms' )								IS NOT NULL DROP TABLE TRooms

IF OBJECT_ID( 'TInstructors' )							IS NOT NULL DROP TABLE TInstructors

IF OBJECT_ID( 'TMajors' )								IS NOT NULL DROP TABLE TMajors

-- --------------------------------------------------------------------------------
-- PROBLEM 3
-- --------------------------------------------------------------------------------

IF OBJECT_ID( 'TGameTeamPlayerPoints' )					IS NOT NULL DROP TABLE TGameTeamPlayerPoints

IF OBJECT_ID( 'TGameTeams' )							IS NOT NULL DROP TABLE TGameTeams

IF OBJECT_ID( 'TTeamPlayers' )							IS NOT NULL DROP TABLE TTeamPlayers

IF OBJECT_ID( 'TTeams' )								IS NOT NULL DROP TABLE TTeams

IF OBJECT_ID( 'TPlayers' )								IS NOT NULL DROP TABLE TPlayers

IF OBJECT_ID( 'TTeamRoles' )							IS NOT NULL DROP TABLE TTeamRoles

IF OBJECT_ID( 'TGames' )								IS NOT NULL DROP TABLE TGames

IF OBJECT_ID( 'TDivisions' )							IS NOT NULL DROP TABLE TDivisions

-- --------------------------------------------------------------------------------
--Create Tables
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- PROBLEM 1
-- --------------------------------------------------------------------------------

CREATE TABLE TUsers
(
	intUserID								INTEGER				NOT NULL
	,strFirstName							VARCHAR(50)			NOT NULL
	,strLastName							VARCHAR(50)			NOT NULL
	,CONSTRAINT TUsers_PK PRIMARY KEY (intUserID)
)

CREATE TABLE TSongs
(
	intSongID								INTEGER				NOT NULL
	,strSong								VARCHAR(50)			NOT NULL
	,strArtist								VARCHAR(50)			NOT NULL
	,intGenreID								INTEGER				NOT NULL
	,CONSTRAINT TSongs_PK PRIMARY KEY (intSongID)
)

CREATE TABLE TUserFavoriteSongs
(
	intUserID								INTEGER				NOT NULL
	,intSongID								INTEGER				NOT NULL
	,intSortOrder							INTEGER				NOT NULL
	,CONSTRAINT TUserFavoriteSongs_PK PRIMARY KEY (intUserID, intSongID)
)

CREATE TABLE TGenres
(
	intGenreID								INTEGER				NOT NULL
	,strGenre								VARCHAR(50)			NOT NULL
	,CONSTRAINT TGenres_PK PRIMARY KEY (intGenreID)

)

-- --------------------------------------------------------------------------------
-- PROBLEM 2
-- --------------------------------------------------------------------------------

CREATE TABLE TCourses
(
	intCourseID								INTEGER				NOT NULL
	,strCourse								VARCHAR(50)			NOT NULL
	,strDesc								VARCHAR(50)			NOT NULL
	,intInstructorID						INTEGER				NOT NULL
	,intRoomID								INTEGER				NOT NULL
	,strMeetingTimes						VARCHAR(50)			NOT NULL
	,decCreditHours							DECIMAL				NOT NULL
	,CONSTRAINT TCourses_PK PRIMARY KEY (intCourseID)	
)


CREATE TABLE TStudents
(
	intStudentID							INTEGER				NOT NULL
	,strFirstName							VARCHAR(50)			NOT NULL
	,strLastName							VARCHAR(50)			NOT NULL
	,intMajorID								INTEGER				NOT NULL
	,CONSTRAINT TStudents_PK PRIMARY KEY (intStudentID)
)

CREATE TABLE TInstructors
(
	intInstructorID							INTEGER				NOT NULL
	,strFirstName							VARCHAR(50)			NOT NULL
	,strLastName							VARCHAR(50)			NOT NULL
	,CONSTRAINT TInstructors_PK PRIMARY KEY (intInstructorID)
)

CREATE TABLE TGrades
(
	intGradeID								INTEGER				NOT NULL
	,strGradeLetter							VARCHAR(50)			NOT NULL
	,decGradePointValue						DECIMAL				NOT NULL
	,CONSTRAINT TGrades_PK PRIMARY KEY (intGradeID)
)

CREATE TABLE TRooms
(
	intRoomID								INTEGER				NOT NULL
	,strRoomNumber							VARCHAR(50)			NOT NULL
	,intCapacity							INTEGER				NOT NULL
	,CONSTRAINT TRooms_PK PRIMARY KEY (intRoomID)
)

CREATE TABLE TCourseStudents
(
	intCourseID								INTEGER				NOT NULL
	,intStudentID							INTEGER				NOT NULL
	,intGradeID								INTEGER				NOT NULL
	,CONSTRAINT TCourseStudents_PK PRIMARY KEY (intCourseID, intStudentID)
)

CREATE TABLE TMajors
(
	intMajorID								INTEGER				NOT NULL
	,strMajor								VARCHAR(50)			NOT NULL
	,CONSTRAINT TMajors_PK PRIMARY KEY (intMajorID)

)
-- --------------------------------------------------------------------------------
-- PROBLEM 3
-- --------------------------------------------------------------------------------


CREATE TABLE TPlayers
(
	intPlayerID								INTEGER				NOT NULL
	,strFirstName							VARCHAR(50)			NOT NULL
	,strLastName							VARCHAR(50)			NOT NULL
	,CONSTRAINT TPlayers_PK PRIMARY KEY (intPlayerID) 
)

CREATE TABLE TTeams
(
	intTeamID								INTEGER				NOT NULL
	,strTeam								VARCHAR(50)			NOT NULL
	,strMascot								VARCHAR(50)			NOT NULL
	,intDivisionID							INTEGER				NOT NULL
	,CONSTRAINT TTeams_PK PRIMARY KEY (intTeamID)
)

CREATE TABLE TTeamPlayers
(
	intTeamID								INTEGER				NOT NULL
	,intPlayerID							INTEGER				NOT NULL
	,CONSTRAINT TTeamPlayers_PK PRIMARY KEY (intTeamID, intPlayerID)
)

CREATE TABLE TDivisions
(
	intDivisionID							INTEGER				NOT NULL
	,strDivision							VARCHAR(50)			NOT NULL
	,CONSTRAINT TDivisions_PK PRIMARY KEY (intDivisionID)
)

CREATE TABLE TGames
(
	intGameID								INTEGER				NOT NULL
	,dtmGamePlayed							DATETIME			NOT NULL
	,strVenue								VARCHAR(50)			NOT NULL
	,CONSTRAINT TGames_PK PRIMARY KEY (intGameID)
)

CREATE TABLE TGameTeams
(
	intGameID								INTEGER				NOT NULL
	,intTeamID								INTEGER				NOT NULL
	,intTeamRoleID							INTEGER				NOT NULL
	,CONSTRAINT TGameTeams_PK PRIMARY KEY (intGameID, intTeamID)
)

CREATE TABLE TGameTeamPlayerPoints
(
	intGameID								INTEGER				NOT NULL
	,intTeamID								INTEGER				NOT NULL
	,intPlayerID							INTEGER				NOT NULL
	,intPoints								INTEGER				NOT NULL
	,CONSTRAINT TGameTeamPlayerPoints_PK PRIMARY KEY (intGameID, intTeamID, intPlayerID)
)

CREATE TABLE TTeamRoles
(
	intTeamRoleID							INTEGER				NOT NULL
	,strTeamRole							VARCHAR(50)			NOT NULL
	,intSortOrder							INTEGER				NOT NULL
	,CONSTRAINT TTeamRoles_PK PRIMARY KEY (intTeamRoleID)
)

-- --------------------------------------------------------------------------------
-- Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child										Parent							Column(s)
-- -	-----										------							---------

-- PROBLEM 1
-------------
-- 1	TUserFavoriteSongs							TSongs							intSongID --
-- 2	TUserFavoriteSongs							TUsers							intUserID --
-- 3	TSongs										TGenres							intGenreID --

-- PROBLEM 2
-------------
-- 4	TCourseStudents								TCourses						intCourseID --
-- 5	TCourses									TRooms							intRoomID --
-- 6	TCourses									TInstructors					intInstructorID --
-- 7	TCourseStudents								TStudents						intStudentID --
-- 8	TCourseStudents								TGrades							intGradeID --
-- 9	TStudents									TMajors							intMajorID --

-- PROBLEM 3
-------------

-- 10	TTeamPlayers								TTeams							intTeamID   --
-- 11	TTeamPlayers								TPlayers						intPlayerID --
-- 12	TGameTeamPlayerPoints						TTeamPlayers					intTeamID, intPlayerID --
-- 13	TGameTeamPlayerPoints						TGames							intGameID --
-- 14	TGameTeams									TTeamRoles						intTeamRoleID --
-- 15	TTeams										TDivisions						intDivisionID --
-- 16	TGameTeams									TGames							intGameID --


-- PROBLEM 1
-------------

--1
ALTER TABLE TUserFavoriteSongs ADD CONSTRAINT TUserFavoriteSongs_TSongs_FK
FOREIGN KEY ( intSongID ) REFERENCES TSongs( intSongID )

--2
ALTER TABLE TUserFavoriteSongs ADD CONSTRAINT TUserFavoriteSongs_TUsers_FK
FOREIGN KEY ( intUserID ) REFERENCES TUsers( intUserID )

--3
ALTER TABLE TSongs ADD CONSTRAINT TSongs_TGenres_FK
FOREIGN KEY ( intGenreID ) REFERENCES TGenres( intGenreID )


-- PROBLEM 2
-------------
--4
ALTER TABLE TCourseStudents ADD CONSTRAINT TCourseStudents_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses( intCourseID )

--5
ALTER TABLE TCourses ADD CONSTRAINT TCourses_TRooms_FK
FOREIGN KEY ( intRoomID ) REFERENCES TRooms( intRoomID )

--6
ALTER TABLE TCourses ADD CONSTRAINT TCourses_TInstructors_FK
FOREIGN KEY ( intInstructorID ) REFERENCES TInstructors( intInstructorID )

--7
ALTER TABLE TCourseStudents ADD CONSTRAINT TCourseStudents_TStudents_FK
FOREIGN KEY ( intStudentID ) REFERENCES TStudents( intStudentID )

--8
ALTER TABLE TCourseStudents ADD CONSTRAINT TCourseStudents_TGrades_FK
FOREIGN KEY ( intGradeID ) REFERENCES TGrades( intGradeID )

--9
ALTER TABLE TStudents ADD CONSTRAINT TStudents_TMajors_FK
FOREIGN KEY ( intMajorID ) REFERENCES TMajors( intMajorID )

-- PROBLEM 3
-------------
--10
ALTER TABLE TTeamPlayers ADD CONSTRAINT TTeamPlayers_TTeams_FK
FOREIGN KEY ( intTeamID ) REFERENCES TTeams( intTeamID )

--11
ALTER TABLE TTeamPlayers ADD CONSTRAINT TTeamPlayers_TPlayers_FK
FOREIGN KEY ( intPlayerID ) REFERENCES TPlayers ( intPlayerID )

--12
ALTER TABLE TGameTeamPlayerPoints ADD CONSTRAINT TGameTeamPlayerPoints_TTeamPlayers_FK
FOREIGN KEY ( intTeamID, intPlayerID ) REFERENCES TTeamPlayers ( intTeamID, intPlayerID )

--13
ALTER TABLE TGameTeamPlayerPoints ADD CONSTRAINT TGameTeamPlayerPoints_TGames_FK
FOREIGN KEY ( intGameID ) REFERENCES TGames ( intGameID )

--14
ALTER TABLE TGameTeams ADD CONSTRAINT TGameTeams_TTeamRoles_FK
FOREIGN KEY ( intTeamRoleID ) REFERENCES TTeamRoles ( intTeamRoleID )

--15
ALTER TABLE TTeams ADD CONSTRAINT TTeams_TDivisions_FK
FOREIGN KEY ( intDivisionID ) REFERENCES TDivisions ( intDivisionID )

--16
ALTER TABLE TGameTeams ADD CONSTRAINT TGameTeams_TGames_FK
FOREIGN KEY ( intGameID ) REFERENCES TGames ( intGameID )

--Constraint to allow one role a team per game

ALTER TABLE TGameTeams ADD CONSTRAINT TGameTeams_OneHomeAndOneAwayTeam_UN
UNIQUE( intGameID, intTeamRoleID )



-- --------------------------------------------------------------------------------
--							PROBLEM 1											 --
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
--Add Records into Genres
-- --------------------------------------------------------------------------------
INSERT INTO TGenres(intGenreID, strGenre)
VALUES(1, 'Blues')
	 ,(2, 'Jazz')
	 ,(3, 'Rock and Roll')
	 ,(4, 'Heavy Metal')
	 ,(5, 'Pop')



-- --------------------------------------------------------------------------------
--Add Records into Users
-- --------------------------------------------------------------------------------
INSERT INTO TUsers(intUserID, strFirstName, strLastName)
VALUES(1, 'Jeff', 'Martin')
	 ,(2, 'Jeanie', 'Jason')
	 ,(3, 'Scout', 'Wagner')
	 ,(4, 'Bruce', 'Weils')
	 ,(5, 'Eye','Tunes')
	 ,(6, 'Sub', 'Par')

-- --------------------------------------------------------------------------------
--Add Records into Songs
-- --------------------------------------------------------------------------------
INSERT INTO TSongs(intSongID, strSong, strArtist, intGenreID)
VALUES(1, 'Livin on a Prayer', 'Bon Jovi', 3)
	 ,(2, 'Hungry Like the Wolf', 'Duran Duran', 3)
	 ,(3, 'Dont Stop Believing', 'Journey', 3)
	 ,(4, 'Beat It', 'Michael Jackson', 5)
	 ,(5, 'Welcome to the Jungle','Guns N Roses', 3)
	 ,(6, 'Mr. Roboto', 'Styx', 3)
	 ,(7, 'Down Under', 'Men at Work', 3)
	 ,(8, 'I Just Called To Say I Love You', 'Stevie Wonder', 1)
	 ,(9, 'Master of Puppets', 'Metallica', 4)
	 ,(10, 'Back in Black', 'AC/DC', 3)
	 ,(11, 'Every Breath You Take' , 'The Police', 3)
	 ,(12, 'Another One Bites The Dust', 'Queen', 3)
	 ,(13, 'Eye of the Tiger', 'Survivor', 3)
	 ,(14, 'Never Gonna Give You Up', 'Rick Astley', 5)
	 ,(15, 'Princes of the Universe', 'Queen', 3)
	 ,(16, 'Who Wants to Live Forever', 'Queen', 3)
	 ,(17, 'For Whom the Bell Tolls', 'Metallica', 4)
	 ,(18, 'Animal', 'Def Leppard', 3)
	 ,(19, 'Pour Some Sugar on Me', 'Def Leppard', 3)
	 ,(20, 'Hysteria', 'Def Leppard', 3)
	 ,(21, 'Thriller', 'Michael Jackson', 5)
	 ,(22, 'Billie Jean','Michael Jackson', 5)
	 ,(23, 'P.Y.T. (Pretty Young Thing)','Michael Jackson', 5)
	 ,(24, 'We Are the World','Michael Jackson', 5)
	 ,(25, 'Man in the Mirror','Michael Jackson', 5)
	 ,(26,'Blitzkrieg','Metallica', 4)
	 ,(27,'Fight Fire with Fire','Metallica', 4)
	 ,(28,'The Call of Ktulu','Metallica', 4)
	 ,(29,'Ride the Lightning','Metallica', 4)



-- --------------------------------------------------------------------------------
--Add Records into User favorite songs
-- --------------------------------------------------------------------------------
--USER 1
INSERT INTO TUserFavoriteSongs(intUserID, intSongID, intSortOrder)
VALUES(1,1,1)
	 ,(1,2,2)
	 ,(1,20,3)
	 ,(1,19,4)
	 ,(1,18,5)
	 ,(1,6,6)
	 ,(1,12,7)
	 ,(1,15,8)
	 ,(1,16,9)
--USER 2
INSERT INTO TUserFavoriteSongs(intUserID, intSongID, intSortOrder)
VALUES(2,5,1)
	 ,(2,12,2)
	 ,(2,15,3)
	 ,(2,16,4)
--USER 3
INSERT INTO TUserFavoriteSongs(intUserID, intSongID, intSortOrder)
VALUES(3,12,1)
	 ,(3,13,2)
	 ,(3,11,3)
	 ,(3,9,4)
	 ,(3,17,5)
	 ,(3,26,6)
	 ,(3,25,7)
	 ,(3,24,8)
	 ,(3,23,9)
--USER 4
INSERT INTO TUserFavoriteSongs(intUserID, intSongID, intSortOrder)
VALUES(4,5,1)
	 ,(4,8,2)
	 ,(4,10,3)
	 ,(4,28,4)
	 ,(4,29,5)
	 ,(4,21,6)
	 ,(4,4,7)
--USER 5
INSERT INTO TUserFavoriteSongs(intUserID, intSongID, intSortOrder)
VALUES(5,4,1)
	 ,(5,9,2)
	 ,(5,21,3)
	 ,(5,17,4)
	 ,(5,22,5)
	 ,(5,23,6)
	 ,(5,24,7)
	 ,(5,26,8)
	 ,(5,27,9)
	 ,(5,28,10)
	 ,(5,25,11)
	 ,(5,29,12)
	 ,(5,5,13)
--USER 6
INSERT INTO TUserFavoriteSongs(intUserID, intSongID, intSortOrder)
VALUES(6,12,2)
	 ,(6,1,3)
	 ,(6,5,1)
-- --------------------------------------------------------------------------------
--							PROBLEM 2											 --
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
--Add Records into Majors
-- --------------------------------------------------------------------------------
INSERT INTO TMajors(intMajorID, strMajor)
VALUES(1, 'CPDM')
	 ,(2, 'BPA')
	 ,(3, 'VET')
	 ,(4, 'Comedy')
	 ,(5, 'Physical Therapist')
-- --------------------------------------------------------------------------------
--Add Records into Rooms
-- --------------------------------------------------------------------------------

INSERT INTO TRooms(intRoomID, strRoomNumber, intCapacity)
VALUES (1, '410', 20)
	  ,(2, '411', 15)
	  ,(3, '420',16)
	  ,(4, '405',10)
	  ,(5, '430',40)
	  ,(6, 'Online', 35)


-- --------------------------------------------------------------------------------
--Add Records into Instructors
-- --------------------------------------------------------------------------------
INSERT INTO TInstructors(intInstructorID, strFirstName, strLastName)
VALUES (1, 'Bob', 'Nields')
	  ,(2, 'Bill', 'Nye')
	  ,(3, 'Jacob', 'Wagner')
	  ,(4, 'Leroy', 'Jenkins')

-- --------------------------------------------------------------------------------
--Add Records into Courses
-- --------------------------------------------------------------------------------
INSERT INTO TCourses(intCourseID, strCourse, strDesc, intInstructorID, intRoomID, strMeetingTimes, decCreditHours)
VALUES (1, 'IT-101-001', '.NET Programming 1', 1, 1, 'MWF', 2.0)
	  ,(2, 'CPDM-115-002', 'Computers and stuff', 3, 3, 'TR', 3.0)
	  ,(3, 'IT-123-456', 'Typewriter vs Computer', 2, 5, 'MTWRF', 1.0)
	  ,(4, 'IT-111-001', 'Database Design & SQL1', 1, 2, 'MWR',2.0)
	  ,(5, 'IT-112-401','Database Design & SQL2', 4, 6, 'MTWRF', 2.0)
	  ,(6, 'ECO-105-004', 'MicroEconomics', 4, 4, 'MWF', 1.0)


-- --------------------------------------------------------------------------------
--Add Records into Students
-- --------------------------------------------------------------------------------
INSERT INTO TStudents(intStudentID,strFirstName, strLastName, intMajorID)
VALUES (1, 'Erich','Wagner', 1)
	  ,(2, 'Jared','Walker', 2)
	  ,(3, 'Mike','Ike', 2)
	  ,(4, 'Chris','Bail', 3)
	  ,(5, 'Tiny','Tim', 1)
	  ,(6, 'CJ','Kelly', 1)
	  ,(7, 'Carrie','Jean', 3)
	  ,(8, 'Shawn','Thomas', 4)
	  ,(9, 'Harry','Porter', 5)
	  ,(10, 'Michael','Winslow', 4)

-- --------------------------------------------------------------------------------
--Add Records into Grades
-- --------------------------------------------------------------------------------

INSERT INTO TGrades(intGradeID, strGradeLetter, decGradePointValue)
VALUES(1, 'A', 4.0)
	 ,(2, 'B', 3.0)
	 ,(3, 'C', 2.0)
	 ,(4, 'D', 1.0)
	 ,(5, 'F', 0.0)
	 ,(6, 'S', 4.0)  --Satisfactory
	 ,(7, 'N', 0.0)  --Not Satisfactory
	 ,(8, 'I', 0.0)  --Incomplete
	 ,(9, 'W', 0.0)  --Withdrawl

-- --------------------------------------------------------------------------------
--Add Records into Course Students
-- --------------------------------------------------------------------------------
INSERT INTO TCourseStudents(intCourseID, intStudentID, intGradeID)
VALUES (1,1,2)
	  ,(1,2,4)
	  ,(1,3,1)
	  ,(1,4,6)
	  ,(2,6,8)
	  ,(2,10,9)
	  ,(2,8,4)
	  ,(2,7,2)
	  ,(3,5,3)
	  ,(3,1,3)
	  ,(3,3,5)
	  ,(3,6,4)
	  ,(4,1,5)
	  ,(4,2,7)
	  ,(4,3,7)
	  ,(4,4,8)
	  ,(5,5,1)
	  ,(5,6,2)
	  ,(5,7,3)
	  ,(5,8,3)
	  ,(6,10,2)
	  ,(6,9,1)
	  ,(6,6,8)
	  ,(6,4,9)

-- --------------------------------------------------------------------------------
--							PROBLEM 3											 --
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
--Add Records into Divisions
-- --------------------------------------------------------------------------------
INSERT INTO TDivisions(intDivisionID, strDivision)
VALUES(1, 'North')
	 ,(2, 'East')
	 ,(3, 'South')
	 ,(4, 'West')


-- --------------------------------------------------------------------------------
--Add Records into Teams
-- --------------------------------------------------------------------------------
INSERT INTO TTeams(intTeamID, strTeam, strMascot, intDivisionID)
VALUES(1, 'Swimming', 'Bearcat', 1)
	 ,(2, 'Baseball','Cougar', 3)
	 ,(3, 'Football', 'Bengal Tiger', 2)
	 ,(4, 'Chess', 'Knight', 4)
	 ,(5, 'Burro Racers', 'Donkey', 4)


-- --------------------------------------------------------------------------------
--Add Records into Players
-- --------------------------------------------------------------------------------
INSERT INTO TPlayers(intPlayerID, strFirstName, strLastName)
VALUES(1, 'Babe', 'Ruth')
	 ,(2, 'Andy', 'Dalton')
	 ,(3, 'Michael', 'Phelps')
	 ,(4, 'Raeya', 'Gordon' )
	 ,(5, 'Tobias', 'Hoffman' )
	 ,(6, 'Swinga', 'Bat' )
	 ,(7, 'Danny', 'Phan')
	 ,(8, 'Vernon', 'Ford')
	 ,(9, 'Nick', 'Smoker')
	 ,(10, 'Kantmiss', 'Evershot')
	 ,(11, 'Phil', 'Mont')
	 ,(12, 'Spooder', 'Mon')
	 ,(13, 'Jake', 'Walker')
-- --------------------------------------------------------------------------------
--Add Records into TeamPlayers
-- --------------------------------------------------------------------------------
INSERT INTO TTeamPlayers(intTeamID, intPlayerID)
VALUES
--Team 1
	  (1,3)
	 ,(1,4)
	 ,(1,5)
	 ,(1,8)
--Team 2
	 ,(2,1)
	 ,(2,6)
	 ,(2,10)
	 ,(2,9)
--Team 3
	 ,(3,2)
	 ,(3,13)
	 ,(3,7)
	 ,(3,10)
--Team 4
	 ,(4,6)
	 ,(4,11)
--Team 5
	 ,(5,12)
	 ,(5,8)
	 ,(5,9)
	 ,(5,5)
	 ,(5,11)
-- --------------------------------------------------------------------------------
--Add Records into Games
-- --------------------------------------------------------------------------------
INSERT INTO TGames(intGameID, dtmGamePlayed, strVenue)
VALUES(1, '12-7-1995', 'Paul Brown Stadium')
	 ,(2, '11-7-1997', 'Great American Ball Park')
	 ,(3, '12-27-2002', 'US Bank Arena')
	 ,(4, '6-30-2017', 'Colloseum')
	 ,(5, '1-30-1998','Nippert Stadium')

-- --------------------------------------------------------------------------------
--Add Records into Team Roles
-- --------------------------------------------------------------------------------

INSERT INTO TTeamRoles(intTeamRoleID, strTeamRole, intSortOrder)
VALUES(1, 'Home', 1)
	 ,(2, 'Away', 2)


-- --------------------------------------------------------------------------------
--Add Records into Game Teams
-- --------------------------------------------------------------------------------
INSERT INTO TGameTeams(intGameID, intTeamID, intTeamRoleID)
VALUES
--Game 1
	  (1,1,1)
	 ,(1,2,2)
--Game 2
	 ,(2,3,1)
	 ,(2,1,2)
--Game 3
	 ,(3,3,1)
	 ,(3,4,2)
--Game 4
	 ,(4,1,1)
	 ,(4,4,2)
--Game 5
	 ,(5,3,2)
	 ,(5,5,1)

-- --------------------------------------------------------------------------------
--Add Records into Game Team Player Points
-- --------------------------------------------------------------------------------
INSERT INTO TGameTeamPlayerPoints(intGameID, intTeamID, intPlayerID, intPoints)
VALUES
--Game 1
	  (1,1,3,12)
	 ,(1, 1, 4, 2)
	 ,(1, 1, 8, 8)

	 ,(1, 2, 6, 19)
	 ,(1, 2, 10, 40)
	 ,(1,2,1,10)
--Game 2	 
	 ,(2,3,2,11)
	 ,(2, 3, 13, 12)
	 ,(2, 3, 10, 4)

	 ,(2,1,5,6)
	 ,(2, 1, 4, 4)
	 ,(2, 1, 3, 4)
--Game 3
	 ,(3, 3, 2, 25)
	 ,(3, 3, 13, 2)
	 ,(3, 3, 7, 5)

	 ,(3, 4, 6, 5)
	 ,(3, 4, 11, 4)
--Game 4
	 ,(4, 1, 3, 20)
	 ,(4, 1, 4, 1)
	 ,(4, 1, 8, 16)

	 ,(4, 4, 6, 15)
	 ,(4, 4, 11, 35)
	 
--Game 5
	 ,(5, 3, 2, 15)
	 ,(5, 3, 13, 15)
	 ,(5, 3, 7, 14)

	 ,(5, 5, 12, 6)
	 ,(5, 5, 5, 8)
	 ,(5, 5, 11, 9)
-- --------------------------------------------------------------------------------
--							PROBLEM 1											 --
-- --------------------------------------------------------------------------------
--4)Write the query that will show in each genre (ID and name ALWAYS) the top two songs (ID and name ALWAYS) using a weighted count.
-- If the user has the song listed as their favorite this is worth a point value of 5.  If the user has the song listed as their second favorite
-- this is worth a point value of 3.  If the user has the song listed as their third favorite this is worth a point value of 1. 
-- If the user has the song listed as their fourth favorite or less this is worth a point value of 0.5.


SELECT DISTINCT TOP 2
	TG.intGenreID
   ,TG.strGenre
   ,TS.intSongID
   ,TS.strSong
   ,SUM(CASE TUFS.intSortOrder
		WHEN 1 THEN 5
		WHEN 2 THEN 3
		WHEN 3 THEN 1
		ELSE 0.5
	END) AS intWeightedCount
FROM
	TSongs AS TS
		LEFT OUTER JOIN TUserFavoriteSongs AS TUFS
		ON( TS.intSongID = TUFS.intSongID )
		LEFT OUTER JOIN TGenres AS TG
		ON( TS.intGenreID = TG.intGenreID )
GROUP BY TG.intGenreID, TG.strGenre, TS.intSongID, TS.strSong
ORDER BY
	intWeightedCount desc




--5)	Write the query that will show the 3rd – 5th most popular songs regardless of genre based on the weighted count.
--  You have to use the ROW_NUMBER function even if you running SQL Server 2012.

SELECT DISTINCT
	TG.intGenreID
   ,TG.strGenre
   ,TS.intSongID
   ,TS.strSong
   ,RANK() OVER 
	(PARTITION BY
	TG.intGenreID
	ORDER BY
	SUM(CASE TUFS.intSortOrder
		WHEN 1 THEN 5
		WHEN 2 THEN 3
		WHEN 3 THEN 1
		ELSE 0.5
	END)) AS intWeightedCount
FROM
	TSongs AS TS
		LEFT OUTER JOIN TUserFavoriteSongs AS TUFS
		ON( TS.intSongID = TUFS.intSongID )
		LEFT OUTER JOIN TGenres AS TG
		ON( TS.intGenreID = TG.intGenreID )
GROUP BY TG.intGenreID, TG.strGenre, TS.intSongID, TS.strSong
ORDER BY
	intWeightedCount desc
OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY

-- --------------------------------------------------------------------------------
--							PROBLEM 2											 --
-- --------------------------------------------------------------------------------
--4)	Write the query that will show for each major (ID and name ALWAYS) the top two students (ID and name ALWAYS) with the highest GPA.
--  Don't count withdrawals or incompletes in the GPA calculations.  Exclude students that haven't taken any courses.

SELECT DISTINCT TOP 2
TS.intStudentID,
TS.strLastName + ', ' + TS.strFirstName AS strStudent,
TM.intMajorID,
TM.strMajor,
(SUM(TCS.intGradeID) / SUM(TC.decCreditHours)) AS GPA
FROM
	TMajors AS TM
	,TStudents AS TS
	,TGrades AS TG
	,TCourseStudents AS TCS
	,TCourses AS TC
WHERE
	TS.intStudentID = TCS.intStudentID
and	TM.intMajorID = TS.intMajorID
and TC.intCourseID = TCS.intCourseID
and TCS.intStudentID not in
(
	SELECT TCS.intStudentID
	FROM TGrades AS TG
		,TCourseStudents AS TCS
	WHERE
		TCS.intGradeID in (8,9)
)
GROUP BY TS.intStudentID, TS.strLastName, TS.strFirstName, TM.intMajorID, TM.strMajor
ORDER BY GPA desc

--5)	Write the query that will show the 3rd – 5th best students regardless of major based on their GPA.

SELECT DISTINCT
TS.intStudentID,
TS.strLastName + ', ' + TS.strFirstName AS strStudent,
TM.strMajor,
(SUM(TCS.intGradeID) / SUM(TC.decCreditHours)) AS GPA
FROM
	TMajors AS TM
	,TStudents AS TS
	,TGrades AS TG
	,TCourseStudents AS TCS
	,TCourses AS TC
WHERE
	TS.intStudentID = TCS.intStudentID
and	TM.intMajorID = TS.intMajorID
and TC.intCourseID = TCS.intCourseID
and TCS.intStudentID not in
(
	SELECT TCS.intStudentID
	FROM TGrades AS TG
		,TCourseStudents AS TCS
	WHERE
		TCS.intGradeID in (8,9)
)
GROUP BY TS.intStudentID, TS.strLastName, TS.strFirstName, TM.strMajor
ORDER BY GPA desc
OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY


-- --------------------------------------------------------------------------------
--							PROBLEM 3										 --
-- --------------------------------------------------------------------------------

--3)	Add a constraint that prevents more than one team from having the same role on a particular game.
--  Hint: it's not a foreign key constraint.  Double hint: don't change the PK columns.


--4)	Add sample data (at least two inserts per table).  Make sure you have at least one team with no players on it.
--  Make sure you have at least one player not on any team.

--5)	Write the query that will show for each division (ID and name ALWAYS) the top two players (ID and name ALWAYS) with most points scored.

SELECT DISTINCT TOP 2
	TD.intDivisionID, TD.strDivision, TP.intPlayerID, TP.strLastName + ', ' + TP.strFirstName AS strPlayer, SUM(TGTPP.intPoints) AS PlayerPoints
FROM
	TDivisions AS TD
   ,TTeams AS TT
   ,TPlayers AS TP
   ,TGameTeamPlayerPoints AS TGTPP
WHERE
	TD.intDivisionID = TT.intDivisionID
AND TT.intTeamID = TGTPP.intTeamID
AND TP.intPlayerID = TGTPP.intPlayerID

GROUP BY TD.intDivisionID, TD.strDivision, TP.intPlayerID, TP.strLastName, TP.strFirstName
ORDER BY PlayerPoints desc

--6)	Write the query that will show for each division (ID and name ALWAYS) the team (ID and name ALWAYS) with the most wins.
--  Yes, this is really, really hard.  You can look at it as either an obstacle or an opportunity.  I prefer the later.  Why? 
-- Because not many people know how to solve it.  That makes my skill set rare and, therefore, valuable!
--  Once you learn how to solve the problem you will also have a rare and valuable skill set.

SELECT DISTINCT TOP 1
	TD.intDivisionID,
	TD.strDivision,
	TT.intTeamID,
	TT.strTeam
FROM
	TTeams AS TT
   ,TDivisions AS TD
WHERE
	TT.intDivisionID = TD.intDivisionID