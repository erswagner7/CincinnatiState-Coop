-- --------------------------------------------------------------------------------
-- Name: Erich Wagner
-- Class: SQL #1
-- Abstract: Final Project
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbsFinalProject2;		-- Get out of the master database
SET NOCOUNT ON;				-- Report only errors

-- --------------------------------------------------------------------------------
--Drop Tables
-- --------------------------------------------------------------------------------

IF OBJECT_ID( 'TVendorMaterials' )								IS NOT NULL DROP TABLE TVendorMaterials

IF OBJECT_ID( 'TCustomerJobMaterials' )							IS NOT NULL DROP TABLE TCustomerJobMaterials

IF OBJECT_ID( 'TWorkerSkills' )									IS NOT NULL DROP TABLE TWorkerSkills

IF OBJECT_ID( 'TCustomerJobWorkers' )							IS NOT NULL DROP TABLE TCustomerJobWorkers

IF OBJECT_ID( 'TCustomerJobs' )									IS NOT NULL DROP TABLE TCustomerJobs

IF OBJECT_ID( 'TVendors' )										IS NOT NULL DROP TABLE TVendors

IF OBJECT_ID( 'TMaterials' )									IS NOT NULL DROP TABLE TMaterials

IF OBJECT_ID( 'TStatuses' )										IS NOT NULL DROP TABLE TStatuses

IF OBJECT_ID( 'TWorkers' )										IS NOT NULL DROP TABLE TWorkers

IF OBJECT_ID( 'TSkills' )										IS NOT NULL DROP TABLE TSkills

IF OBJECT_ID( 'TCustomers' )									IS NOT NULL DROP TABLE TCustomers

IF OBJECT_ID( 'TStates' )										IS NOT NULL DROP TABLE TStates

IF OBJECT_ID( 'VLaborCosts' )									IS NOT NULL DROP VIEW  VLaborCosts

IF OBJECT_ID( 'VTotalLaborCosts' )								IS NOT NULL DROP VIEW  VTotalLaborCosts


-- --------------------------------------------------------------------------------
--Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomers
(
	 intCustomerID					INTEGER						NOT NULL
	,strCustomerFirstName			VARCHAR(50)					NOT NULL
	,strCustomerLastName			VARCHAR(50)					NOT NULL
	,strAddress						VARCHAR(50)					NOT NULL
	,strCity						VARCHAR(50)					NOT NULL
	,intStateID						INTEGER						NOT NULL
	,strCustomerPhone				VARCHAR(50)					NOT NULL
	,strEmail						VARCHAR(50)					NOT NULL
	,CONSTRAINT TCustomer_PK PRIMARY KEY (intCustomerID) 
)

CREATE TABLE TCustomerJobs
(
	 intCustomerID					INTEGER						NOT NULL
	,intJobID						INTEGER						NOT NULL
	,strJobDescription				VARCHAR(2000)				NOT NULL
	,intStatusID					INTEGER						NOT NULL
	,dtmStartDate					DATETIME					NOT NULL
	,dtmEndDate						DATETIME					NOT NULL
	,monJobCost						MONEY						NOT NULL  --cost of job = retail price of materials + (hourly rate X hours worked)
	,CONSTRAINT TCustomerJobs_PK PRIMARY KEY ( intCustomerID, intJobID) 
)



CREATE TABLE TCustomerJobWorkers
(
	 intCustomerID					INTEGER						NOT NULL
	,intJobID						INTEGER						NOT NULL
	,intJobIndex					INTEGER						NOT NULL
	,intWorkerID					INTEGER						NOT NULL
	,intJobNumber					INTEGER						NOT NULL
	,intEmployeeIDNumber			INTEGER						NOT NULL
	,dtmStartDate					DATETIME					NOT NULL
	,dtmEndDate						DATETIME					NOT NULL
	,decWorkHours					DECIMAL						NOT NULL
	,CONSTRAINT TCustomerJobWorkers_PK PRIMARY KEY (intCustomerID, intJobID, intJobIndex, intWorkerID) 
)

CREATE TABLE TWorkers
(
	 intWorkerID					INTEGER						NOT NULL
	,strWorkerFirstName				VARCHAR(50)					NOT NULL
	,strWorkerLastName				VARCHAR(50)					NOT NULL
	,strWorkerAddress				VARCHAR(50)					NOT NULL
	,strCity						VARCHAR(50)					NOT NULL
	,intStateID						INTEGER						NOT NULL
	,strWorkerPhone					VARCHAR(50)					NOT NULL
	,dtmHireDate					DATETIME					NOT NULL
	,monHourlyRate					MONEY						NOT NULL
	,CONSTRAINT TWorkers_PK PRIMARY KEY (intWorkerID) 
)

CREATE TABLE TWorkerSkills
(
	 intWorkerID					INTEGER						NOT NULL
	,intSkillID						INTEGER						NOT NULL
	,intSkillIndex					INTEGER						NOT NULL
	,CONSTRAINT TWorkerSkills_PK PRIMARY KEY (intWorkerID, intSkillID, intSkillIndex) 
)

CREATE TABLE TSkills
(
	 intSkillID						INTEGER						NOT NULL
	,strSkillDesc					VARCHAR(100)				NOT NULL
	,CONSTRAINT TSkills_PK PRIMARY KEY (intSkillID) 
)

CREATE TABLE TStatuses
(
	 intStatusID					INTEGER						NOT NULL
	,strStatusDesc					VARCHAR(50)					NOT NULL
	,CONSTRAINT TStatuses_PK PRIMARY KEY (intStatusID)
)

