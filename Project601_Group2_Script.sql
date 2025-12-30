/* Note: The data that will be shown within the SELECT * statements
for this script and returned by our business case queries will be from the 
sample data that we included within our INSERT INTO queries in this script.
The data shown in the SELECT * and business case query screenshots from the implementation 
deliverable doc reflects the full data of the tables that was loaded via data imports
into SQL Server. This script is meant to illustrate all of our queries from start to end
and how they work with the example data we've added here.*/

/* Created by: Samarth Tuli, Pearson Roberts, Alyssa Miller, Diana Kim, Matthew Rutigliano, Justin Mejia */

/* TABLE CREATION QUERIES: */
CREATE TABLE G2_SOCIAL_MEDIA_ACCOUNT (
     ACCOUNT_ID INT NOT NULL PRIMARY KEY
     , ACCOUNT_USERNAME VARCHAR(30) NOT NULL
     , ACCOUNT_OWNER_TYPE VARCHAR(10) NOT NULL CHECK (ACCOUNT_OWNER_TYPE IN ('Team', 'Coach', 'Athlete'))
     , ACCOUNT_FOLLOWER_COUNT INT NOT NULL
     );

/* Group 2: 4/7/2024 */

CREATE TABLE G2_POST (
    POST_ID INT PRIMARY KEY NOT NULL
    , POST_DATE DATE NOT NULL
    , POST_TYPE VARCHAR(10) NOT NULL CHECK (POST_TYPE IN ('Image', 'Video'))
    , POST_LIKE_COUNT INT NOT NULL
    , POST_SHARE_COUNT INT NOT NULL
    , POST_VIEW_COUNT INT NOT NULL
    , POST_COMMENT_COUNT INT NOT NULL
    , ACCOUNT_ID INT FOREIGN KEY REFERENCES G2_SOCIAL_MEDIA_ACCOUNT (ACCOUNT_ID)
    );

/* Group 2: 4/7/2024 */

CREATE TABLE G2_COACH (
	COACH_ID VARCHAR(5) NOT NULL PRIMARY KEY
	, COACH_F_NAME VARCHAR(30) NOT NULL
	, COACH_L_NAME VARCHAR(30) NOT NULL
	, COACH_DOB DATE NOT NULL
	, COACH_RANK INT NOT NULL
	, COACH_YRS_EXPERIENCE INT NOT NULL
	, ACCOUNT_ID INT FOREIGN KEY REFERENCES G2_SOCIAL_MEDIA_ACCOUNT (ACCOUNT_ID)
	);

/* Group 2: 4/7/2024 */

CREATE TABLE G2_TEAM (
	TEAM_ID VARCHAR(5) NOT NULL PRIMARY KEY 
	, TEAM_NAME VARCHAR(30) NOT NULL
	, TEAM_DIVISION VARCHAR(15) NOT NULL
	, TEAM_CITY VARCHAR(25) NOT NULL
	, TEAM_STATE VARCHAR(20) NOT NULL
	, TEAM_STADIUM_NAME VARCHAR(40) NOT NULL
	, COACH_ID VARCHAR(5) FOREIGN KEY REFERENCES G2_COACH (COACH_ID)
	, ACCOUNT_ID INT FOREIGN KEY REFERENCES G2_SOCIAL_MEDIA_ACCOUNT (ACCOUNT_ID)
	);

/* Group 2: 4/7/2024 */

CREATE TABLE G2_ATHLETE (
	ATHLETE_ID VARCHAR(5) PRIMARY KEY NOT NULL
	, ATHLETE_F_NAME VARCHAR(30) NOT NULL
	, ATHLETE_L_NAME VARCHAR(30) NOT NULL
	, ATHLETE_DOB DATE NOT NULL
	, ATHLETE_POSITION VARCHAR(30) NOT NULL
	, ATHLETE_RANK INT NOT NULL
	, TEAM_ID VARCHAR(5) FOREIGN KEY REFERENCES G2_TEAM (TEAM_ID)
	, ACCOUNT_ID INT FOREIGN KEY REFERENCES G2_SOCIAL_MEDIA_ACCOUNT (ACCOUNT_ID)
	);

/* Group 2: 4/7/2024 */