CREATE TABLE TCustomerJobMaterials
(
	 intCustomerID					INTEGER						NOT NULL
	,intJobID						INTEGER						NOT NULL
	,intMaterialID					INTEGER						NOT NULL
	,intMaterialJobQuantity			INTEGER						NOT NULL
	,CONSTRAINT TCustomerJobMaterials_PK PRIMARY KEY (intCustomerID, intJobID, intMaterialID)
)


CREATE TABLE TMaterials
(
	 intMaterialID					INTEGER						NOT NULL
	,strMaterialDesc				VARCHAR(100)				NOT NULL
	,strMaterialPartNumber			VARCHAR(50)					NOT NULL
	,monMaterialWholeSalePrice		MONEY						NOT NULL
	,monMaterialRetailPrice			MONEY						NOT NULL
	,CONSTRAINT TMaterials_PK PRIMARY KEY (intMaterialID) 
)


CREATE TABLE TVendors
(
	 intVendorID					INTEGER						NOT NULL
	,strVendorFirstName				VARCHAR(50)					NOT NULL
	,strVendorLastName				VARCHAR(50)					NOT NULL
	,strVendorAddress				VARCHAR(50)					NOT NULL
	,strCity						VARCHAR(50)					NOT NULL
	,intStateID						INTEGER						NOT NULL
	,strZip							VARCHAR(50)					NOT NULL
	,strVendorPhone					VARCHAR(50)					NOT NULL
	,CONSTRAINT TVendors_PK PRIMARY KEY (intVendorID)
)

CREATE TABLE TVendorMaterials
(
	 intVendorID					INTEGER						NOT NULL
	,intMaterialID					INTEGER						NOT NULL
	,intMaterialInventoryQuantity	INTEGER						NOT NULL
	,CONSTRAINT TVendorMaterials_PK PRIMARY KEY (intVendorID, intMaterialID)
)

CREATE TABLE TStates
(
	 intStateID						INTEGER						NOT NULL
	,strStateDesc					VARCHAR(50)					NOT NULL
	,CONSTRAINT TStates_PK PRIMARY KEY (intStateID)
)


-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child										Parent							Column(s)
-- -	-----										------							---------
-- 1	TCustomers									TStates							intStateID   --
-- 2	TWorkers									TStates							intStateID --
-- 3	TVendors									TStates							intStateID --

-- 4	TCustomerJobs								TCustomers						intCustomerID --
-- 5	TCustomerJobWorkers							TCustomers						intCustomerID --
-- 6	TCustomerJobMaterials						TCustomers						intCustomerID --

-- 7	TCustomerJobs								TStatuses						intStatusID --

-- 8	TCustomerJobWorkers							TWorkers						intWorkerID --
-- 9	TWorkerSkills								TWorkers						intWorkerID --

-- 10	TWorkerSkills								TSkills							intSkillID --
	
-- 11	TCustomerJobMaterials						TMaterials						intMaterialID --
-- 12	TVendorMaterials							TMaterials						intMaterialID --

-- 13	TVendorMaterials							TVendors						intVendorID --


--1
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates( intStateID )

--2
ALTER TABLE TWorkers ADD CONSTRAINT TWorkers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates( intStateID )

--3
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates( intStateID )

--4
ALTER TABLE TCustomerJobs ADD CONSTRAINT TCustomerJobs_TCustomers_FK
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers( intCustomerID )

--5
ALTER TABLE TCustomerJobWorkers ADD CONSTRAINT TCustomerJobWorkers_TCustomers_FK
FOREIGN KEY	( intCustomerID ) REFERENCES TCustomers( intCustomerID )

--6
ALTER TABLE TCustomerJobMaterials ADD CONSTRAINT TCustomerJobMaterials_TCustomers_FK
FOREIGN KEY	( intCustomerID ) REFERENCES TCustomers( intCustomerID )


--7
ALTER TABLE TCustomerJobs ADD CONSTRAINT TCustomerJobs_TStatuses_FK
FOREIGN KEY ( intStatusID ) REFERENCES TStatuses( intStatusID )

--8
ALTER TABLE TCustomerJobWorkers ADD CONSTRAINT TCustomerJobWorkers_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers( intWorkerID )

--9
ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers( intWorkerID )

--10
ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TSkills_FK
FOREIGN KEY ( intSkillID ) REFERENCES TSkills( intSkillID )

--11
ALTER TABLE TCustomerJobMaterials ADD CONSTRAINT TCustomerJobMaterials_TMaterials_FK
FOREIGN KEY ( intMaterialID ) REFERENCES TMaterials( intMaterialID )

--12
ALTER TABLE TVendorMaterials ADD CONSTRAINT TVendorMaterials_TMaterials_FK
FOREIGN KEY ( intMaterialID ) REFERENCES TMaterials( intMaterialID )

--13
ALTER TABLE TVendorMaterials ADD CONSTRAINT TVendorMaterials_TVendors_FK
FOREIGN KEY ( intVendorID ) REFERENCES TVendors( intVendorID )


-- --------------------------------------------------------------------------------
--Add Records into States
-- --------------------------------------------------------------------------------
INSERT INTO TStates (intStateID, strStateDesc)
VALUES   (1, 'Ohio')
		,(2, 'Kentucky')
		,(3, 'West Virginia')
		,(4, 'Florida')
		,(5, 'Texas')