CREATE TABLE G2_PRODUCT (
	PRODUCT_ID INT PRIMARY KEY NOT NULL
	, PRODUCT_NAME VARCHAR(50) NOT NULL
	, PRODUCT_PRICE NUMERIC(5,2) NOT NULL
	, PRODUCT_TYPE VARCHAR(15) NOT NULL CHECK (PRODUCT_TYPE IN ('Ticket',   'Merchandise'))
    );

/* Group 2: 4/7/2024 */

CREATE TABLE G2_MERCHANDISE (
	PRODUCT_ID INT PRIMARY KEY
	, MERCH_TYPE VARCHAR(25) NOT NULL
    , MERCH_COLOR VARCHAR(30) NOT NULL CHECK (MERCH_COLOR IN ('Home Color Schema', 'Away Color Schema'))
	, MERCH_SIZE VARCHAR(10) NOT NULL 
	, MERCH_GENDER VARCHAR(6) NOT NULL CHECK (MERCH_GENDER IN ('Female','Male','Unisex'))
	, MERCH_MATERIAL VARCHAR(15) NOT NULL
	, FOREIGN KEY (PRODUCT_ID) REFERENCES G2_PRODUCT (PRODUCT_ID)
    ); 

/* Group 2: 4/7/2024 */

CREATE TABLE G2_TICKET (
	PRODUCT_ID INT PRIMARY KEY
	, TICKET_CLASS VARCHAR(10) NOT NULL
	, TICKET_DELIVERY VARCHAR(10) NOT NULL
	, TICKET_DISCOUNT CHAR(1) NOT NULL CHECK (TICKET_DISCOUNT IN ('Y', 'N'))
	, TICKET_VIP_REWARDS CHAR(1) NOT NULL CHECK (TICKET_VIP_REWARDS IN ('Y',  'N'))
	, FOREIGN KEY (PRODUCT_ID) REFERENCES G2_PRODUCT
	);

/* Group 2: 4/7/2024 */

CREATE TABLE G2_SALE (
	TEAM_ID VARCHAR(5)
	, PRODUCT_ID INT
	, UNITS_SOLD INT NOT NULL
	, SALE_DATE DATE NOT NULL
	, CONSTRAINT PK_sale PRIMARY KEY (TEAM_ID, PRODUCT_ID, SALE_DATE)
	, FOREIGN KEY (TEAM_ID) REFERENCES G2_TEAM
	, FOREIGN KEY (PRODUCT_ID) REFERENCES G2_PRODUCT
	);

/* Group 2: 4/7/2024 */


/*TABLE POPULATION QUERIES:*/

INSERT INTO G2_SOCIAL_MEDIA_ACCOUNT(ACCOUNT_ID, ACCOUNT_USERNAME, ACCOUNT_OWNER_TYPE, ACCOUNT_FOLLOWER_COUNT)
VALUES (325881, '@ArizonaCardinals', 'Team', 1155728),
       (417322, '@AtlantaFalcons', 'Team', 1373237),
       (878453, '@BaltimoreRavens', 'Team', 2123357),
       (854783, '@BuffaloBills', 'Team', 1753797),
       (144679, '@CarolinaPanthers', 'Team', 1934896),
	   (369673, '@JonathanGannon', 'Coach', 322812),
       (850917, '@ArthurSmith', 'Coach', 357807),
       (960606, '@JohnHarbaugh', 'Coach', 272703),
       (396491, '@SeanMcDermott', 'Coach', 200019),
       (223719, '@FrankReich', 'Coach', 484366),
	   (954013, '@BuddaBaker', 'Athlete', 300503),
       (769983, '@GradyJarrett', 'Athlete', 456844),
       (911173, '@LamarJackson', 'Athlete', 4977073),
       (447884, '@JoshAllen', 'Athlete', 1270005),
       (810764, '@BrianBurns', 'Athlete', 462019);

/* Group 2: 4/7/2024 */