-- --------------------------------------------------------------------------------
--Add Records into Statuses
-- --------------------------------------------------------------------------------
INSERT INTO TStatuses (intStatusID, strStatusDesc)
VALUES  (1, 'Open')
	   ,(2, 'In Process')
	   ,(3, 'Complete')

-- --------------------------------------------------------------------------------
--Add Records into Materials
-- --------------------------------------------------------------------------------
INSERT INTO TMaterials (intMaterialID, strMaterialDesc, strMaterialPartNumber, monMaterialWholeSalePrice, monMaterialRetailPrice)
VALUES   (1, 'Steel pipe lubricant', '1100-1564', 15.00, 10.00)
		,(2, 'Headlight Fluid', '101-6471', 2.00, 0.50)
		,(3, 'Batarang', '1124-6451', 50.00, 45.00)
		,(4, 'One-Hit Nails', '1337-1337', 100.00, 99.99)
		,(5, 'AAAAAA Batteries', '4444-4444', 20.00, 8.00)
		,(6, 'Piano keys', '4675-7892', 25.00, 14.00)
		,(7, 'Phillips Head Screwdriver', '5653-6121', 4.00, 3.00)
-- --------------------------------------------------------------------------------
--Add Records into Vendors
-- --------------------------------------------------------------------------------
INSERT INTO TVendors (intVendorID, strVendorFirstName, strVendorLastName, strVendorAddress, strCity, intStateID, strZip, strVendorPhone)
VALUES   (1, 'Home', 'Depot', '9876 Handyman Cir', 'Cincinnati', 1, 45221, '513465728')
		,(2, 'Gav', 'Free', '5587 BritMan Drive', 'Houston', 5, 46213, '3154068123')
		,(3, 'Bruce', 'Wayne', '1111 Batcave Lane', 'Tallahassee', 4, 65822, '1524281679')
		,(4, 'Tru', 'Alphonse', '4417 Nailed It Ave', 'Florence', 2, 12326, '6452493612')
		,(5, 'Watt', 'Volt', '6781 Energy Street', 'Charleston', 3, 46312, '1679254621')

-- --------------------------------------------------------------------------------
--Add Records into Skills
-- --------------------------------------------------------------------------------
INSERT INTO TSkills (intSkillID, strSkillDesc)
VALUES   (1, 'Plumber')
		,(2, 'Carpenter')
		,(3, 'Electrician')
		,(4, 'Level-3 Mage')
		,(5, 'Intern')

-- --------------------------------------------------------------------------------
--Add Records into Workers
-- --------------------------------------------------------------------------------
INSERT INTO TWorkers (intWorkerID, strWorkerFirstName, strWorkerLastName, strWorkerAddress, strCity, intStateID, strWorkerPhone, dtmHireDate, monHourlyRate)
VALUES   (1, 'Jeffaffa', 'Dunham', '2246 Back Alley Way', 'Cincinnati', 1, '0123456789', '2014-01-13', 10.00)
		,(2, 'Harper', 'Ferry', '1141 Appalacian Trail', 'Charleston', 3, '9876543210', '2018-04-12', 10.01)
		,(3, 'Chuck', 'Wood', 'Splinter Street', 'Tallahassee', 4, '4785198240', '2000-12-15', 10.02)
		,(4, 'Darth', 'Vader', '5482 Death Star Place', 'Houston', 5, '1122445523', '1997-11-07', 10.03)
		,(5, 'Needa', 'Job', '4016 Palm Ave', 'Columbus', 1, '5546112345', '2005-10-04', 0.01)
		,(6, 'Craig', 'Lisst', '1621 Ebay Bay', 'Dallas', 5, '4561256781', '2011-12-05', 15.00)
-- --------------------------------------------------------------------------------
--Add Records into Customers
-- --------------------------------------------------------------------------------
INSERT INTO TCustomers (intCustomerID, strCustomerFirstName, strCustomerLastName, strAddress, strCity, intStateID, strCustomerPhone, strEmail)
VALUES   (1, 'Bill', 'Nye', '123 Sessame Street', 'Charleston', 3, '444444446', 'bILL.nYEdaScienceguy@AOL.com')
		,(2, 'Fun', 'Guy', '4555 Main Street', 'Cincinnati', 1, '4204204201', 'fun.guy@bing.com')
		,(3, 'Samurai', 'Jack', '6457 SliceDice Ave', 'Florence', 2, '0113401134', 'Aku.Sucks@gmail.com')
		,(4, 'Bill', 'Mill', '1234 Twin Lane', 'Kissimmee', 4, '0022446688', 'MillsAlternatePersonality@yahoo.com')
		,(5, 'Mill', 'Bill', '4321 Twin Lane', 'Kissimmee', 4, '8866442200', 'BillsAlternatePersonality@yahoo.com')
		,(6, 'Scout', 'Wagner', '4582 Main Street', 'Columbus', 1, '6116265612', 'scout.wagner@gmail.com')
		,(7, 'Joseph', 'Jostar', '4562 Main Street', 'Cleveland', 1, '1201524756', 'jo.jo@gmail.com')