INSERT INTO G2_POST(POST_ID, POST_DATE,POST_TYPE,POST_LIKE_COUNT, POST_SHARE_COUNT, POST_VIEW_COUNT, POST_COMMENT_COUNT, ACCOUNT_ID)
VALUES (1000000, '03/17/2023', 'Image', 22242, 94195,	33617, 68327, 325881),
       (1000001, '02/04/2023', 'Video', 68400, 37291, 31124, 74174, 417322),
       (1000002, '11/26/2023', 'Video', 96224, 97167, 97803, 70441, 878453),
       (1000003, '07/09/2023', 'Image', 20128, 67566, 8362, 36945, 854783),
       (1000004, '05/26/2023', 'Video', 59326, 44492, 81971, 52500, 144679);

/* Group 2: 4/7/2024 */

INSERT INTO G2_COACH (COACH_ID, COACH_F_NAME, COACH_L_NAME, COACH_DOB, COACH_RANK, COACH_YRS_EXPERIENCE, ACCOUNT_ID)
VALUES ('C14', 'Jonathan', 'Gannon', '1983-01-04', 17, 20, 369673),
	('C21', 'Arthur', 'Smith', '1982-05-27', 30, 17, 850917),
	('C18', 'John', 'Harbaugh', '1962-07-23', 20, 39, 960606),
	('C13', 'Sean', 'McDermott', '1974-03-21', 7, 25, 396491),
	('C3', 'Frank', 'Reich', '1961-12-04', 14, 27, 223719);

/* Group 2: 4/7/2024 */

INSERT INTO G2_TEAM (TEAM_ID, TEAM_NAME, TEAM_DIVISION, TEAM_CITY, TEAM_STATE, TEAM_STADIUM_NAME, COACH_ID, ACCOUNT_ID)
VALUES ('T1', 'Arizona Cardinals', 'NFC West', 'Glendale', 'Arizona', 'State Farm Stadium', 'C14', 325881),
       ('T2', 'Atlanta Falcons', 'NFC South', 'Atlanta', 'Georgia', 'Mercedes-Benz Stadium', 'C21', 417322),
       ('T3', 'Baltimore Ravens', 'AFC North', 'Baltimore', 'Maryland', 'M&T Bank Stadium', 'C18', 878453),
       ('T4', 'Buffalo Bills', 'AFC East', 'Orchard Park', 'New York', 'Highmark Stadium', 'C13', 854783),
       ('T5', 'Carolina Panthers', 'NFC South', 'Charlotte', 'North Carolina', 'Bank of America Stadium', 'C3', 144679);

/* Group 2: 4/7/2024 */

INSERT INTO G2_ATHLETE (ATHLETE_ID, ATHLETE_F_NAME, ATHLETE_L_NAME, ATHLETE_DOB, ATHLETE_POSITION, ATHLETE_RANK, TEAM_ID, ACCOUNT_ID)
VALUES ('A25', 'Budda', 'Baker', '1996-01-10', 'Safety', 73, 'T1', 954013),
	('A58', 'Grady', 'Jarrett', '1993-04-28', 'Defensive End', 63, 'T2',   769983), 
	('A80', 'Lamar', 'Jackson', '1997-01-07', 'Quarterback', 72, 'T3', 911173),
	('A14', 'Josh', 'Allen', '1996-05-21', 'Quarterback', 8, 'T4', 447884),
	('A73', 'Brian', 'Burns', '1998-04-23', 'Linebacker', 54, 'T5', 810764);

/* Group 2: 4/7/2024 */

INSERT INTO G2_PRODUCT (PRODUCT_ID, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_TYPE)
VALUES (30001, 'Men’s Home Jersey - S', 149.99, 'Merchandise'),
	 (30002, 'Men’s Home Jersey - M', 149.99, 'Merchandise'),
	 (30003, 'Men’s Home Jersey - L', 149.99, 'Merchandise'),
	 (30004, 'Men’s Home Jersey - XL', 149.99, 'Merchandise'),
	 (30036, 'Women’s Away T-Shirt - XL', 34.99, 'Merchandise'),
     (40001, 'General E-Ticket', 112.99, 'Ticket'),
     (40002, 'Premium E-Ticket', 179.99, 'Ticket'),
     (40003, 'Suite E-Ticket', 249.99, 'Ticket'),
     (40004, 'General BO-Ticket', 112.99, 'Ticket'),
     (40023, 'Premium BO-Ticket (Discount)_VIP', '143.99', 'Ticket'); 

/* Group 2: 4/7/2024 */

INSERT INTO G2_MERCHANDISE (PRODUCT_ID, MERCH_TYPE, MERCH_COLOR, MERCH_SIZE, MERCH_GENDER, MERCH_MATERIAL)
VALUES (30001, 'Jersey', 'Home Color Schema', 'S', 'Male', 'Polyester'),
	 (30002, 'Jersey', 'Home Color Schema', 'M', 'Male', 'Polyester'),
	 (30003, 'Jersey', 'Home Color Schema', 'L', 'Male', 'Polyester'),
	 (30004, 'Jersey', 'Home Color Schema', 'XL', 'Male', 'Polyester'),
	 (30036, 'T-Shirt', 'Away Color Schema', 'XL', 'Female', 'Cotton');

/* Group 2: 4/7/2024 */

INSERT INTO G2_TICKET (PRODUCT_ID, TICKET_CLASS, TICKET_DELIVERY, TICKET_DISCOUNT, TICKET_VIP_REWARDS)
VALUES (40001, 'General', 'Electronic', 'N', 'N'), 
	(40002, 'Premium', 'Electronic', 'N', 'N'),
	(40003, 'Suite', 'Electronic', 'N', 'N'),
	(40004, 'General', 'Box Office', 'N', 'N'),
	(40023, 'Premium', 'Box Office', 'Y', 'Y');

/* Group 2: 4/7/2024 */

INSERT INTO G2_SALE (TEAM_ID, PRODUCT_ID, UNITS_SOLD, SALE_DATE)
VALUES ('T1', 30036, 76, '12/13/2023'),
       ('T2', 40003, 2002, '8/29/2023'),
       ('T3', 30004, 61, '12/17/2023'),
       ('T4', 30001, 31, '12/24/2023'),
       ('T5',  40023, 2624, '2/23/2023');

/* Group 2: 4/7/2024 */

/* TABLE SELECTION QUERIES: */
SELECT * FROM G2_SOCIAL_MEDIA_ACCOUNT;
/* Group 2: 4/7/2024 */

SELECT * FROM G2_POST;
/* Group 2: 4/7/2024 */

SELECT * FROM G2_COACH;
/* Group 2: 4/7/2024 */

SELECT * FROM G2_TEAM;
/* Group 2: 4/7/2024 */

SELECT * FROM G2_ATHLETE;
/* Group 2: 4/7/2024 */

SELECT * FROM G2_PRODUCT;
/* Group 2: 4/7/2024 */

SELECT * FROM G2_TICKET;
/* Group 2: 4/7/2024 */

SELECT * FROM G2_MERCHANDISE;
/* Group 2: 4/7/2024 */

SELECT * FROM G2_SALE;
GO
/* Group 2: 4/7/2024 */

/* Stored Procedure 1 */
CREATE PROCEDURE UpdateTeamCoach
	(@COACH_F_NAME AS VARCHAR(30),
     @COACH_L_NAME AS VARCHAR(30),
     @TEAM_NAME AS VARCHAR(30))
AS
BEGIN
	 DECLARE @COACH_ID AS VARCHAR(5)
	 DECLARE @TEAM_ID AS VARCHAR(5)
	 DECLARE @COACH_Name_To_ID TABLE (COACH_ID VARCHAR(5))
INSERT INTO @COACH_Name_To_ID (COACH_ID)
SELECT COACH_ID
FROM G2_COACH
WHERE COACH_F_NAME = @COACH_F_NAME AND COACH_L_NAME = @COACH_L_NAME
	SELECT @TEAM_ID = TEAM_ID
	FROM G2_TEAM
	WHERE TEAM_NAME = @TEAM_NAME
IF (SELECT COUNT(*) FROM @COACH_Name_To_ID) = 1
	BEGIN 
	SELECT @COACH_ID = COACH_ID FROM @COACH_Name_To_ID
	UPDATE G2_TEAM
	SET COACH_ID = @COACH_ID
	WHERE TEAM_ID = @TEAM_ID
	END
ELSE IF (SELECT COUNT(*) FROM @COACH_Name_To_ID) > 1
	BEGIN PRINT 'COACH_ID needed, use UpdateTeamCoachID Procedure' END