-- --------------------------------------------------------------------------------
--Add Records into Customer Jobs
-- --------------------------------------------------------------------------------
INSERT INTO TCustomerJobs (intCustomerID, intJobID, strJobDescription, intStatusID, dtmStartDate, dtmEndDate,monJobCost)
VALUES  (1,1, 'Fix rusty pipes', 1, '2017-01-01', '2018-1-1', 100.00)
	   ,(1,2, 'Blow Something Up', 3, '2002-01-05', '2010-1-05', 10.00)
	   ,(1,3, 'Create a time machine', 2, '2000-02-26', '2022-2-26', 1000000.00)
	   ,(2,4, 'Sink a nail in one hit', 1, '2000-12-31', '2008-12-31', 1000.00)
	   ,(2,5, 'Build a house', 2, '2005-11-1', '2019-10-31', 19999.00)
	   ,(2,6, 'Cut down dead tree in yard', 2, '2000-11-7', '2001-11-7', 500.00)
	   ,(3,7, 'Do nothing for 20 years', 2, '1998-2-14', '2018-2-14', 20000.00)
	   ,(3,8, 'Help install power to house', 3, '2015-11-15', '2018-11-15', 200.00)
	   ,(3,9, 'Install Cable TV', 1, '2017-5-16', '2018-5-16', 25.00)
	   ,(4, 10, 'Charge my phone', 1, '2012-9-18', '2013-9-18', 5.00)
	   ,(4, 11, 'Install Solar Panels', 2, '2012-12-12', '2018-12-12', 2000.00)
	   ,(4, 12, 'Install Server on Computer', 3, '2012-12-12', '2015-12-12', 800.00)
	   ,(5, 13, 'Fix computer', 3, '2017-10-14', '2019-10-14', 75.00)
	   ,(5, 14, 'Help file reports', 3, '2017-3-4', '2029-3-4', 12.00)
	   ,(5, 15, 'Install new wall panels', 3, '2011-6-17', '2018-6-17', 18.00)

-- --------------------------------------------------------------------------------
--Add Records into Job workers
-- --------------------------------------------------------------------------------
INSERT INTO TCustomerJobWorkers (intCustomerID, intJobID, intJobIndex, intWorkerID,intJobNumber, intEmployeeIDNumber, dtmStartDate, dtmEndDate, decWorkHours)
VALUES   (1, 1, 1,  1, 1126, 1456, '2017-01-01', '2018-1-1', 8.5)
		,(1, 2, 1, 1, 1127, 3314, '2002-01-05', '2010-1-05', 200.0)
		,(1, 3, 1, 1, 1135, 4457, '2000-02-26', '2022-2-26', 45.0)
		,(2, 4, 1, 4, 1254, 5546, '2000-12-31', '2008-12-31', 12.0)
		,(2, 5, 1, 5, 2156, 9999, '2005-11-1', '2019-10-31', 3.0)
		,(2, 6, 2, 1, 1126, 1456, '2000-11-7', '2001-11-7', 8.5)
		,(3, 7, 2, 2, 1127, 3314, '1998-2-14', '2018-2-14', 200.0)
		,(3, 8, 2, 3, 1135, 4457, '2015-11-15', '2018-11-15', 45.0)
		,(3, 9, 2, 4, 1254, 5546, '2017-5-16', '2018-5-16', 12.0)
		,(4, 10, 2, 3, 2156, 9999, '2012-9-18', '2013-9-18', 3.0)
		,(4, 11, 3, 3, 1126, 1456, '2012-12-12', '2018-12-12', 8.5)
		,(4, 12, 3, 3, 1127, 3314, '2012-12-12', '2015-12-12', 200.0)
		,(5, 13, 3, 3, 1135, 4457, '2017-10-14', '2019-10-14', 45.0)
		,(5, 14, 3, 4, 1254, 5546, '2017-3-4', '2029-3-4', 12.0)
		,(5 ,15, 3, 5, 2156, 9999, '2011-6-17', '2018-6-17', 3.0)
-- --------------------------------------------------------------------------------
--Add Records into Worker skills
-- --------------------------------------------------------------------------------
INSERT INTO TWorkerSkills (intWorkerID, intSkillID, intSkillIndex)
VALUES   (1, 1, 1)
		,(1, 5, 2)
		,(1, 3, 3)
		,(2, 3, 1)
		,(3, 2, 1)
		,(4, 4, 1)
		,(5, 5, 1)
		
		
-- --------------------------------------------------------------------------------
--Add Records into Job materials
-- --------------------------------------------------------------------------------
INSERT INTO TCustomerJobMaterials (intCustomerID,intJobID, intMaterialID, intMaterialJobQuantity)
VALUES   (1, 1, 1, 15)
		,(1, 2, 2, 45)
		,(1, 3, 3, 92)
		,(2, 4, 4, 46)
		,(2, 5, 5, 22)
		,(2, 6, 1, 15)
		,(3, 7, 2, 45)
		,(3, 8, 3, 92)
		,(3, 9, 4, 46)
		,(4, 10, 5, 22)
		,(4, 11, 1, 15)
		,(4, 12, 2, 45)
		,(4, 12, 4, 10)
		,(4, 12, 1, 4)
		,(5, 13, 3, 92)
		,(5, 14, 4, 46)
		,(5, 15, 5, 22)

-- --------------------------------------------------------------------------------
--Add Records into Vendor Materials
-- --------------------------------------------------------------------------------
INSERT INTO TVendorMaterials (intVendorID, intMaterialID, intMaterialInventoryQuantity)
VALUES   (1,1,20)
		,(2,2,100)
		,(3,5,2)
		,(4,4,16)
		,(5,3,88)
		,(5, 6, 10)

-- --------------------------------------------------------------------------------
--3.	Update and Deletes (2 points) 
-- --------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
--3.1. Create SQL to update the address for a specific customer. Include a select statement before and after the update. 
-- ---------------------------------------------------------------------------------------------------------------------

SELECT *
FROM TCustomers