END;
GO

/* Group 2: 4/26/2024 */

/* Stored Procedure 1.2 updating the Coach ID, to account for when coaches in the database have the same name*/

CREATE PROCEDURE UpdateTeamCoachID 
	(@COACH_ID AS VARCHAR(5),
	 @TEAM_NAME AS VARCHAR(30))
AS
BEGIN
	DECLARE @TEAM_ID AS VARCHAR(5)
	SELECT @TEAM_ID = TEAM_ID
	FROM G2_TEAM
	WHERE TEAM_NAME = @TEAM_NAME
	UPDATE G2_TEAM
	SET COACH_ID = @COACH_ID
	WHERE TEAM_ID = @TEAM_ID
END;
GO

/* Group 2: 4/26/2024 */

/* Stored Procedure 2*/
CREATE PROCEDURE UpdateTeamDivision 
	(@TEAM_DIVISION AS VARCHAR(15),
	 @TEAM_NAME AS VARCHAR(30))
AS
BEGIN
	DECLARE @TEAM_ID AS VARCHAR(5)
	SELECT @TEAM_ID = TEAM_ID
	FROM G2_TEAM
	WHERE TEAM_NAME = @TEAM_NAME
	UPDATE G2_TEAM
	SET TEAM_DIVISION = @TEAM_DIVISION
	WHERE TEAM_ID = @TEAM_ID
END;
GO

EXECUTE UpdateTeamDivision 'NFC West', 'Arizona Cardinals';
GO

/* Group 2: 4/30/2024 */

/* Stored Procedure 3 */
CREATE PROCEDURE UpdateDivisionName
	(@new_TEAM_DIVISION AS VARCHAR(15),
	 @old_TEAM_DIVISION AS VARCHAR(15))
AS
BEGIN
	UPDATE G2_TEAM
	SET TEAM_DIVISION = @new_TEAM_DIVISION
	WHERE TEAM_DIVISION = @old_TEAM_DIVISION
END;
GO

EXECUTE UpdateDivisionName @new_TEAM_DIVISION = 'AFC North', @old_TEAM_DIVISION = 'AFC Central';
GO
/* Group 2: 4/7/2024 */

/* View Creation and Selection */
CREATE VIEW [TeamAvgQ2PostEngagementSummary] AS
(SELECT t.TEAM_ID AS TeamID, t.TEAM_NAME AS TeamName, 
(AVG(p.POST_LIKE_COUNT) + AVG(p.POST_COMMENT_COUNT) + AVG(p.POST_SHARE_COUNT) + AVG(p.POST_VIEW_COUNT)) AS AvgPostEngagement
FROM G2_POST p
INNER JOIN G2_TEAM t 
ON p.ACCOUNT_ID = t.ACCOUNT_ID
WHERE MONTH (p.POST_DATE) >= 4 AND MONTH (p.POST_DATE) <= 6
GROUP BY t.TEAM_ID, t.TEAM_NAME);
GO
/* Group 2: 4/7/2024 */

SELECT * FROM [TeamAvgQ2PostEngagementSummary];
/* Group 2: 4/7/2024 */

/* BUSINESS CASE QUERIES:*/

/* Query A*/
SELECT sma.ACCOUNT_OWNER_TYPE AS 'Account Owner Type',     
(SUM(p.POST_LIKE_COUNT) + SUM(p.POST_COMMENT_COUNT) + 
 SUM(p.POST_VIEW_COUNT) + SUM(P.POST_SHARE_COUNT)) 
AS 'Total Social Media Engagement in NFL' 
FROM G2_POST p
INNER JOIN G2_SOCIAL_MEDIA_ACCOUNT sma
ON p.ACCOUNT_ID = sma.ACCOUNT_ID
WHERE p.POST_DATE BETWEEN '01/01/2023' AND '03/31/2023' 
      AND p.POST_TYPE = 'Image' 
GROUP BY sma.ACCOUNT_OWNER_TYPE
ORDER BY 'Total Social Media Engagement in NFL' DESC;
/* Group 2: 5/1/2024 */