UPDATE TCustomers
SET strAddress = '1589 Science Avenue'
WHERE strAddress = '123 Sessame Street'

SELECT *
FROM TCustomers
-- ---------------------------------------------------------------------------------------------------------------
--3.2. Create SQL to increase the hourly rate by $2 for each worker that has been an employee for at least 1 year.
-- Include a select before and after the update.
--Make sure that you have data so that some rows are updated and others are not. 
-- ---------------------------------------------------------------------------------------------------------------

SELECT *
FROM TWorkers

UPDATE TWorkers
SET monHourlyRate += 2
WHERE dtmHireDate< '2017'

SELECT *
FROM TWorkers

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
--3.3. Create SQL to delete a specific job that has associated work hours and materials assigned to it. Include a select before and after the statement(s). 
-- --------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM TCustomerJobWorkers

DELETE FROM TCustomerJobWorkers
WHERE intJobID = 5

SELECT *
FROM TCustomerJobWorkers


-- --------------------------------------------------------------------------------
--4.	Queries (3 points each) 
-- --------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------------------------------------------------------
--4.1	Write a query to list all jobs that are in process. Include the Job ID and Description, Customer ID and name, and the start date. 
--Order by the Job ID. 
-- -------------------------------------------------------------------------------------------------------------------------------------

SELECT TCJ.intJobID, TCJ.strJobDescription, TC.intCustomerID, TC.strCustomerFirstName, TC.strCustomerLastName, CONVERT(VARCHAR(12), (TCJ.dtmStartDate),1) AS StartDate
FROM TCustomerJobs AS TCJ
	,TCustomers AS TC
WHERE 
	TCJ.intCustomerID = TC.intCustomerID
and	TCJ.intStatusID = 2
ORDER BY TCJ.intJobID

-- --------------------------------------------------------------------------------------------------------------------------------------
--4.2	 Write a query to list all complete jobs for a specific customer and the materials used on each job.
-- Include the quantity, unit cost, and total cost for each material on each job.
--Order by Job ID and material ID. Note: Select a customer that has at least 3 complete jobs and at least 1 open job and 1 in process job.
-- At least one of the complete jobs should have multiple materials.
--If needed, go back to your inserts and add data. 
-- ---------------------------------------------------------------------------------------------------------------------------------------

SELECT TCJM.intJobID, TCJM.intMaterialJobQuantity, TM.intMaterialID, TM.monMaterialRetailPrice, TM.monMaterialWholeSalePrice
FROM TCustomerJobMaterials AS TCJM
	,TMaterials AS TM
	,TCustomerJobs AS TCJ
WHERE
	TM.intMaterialID = TCJM.intMaterialID
	and TCJM.intJobID = TCJ.intJobID
	and TCJM.intCustomerID = TCJ.intCustomerID
	and TCJ.intCustomerID = 4
	and	TCJ.intStatusID = 3
ORDER BY TCJM.intJobID, TCJM.intMaterialID

-- ---------------------------------------------------------------------------------------------------------------------------------------
--4.3	 This step should use the same customer as in step 4.2. 
--Write a query to list the total cost for all materials for each completed job for the customer. 
--Use the data returned in step 4.2 to validate your results. 
--cost of job = retail price of materials + (hourly rate X hours worked)
-- ---------------------------------------------------------------------------------------------------------------------------------------

SELECT TCJM.intJobID, TCJM.intMaterialID, SUM(TM.monMaterialRetailPrice) AS TotalMaterialCost

FROM TCustomerJobMaterials AS TCJM
	,TMaterials AS TM
	,TCustomerJobs AS TCJ
WHERE
	TM.intMaterialID = TCJM.intMaterialID
	and TCJM.intJobID = TCJ.intJobID
	and TCJM.intCustomerID = TCJ.intCustomerID
	and TCJ.intCustomerID = 4
	and	TCJ.intStatusID = 3
GROUP BY TCJM.intJobID, TCJM.intMaterialID

-- --------------------------------------------------------------------------------------------------------------------------------------
--4.4	 Write a query to list all jobs that have work entered for them. Include the job ID, job description, and job status description.
-- List the total hours worked for each job with the lowest, highest, and average hourly rate.
--The average hourly rate should be weighted based on the number of hours worked at that rate. 
--Make sure that your data includes at least one job that does not have hours logged. This job should not be included in the query.
--Order by highest to lowest average hourly rate. 
-- --------------------------------------------------------------------------------------------------------------------------------------

SELECT TCJ.intJobID, TCJ.strJobDescription, TS.strStatusDesc, TCJW.decWorkHours, TW.monHourlyRate

FROM TCustomerJobs AS TCJ
	,TStatuses AS TS
	,TCustomerJobWorkers AS TCJW
	,TWorkers AS TW
WHERE
	TCJ.intStatusID = TS.intStatusID
and	TCJ.intJobID = TCJW.intJobID
and TCJW.intWorkerID = TW.intWorkerID
ORDER BY TW.monHourlyRate desc

-- --------------------------------------------------------------------------------------------------------------------------------------------
--4.5	 Write a query that lists all materials that have not been used on any jobs. Include Material ID and Description. Order by Material ID. 
-- --------------------------------------------------------------------------------------------------------------------------------------------

SELECT TM.intMaterialID, TM.strMaterialDesc
FROM TMaterials AS TM
WHERE
	TM.intMaterialID not in
					(SELECT TCJM.intMaterialID
					FROM TCustomerJobMaterials AS TCJM
					WHERE intJobID between 1 and 15)
		
						
ORDER BY TM.intMaterialID

-- --------------------------------------------------------------------------------------------------------------------------------------------
--4.6	 Create a query that lists all workers with a specific skill, their hire date, and the total number of jobs that they worked on. 
--List the Skill ID and description with each row. Order by Worker ID. 
-- --------------------------------------------------------------------------------------------------------------------------------------------

SELECT TCJW.intWorkerID, TS.intSkillID, TS.strSkillDesc, CONVERT(VARCHAR(12),(TW.dtmHireDate), 1) AS HireDate, COUNT(TCJW.intJobIndex) AS TotalWorkerJobs
FROM TWorkers AS TW
	,TWorkerSkills AS TWS
	,TSkills AS TS
	,TCustomerJobWorkers AS TCJW
WHERE
	TW.intWorkerID = TCJW.intWorkerID
and TS.intSkillID = TWS.intSkillID
and TW.intWorkerID = TWS.intWorkerID
GROUP BY TCJW.intWorkerID, TS.intSkillID, TS.strSkillDesc, TW.dtmHireDate
ORDER BY TCJW.intWorkerID

-- -------------------------------------------------------------------------------------------------------------------
--4.7	 Create a query that lists all workers that worked greater than 20 hours for all jobs that they worked on. 
--Include the Worker ID and name, number of hours worked, and number of jobs that they worked on. Order by Worker ID. 
-- -------------------------------------------------------------------------------------------------------------------

SELECT TCJW.intWorkerID, TW.strWorkerFirstName, TW.strWorkerLastName, SUM(TCJW.decWorkHours) AS TotalWorkHours, COUNT(TCJW.intJobIndex) AS TotalWorkerJobs
FROM TWorkers AS TW
	,TCustomerJobWorkers AS TCJW
WHERE
	TW.intWorkerID = TCJW.intWorkerID
and TCJW.decWorkHours > 20
GROUP BY TCJW.intWorkerID, TW.strWorkerFirstName, TW.strWorkerLastName
ORDER BY TCJW.intWorkerID

-- ---------------------------------------------------------------------------------------------------------
--4.8	 Create a view that includes the labor costs associated with each job. Include Customer ID and Name. 
-- ---------------------------------------------------------------------------------------------------------

GO 
CREATE VIEW
VLaborCosts
AS
SELECT TC.intCustomerID, TCJ.monJobCost
FROM TCustomers AS TC
	,TCustomerJobs AS TCJ
WHERE
	TC.intCustomerID = TCJ.intCustomerID
GO

-- -------------------------------------------------------------------------------------------------------------------------
--4.9	 Use the View from 4.8 to create a query that includes the total labor cost for each customer. Order by Customer ID. 
-- -------------------------------------------------------------------------------------------------------------------------

GO 
CREATE VIEW
VTotalLaborCosts
AS
SELECT TC.intCustomerID, SUM(TCJ.monJobCost) AS TotalLaborCosts
FROM TCustomers AS TC
	,TCustomerJobs AS TCJ
WHERE
	TC.intCustomerID = TCJ.intCustomerID
GROUP BY 
	TC.intCustomerID
GO

-- --------------------------------------------------------------------------------------------------------------------------------------------
--4.10 Write a query that lists all customers who are located on 'Main Street'. Include the customer Id and full address. Order by Customer ID.
--Make sure that you have at least three customers on 'Main Street' each with different house numbers.-
-- Make sure that you also have customers that are not on 'Main Street'. 
-- --------------------------------------------------------------------------------------------------------------------------------------------

SELECT TC.intCustomerID, TC.strCustomerFirstName, TC.strCustomerLastName, TC.strAddress
FROM TCustomers AS TC
WHERE
	TC.strAddress LIKE '%Main Street%'

-- ---------------------------------------------------------------------------------------------------------------------------------
--4.11 Write a query to list completed jobs that started and ended in the same month. List Job, Job Status, Start Date and End Date.
-- --------------------------------------------------------------------------------------------------------------------------------- 

SELECT TCJ.intJobID, TCJ.intStatusID, CONVERT(VARCHAR(12),(TCJ.dtmStartDate),1) AS StartDate, CONVERT(VARCHAR(12),(TCJ.dtmEndDate),1) AS EndDate
FROM TCustomerJobs AS TCJ
WHERE
	MONTH(TCJ.dtmStartDate) = MONTH(TCJ.dtmEndDate)
and TCJ.intStatusID = 3

-- -------------------------------------------------------------------------------------------
--4.12 Create a query to list workers that worked on three or more jobs for the same customer. 
-- -------------------------------------------------------------------------------------------

SELECT TCJW.intCustomerID ,TCJW.intWorkerID 
FROM TCustomerJobWorkers AS TCJW
GROUP BY TCJW.intCustomerID, TCJW.intWorkerID
HAVING	COUNT(TCJW.intJobIndex) >= 3

-- -------------------------------------------------------------------------------------------------------------
--4.13 Create a query to list all workers and their total # of skills.
-- Make sure that you have workers that have multiple skills and that you have at least 1 worker with no skills.
--The worker with no skills should be included with a total number of skills = 0. Order by Worker ID. 
-- -------------------------------------------------------------------------------------------------------------

SELECT TW.intWorkerID, COUNT(TWS.intSkillIndex) AS TotalSkills
FROM TWorkerSkills AS TWS
FULL OUTER JOIN TWorkers AS TW on TWS.intWorkerID = TW.intWorkerID
GROUP BY TW.intWorkerID
ORDER BY TW.intWorkerID