/* Query B, added ORDER BY clause */
SELECT a.ATHLETE_F_NAME AS 'Athlete First Name', 
a.ATHLETE_L_NAME AS 'Athlete Last Name', t.TEAM_NAME AS 'Team Name' 
FROM G2_ATHLETE a
LEFT JOIN G2_SOCIAL_MEDIA_ACCOUNT sma
ON a.ACCOUNT_ID = sma.ACCOUNT_ID
INNER JOIN G2_TEAM t
ON a.TEAM_ID = t.TEAM_ID
WHERE sma.ACCOUNT_FOLLOWER_COUNT < 400000
      AND t.TEAM_DIVISION LIKE 'NFC%'
ORDER BY a.ATHLETE_F_NAME, a.ATHLETE_L_NAME;
/* Group 2: 4/26/2024 */

/* Query C */
/* The following query requires a view with a comparison operator different
from the ones used in Queries A and B. The view uses the >= and <= operators,
which are different from the = and < operators used in Queries A and B so
this requirement for Query C is satisfied. */
SELECT a.ATHLETE_F_NAME AS 'Athlete First Name', 
a.ATHLETE_L_NAME AS 'Athlete Last Name',
a.ATHLETE_RANK AS 'Athlete Rank', 
a.ATHLETE_POSITION AS 'Athlete Position',
t.TEAM_NAME AS 'Team Name'
FROM G2_ATHLETE a
INNER JOIN G2_TEAM t 
ON a.TEAM_ID = t.TEAM_ID
WHERE a.TEAM_ID =
(SELECT TeamID
 FROM [TeamAvgQ2PostEngagementSummary]
 WHERE [TeamAvgQ2PostEngagementSummary].AvgPostEngagement = 
   (SELECT MAX(AvgPostEngagement) FROM [TeamAvgQ2PostEngagementSummary]))
OR a.TEAM_ID =
(SELECT TeamID
 FROM [TeamAvgQ2PostEngagementSummary]
 WHERE [TeamAvgQ2PostEngagementSummary].AvgPostEngagement = 
   (SELECT MIN(AvgPostEngagement) FROM [TeamAvgQ2PostEngagementSummary]))
ORDER BY a.ATHLETE_RANK DESC;
/* Group 2: 4/29/2024 */

/* Query D */
SELECT
  c.COACH_RANK,
  c.COACH_ID,
  c.COACH_F_NAME,
  c.COACH_L_NAME,
  sa.ACCOUNT_FOLLOWER_COUNT,
  avg_posts.AVG_LIKE_COUNT,
  avg_posts.AVG_VIEW_COUNT,
  s.TOTAL_UNITS_SOLD
FROM
    G2_COACH AS c
LEFT JOIN G2_SOCIAL_MEDIA_ACCOUNT AS sa ON c.ACCOUNT_ID = sa.ACCOUNT_ID
LEFT JOIN
    (SELECT
     p.ACCOUNT_ID,
    AVG(p.POST_LIKE_COUNT) AS AVG_LIKE_COUNT,
     AVG(p.POST_SHARE_COUNT) AS AVG_SHARE_COUNT,
     AVG(p.POST_VIEW_COUNT) AS AVG_VIEW_COUNT,
    AVG(p.POST_COMMENT_COUNT) AS AVG_COMMENT_COUNT
    FROM
      G2_POST AS p
    GROUP BY
     p.ACCOUNT_ID) avg_posts ON c.ACCOUNT_ID = avg_posts.ACCOUNT_ID
LEFT JOIN
    (SELECT
      t.COACH_ID,
      SUM(s.UNITS_SOLD) AS TOTAL_UNITS_SOLD
    FROM
      G2_SALE AS s
    INNER JOIN G2_TEAM AS t ON s.TEAM_ID = t.TEAM_ID
    GROUP BY
     t.COACH_ID) s ON c.COACH_ID = s.COACH_ID
ORDER BY
    c.COACH_RANK;
/* Group 2: 5/1/2024 */ 

/* Query E */
SELECT S.TEAM_ID AS 'Team_ID', T.TEAM_NAME AS 'Team Name'
		, SMA.ACCOUNT_FOLLOWER_COUNT AS 'Follower Count'
		, SUM(S.UNITS_SOLD) AS 'Jerseys Sold'
		, P.PRODUCT_PRICE AS 'Jersey Price'
		, SUM((S.UNITS_SOLD * P.PRODUCT_PRICE)) AS 'Jersey Sales'