-- ----------------------------------------------------------------------------------------------------------
--4.14 Write a query to list the total Charge to the customer for each job. 
--Calculate the total charge to the customer as the total cost of materials + total Labor costs + 30% Profit. 
-- ----------------------------------------------------------------------------------------------------------

SELECT TC.intCustomerID, TCJ.intJobID, SUM((TM.monMaterialRetailPrice) + (TCJ.monJobCost) * 1.3) AS TotalJobCost
FROM TCustomers AS TC
	,TCustomerJobs AS TCJ
	,TCustomerJobMaterials AS TCJM
	,TMaterials AS TM
WHERE
	TC.intCustomerID = TCJ.intCustomerID
GROUP BY 
	TC.intCustomerID, TCJ.intJobID
	
-- --------------------------------------------------------------------------------
--4.15 Write a query that totals what is owed to each vendor for a particular job. 
-- --------------------------------------------------------------------------------

SELECT TCJM.intJobID, TV.intVendorID, TVM.intMaterialID, SUM(TM.monMaterialWholeSalePrice * TCJM.intMaterialJobQuantity) AS VendorBill
FROM TVendors AS TV
	,TVendorMaterials AS TVM
	,TCustomerJobMaterials AS TCJM
	,TMaterials AS TM
WHERE
	TV.intVendorID= TVM.intVendorID
and TVM.intMaterialID = TCJM.intMaterialID

GROUP BY 
	TCJM.intJobID, TV.intVendorID, TVM.intMaterialID
ORDER BY TCJM.intJobID



-- --------------------------------------------------------------------------------
-- SELECT Statements to see all tables
-- --------------------------------------------------------------------------------

/*
SELECT *
FROM TCustomers

SELECT *
FROM TCustomerJobs

SELECT *
FROM TCustomerJobWorkers

SELECT *
FROM TWorkers

SELECT *
FROM TWorkerSkills

SELECT *
FROM TSkills

SELECT *
FROM TStatuses

SELECT *
FROM TCustomerJobMaterials

SELECT *
FROM TMaterials

SELECT *
FROM TVendors

SELECT *
FROM TVendorMaterials

SELECT *
FROM TStates

*/



/*
•	Each Job is for a specific customer and there can be more than one job per customer. 
•	The name and address must be tracked for each customer. 
•	Each job is described by up to 2000 characters. 
•	Each job has a status of ‘open, ‘in process’, or ‘complete’. 
•	Each job has a start date and end date. 
•	Multiple materials can be used on each job. 
•	Multiple quantities of the same material can be used on each job. 
•	Materials can be used on multiple jobs. 
•	Each material is purchased by the company via a Vendor at a fixed cost per unit. 
•	Each Vendor of the materials must be tracked with the vendor name and address 
•	The number of hours worked by each worker on each job must be tracked. 
•	The name, hire date, and hourly rate, and skills must be tracked for each worker. 
•	Workers can have more than one skill. 
•	Multiple workers per job
•	Workers can have more than one skill 

•	Customer Address, phone number, name, etc

•	Each material is unique to the vendor selling it
•	MaterialInventory
•	Part Number for material

•	Keep track of worker's time on the job

•	Job number
•	Employee Identification number

•	Materials need a whole sale price(price bought from vendor) and a retaile price(selling to others)

•	Hourly rate = what the customer is billed with

•	Cost of job = retale price + (hourly rate * )
*/


