FROM G2_SALE AS S JOIN G2_PRODUCT AS P 
				  ON S.PRODUCT_ID = P.PRODUCT_ID
				  JOIN G2_TEAM AS T
				  ON S.TEAM_ID = T.TEAM_ID
				  JOIN G2_SOCIAL_MEDIA_ACCOUNT AS SMA
				  ON T.ACCOUNT_ID = SMA.ACCOUNT_ID
WHERE (P.PRODUCT_NAME LIKE '%Jersey%') 
AND (SMA.ACCOUNT_FOLLOWER_COUNT < 
		(SELECT AVG(SMA.ACCOUNT_FOLLOWER_COUNT)
		FROM G2_SOCIAL_MEDIA_ACCOUNT AS SMA
		WHERE SMA.ACCOUNT_OWNER_TYPE = 'Team'))
GROUP BY S.TEAM_ID, T.TEAM_NAME, P.PRODUCT_PRICE, SMA.ACCOUNT_FOLLOWER_COUNT
HAVING SUM(S.UNITS_SOLD) > (SELECT AVG(S.UNITS_SOLD) FROM G2_SALE AS S
							JOIN G2_PRODUCT AS P
							ON S.PRODUCT_ID = P.PRODUCT_ID
							WHERE (P.PRODUCT_NAME LIKE '%Jersey%'))
ORDER BY 'Jersey Sales' DESC, 'Follower Count';
/* Group 2: 5/1/2024 */

/* Query F */
/* Trigger Stored Procedure 1*/
/* This query is an example of an EXECUTE statement that has been adapted to work with the sample data we insert. 
  The screenshot of Query F in the implementation deliverable doc works with the data in the group database. 
  Query F here and in the deliverable both show the same functionality of the UpdateTeamCoachID procedure. */
EXECUTE UpdateTeamCoach 'Frank', 'Reich', 'Atlanta Falcons';

/* If there were multiple coaches with the same name, the user can use Stored Procedure 1.2 UpdateTeamCoachID which requires the COACH_ID
EXECUTE UpdateTeamCoachID @COACH_ID= 'C3', @TEAM_NAME= 'Atlanta Falcons';*/

SELECT *
FROM G2_TEAM
WHERE TEAM_NAME = 'Atlanta Falcons';
/* Group 2: 4/26/2024 */

/* Query G1 */
SELECT T.TEAM_NAME AS TEAM
	, AVG (PO.POST_LIKE_COUNT)AS AVERAGE_LIKES
	, AVG (PO.POST_COMMENT_COUNT) AS AVERAGE_COMMENTS
	, COUNT(DISTINCT PO.POST_ID) AS POST_COUNT
	, SUM(S.UNITS_SOLD) AS TICKET_SALES
FROM G2_TEAM AS T JOIN G2_SOCIAL_MEDIA_ACCOUNT AS SMA 
				 ON T.ACCOUNT_ID = SMA.ACCOUNT_ID
				 JOIN G2_POST AS PO
				 ON SMA.ACCOUNT_ID = PO.ACCOUNT_ID
					JOIN G2_SALE AS S
					ON T.TEAM_ID = S.TEAM_ID
					JOIN G2_PRODUCT AS P
					ON S.PRODUCT_ID = P.PRODUCT_ID
					JOIN G2_TICKET AS TI
					ON P.PRODUCT_ID = TI.PRODUCT_ID
WHERE S.PRODUCT_ID >= 40000 AND TI.TICKET_DELIVERY = 'Electronic' AND TI.TICKET_CLASS = 'Premium'
GROUP BY T.TEAM_NAME
ORDER BY TICKET_SALES DESC;
/* Group 2: 4/7/2024 */

/* Query G2 */
SELECT TOP 5
     ATHLETE_L_NAME AS 'Last Name'
	, ATHLETE_F_NAME AS 'First Name'
	, ACCOUNT_USERNAME AS 'Account Handle'
	, SUM (POST_LIKE_COUNT + POST_SHARE_COUNT + POST_VIEW_COUNT
		+ POST_COMMENT_COUNT) AS 'Total Account Engagement'
FROM G2_POST
	INNER JOIN G2_SOCIAL_MEDIA_ACCOUNT 
		ON G2_POST.ACCOUNT_ID = G2_SOCIAL_MEDIA_ACCOUNT.ACCOUNT_ID
	INNER JOIN G2_ATHLETE
		ON G2_SOCIAL_MEDIA_ACCOUNT.ACCOUNT_ID = G2_ATHLETE.ACCOUNT_ID
WHERE ACCOUNT_OWNER_TYPE = 'Athlete'
GROUP BY ATHLETE_L_NAME, ATHLETE_F_NAME, ACCOUNT_USERNAME
ORDER BY 'Total Account Engagement' DESC;
/* Group 2: 4/7/2024 */

SELECT TOP 5
     COACH_L_NAME AS 'Last Name'
	, COACH_F_NAME AS 'First Name'
	, ACCOUNT_USERNAME AS 'Account Handle'
	, SUM(POST_LIKE_COUNT + POST_SHARE_COUNT + POST_VIEW_COUNT
		+ POST_COMMENT_COUNT) AS 'Total Account Engagement'
FROM G2_POST
	INNER JOIN G2_SOCIAL_MEDIA_ACCOUNT 
		ON G2_POST.ACCOUNT_ID = G2_SOCIAL_MEDIA_ACCOUNT.ACCOUNT_ID
	INNER JOIN G2_COACH
		ON G2_SOCIAL_MEDIA_ACCOUNT.ACCOUNT_ID = G2_COACH.ACCOUNT_ID
WHERE ACCOUNT_OWNER_TYPE = 'Coach'
GROUP BY COACH_L_NAME, COACH_F_NAME, ACCOUNT_USERNAME
ORDER BY 'Total Account Engagement' DESC;
/* Group 2: 4/7/2024 */

SELECT TOP 5
     TEAM_NAME AS 'Team Name'
	, ACCOUNT_USERNAME AS 'Account Handle'
	, SUM (POST_LIKE_COUNT + POST_SHARE_COUNT + POST_VIEW_COUNT
		+ POST_COMMENT_COUNT) AS 'Total Account Engagement'
FROM G2_POST
	INNER JOIN G2_SOCIAL_MEDIA_ACCOUNT 
		ON G2_POST.ACCOUNT_ID = G2_SOCIAL_MEDIA_ACCOUNT.ACCOUNT_ID
	INNER JOIN G2_TEAM
		ON G2_SOCIAL_MEDIA_ACCOUNT.ACCOUNT_ID = G2_TEAM.ACCOUNT_ID
WHERE ACCOUNT_OWNER_TYPE = 'Team'
GROUP BY TEAM_NAME, ACCOUNT_USERNAME
ORDER BY 'Total Account Engagement' DESC;
/* Group 2: 4/7/2024 */

/* TABLE DELETION QUERIES */

DROP TABLE G2_SALE;
/* Group 2: 4/7/2024 */

DROP TABLE G2_TICKET;
/* Group 2: 4/7/2024 */

DROP TABLE G2_MERCHANDISE;
/* Group 2: 4/7/2024 */

DROP TABLE G2_PRODUCT;
/* Group 2: 4/7/2024 */

DROP TABLE G2_ATHLETE;
/* Group 2: 4/7/2024 */

DROP TABLE G2_TEAM;
/* Group 2: 4/7/2024 */

DROP TABLE G2_COACH;
/* Group 2: 4/7/2024 */

DROP TABLE G2_POST;
/* Group 2: 4/7/2024 */

DROP TABLE G2_SOCIAL_MEDIA_ACCOUNT;
/* Group 2: 4/7/2024 */


/* VIEW DELETION QUERY */

DROP VIEW [TeamAvgQ2PostEngagementSummary]; 

/* Group 2: 4/7/2024 */

/* PROCEDURE DELETION QUERIES */
DROP PROCEDURE UpdateTeamCoachID;
DROP PROCEDURE UpdateTeamCoach;
DROP PROCEDURE UpdateTeamDivision;
DROP PROCEDURE UpdateDivisionName;
GO
/* Group 2: 4/26/2024 */