/*Instructions: 
You are to create a database, primary keys, foreign keys, indexes, inserts, updates, views, and other SQL Select statements based on 
the following requirements. 
Important Dates:


Preliminary Database Review Due Date: Up to Sunday April 23rd at 11:59 PM 


I will accept Preliminary Database designs (max 2) for review and feedback.  The final submission of this Preliminary Database Review will be Sunday at 11:59 PM.  Anything submitted afterwards, will be graded as you final design. 
Submit a .SQL document detailing your design using Create Statements.  For the Preliminary Review, foreign key constraints should not be defined. 
Submit the document under Preliminary Database Design Upload in the Final Project folder.
Final Database Design: Tuesday April 25th at 11:59 PM
Final Database design. This includes primary keys, foreign keys, and other constraints.
Submit a .SQL document detailing your design using Create Statements, Alter Statements, etc. 
Submit the document under Final Database Design Upload in the Final Project folder.
At midnight, I will provide a solution for this database.  You may use your version or my version for the final part of the exam. 

Final Due Date: 11:59 PM, Sunday, April 30th. No late assignments will be accepted. 
The complete project consisting of the entire database creation, foreign keys, and all SQL statements to create, update, and select. 
Submit a .SQL document detailing your design using Create Statements, Alter Statements, Inserts, Update, and Select statements.  
Submit the document under Final Database Project Upload in the Final Project folder.


Grading: 
For the final project, significant points will be deducted if the script runs with errors! 
Points will be awarded as follows: 

9	Database design review - All 9 points are awarded for submitting a preliminary design.
10	Coding Standards. Script is well documented, readable, and follows naming conventions.      
20 	Database design. This includes primary keys, foreign keys, indexes, and other constraints
10 	Data Quality. All tables have data. There is enough variation to thoroughly test the SQL     
51	Remaining SQL steps.

Use books, old homework assignments, and videos for reference materials but you are expected to do the work on your own. This is not a group assignment. I would suggest using the e-text book we used all semester. If you have questions about the instructions, bring them to class on Thursday December 8th.  After this class, I will post the answers in an announcement to all students for any additional questions that I receive by email that I deem necessary to share with all. 
Project Description: 
Design a database for a simple job tracking system and complete the specified SQL statements to update, delete, and query the database.  A job is basically a service provided.  For example, a service of a plumber, an electrician, or a heating and cooling technician.  

The final solution should be submitted as a single Script file created in SQL Server. Be sure to test your script file before submitting it. 
Project Steps:


1. Database Design 
1.1. Design and create a database in third normal form based on the following requirements: 
•	Each Job is for a specific customer and there can be more than one job per customer. 
•	The name and address must be tracked for each customer. 
•	Each job is described by up to 2000 characters. 
•	Each job has a status of ‘open, ‘in process’, or ‘complete’. 
•	Each job has a start date and end date. 
•	Multiple materials can be used on each job. 
•	Multiple quantities of the same material can be used on each job. 
•	Materials can be used on multiple jobs. 
•	Each material is purchased by the company via a Vendor at a fixed cost per unit. 
•	Each Vendor of the materials must be tracked with the vendor name and address 
•	The number of hours worked by each worker on each job must be tracked. 
•	The name, hire date, and hourly rate, and skills must be tracked for each worker. 
•	Workers can have more than one skill. 

1.2. Create foreign key constraints to enforce referential integrity for all relationships. 



2. Add Data 
2.1. Populate each table with test data. Make sure that you have sufficient data to test all indicated Updates, Deletes, and Queries. 


3.	Update and Deletes (2 points) 
3.1. Create SQL to update the address for a specific customer. Include a select statement before and after the update. 
3.2. Create SQL to increase the hourly rate by $2 for each worker that has been an employee for at least 1 year. Include a select before and after the update. Make sure that you have data so that some rows are updated and others are not. 
3.3. Create SQL to delete a specific job that has associated work hours and materials assigned to it. Include a select before and after the statement(s). 


4.	Queries (3 points each) 
4.1	Write a query to list all jobs that are in process. Include the Job ID and Description, Customer ID and name, and the start date. Order by the Job ID. 
4.2	 Write a query to list all complete jobs for a specific customer and the materials used on each job. Include the quantity, unit cost, and total cost for each material on each job. Order by Job ID and material ID. Note: Select a customer that has at least 3 complete jobs and at least 1 open job and 1 in process job. At least one of the complete jobs should have multiple materials. If needed, go back to your inserts and add data. 
4.3	 This step should use the same customer as in step 4.2. Write a query to list the total cost for all materials for each completed job for the customer. Use the data returned in step 4.2 to validate your results. 
4.4	 Write a query to list all jobs that have work entered for them. Include the job ID, job description, and job status description. List the total hours worked for each job with the lowest, highest, and average hourly rate. The average hourly rate should be weighted based on the number of hours worked at that rate. Make sure that your data includes at least one job that does not have hours logged. This job should not be included in the query. Order by highest to lowest average hourly rate. 
4.5	 Write a query that lists all materials that have not been used on any jobs. Include Material ID and Description. Order by Material ID. 
4.6	 Create a query that lists all workers with a specific skill, their hire date, and the total number of jobs that they worked on. List the Skill ID and description with each row. Order by Worker ID. 
4.7	 Create a query that lists all workers that worked greater than 20 hours for all jobs that they worked on. Include the Worker ID and name, number of hours worked, and number of jobs that they worked on. Order by Worker ID. 
4.8	 Create a view that includes the labor costs associated with each job. Include Customer ID and Name. 
4.9	 Use the View from 4.8 to create a query that includes the total labor cost for each customer. Order by Customer ID. 
4.10 Write a query that lists all customers who are located on 'Main Street'. Include the customer Id and full address. Order by Customer ID. Make sure that you have at least three customers on 'Main Street' each with different house numbers. Make sure that you also have customers that are not on 'Main Street'. 
4.11 Write a query to list completed jobs that started and ended in the same month. List Job, Job Status, Start Date and End Date. 
4.12 Create a query to list workers that worked on three or more jobs for the same customer. 
4.13 Create a query to list all workers and their total # of skills. Make sure that you have workers that have multiple skills and that you have at least 1 worker with no skills. The worker with no skills should be included with a total number of skills = 0. Order by Worker ID. 
4.14 Write a query to list the total Charge to the customer for each job. Calculate the total charge to the customer as the total cost of materials + total Labor costs + 30% Profit. 
4.15 Write a query that totals what is owed to each vendor for a particular job. 


Tips: 
•	Get started early. The due dates cannot be extended. 
•	Submit the database review. If your database design has problems, you will have problems with the rest of the project. . 
•	Test your script as you go. It is much easier than trying to test everything at the end. For example, write a CREATE command and test it. Then, write the next CREATE and test it, etc...   Also…it might be wise to create a new database for this. 
•	Clearly identify foreign key relationships. Think carefully about which table is the parent and which is the child and whether it is a 1 to 1, 1 to many, or many to many relationship. This will help you create foreign keys and determine the order for some of the SQL statements. Sometimes drawing a picture of the tables can help with this. (Pat describes this in one of the videos) 
•	Add some data initially and then add additional data as you complete steps 4.1 through 4.15. As you complete each step think about what data you need in the tables to thoroughly test the SQL. 
•	If you execute your SQL and are not getting the results that you want, try testing the SQL in parts. For example, if you have a sub-query, test just that portion of the SQL to make sure it is returning the correct results. If you are joining 4 tables, start by joining 2. Once that works properly, add a third table, etc... 




*/