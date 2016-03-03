/* Sample Code for Creating SQL Data Warehouse for Alexandria Community Indicators */

/* CREATE GEOGRAPHY TABLES */
/* Not all geographies necessary right now for Alexandria -- future-proofing */

/*REGION*/
CREATE TABLE region (
    regionID INT IDENTITY(1,1) NOT NULL,
    regionFips NVARCHAR(1) NOT NULL,
    regionName NVARCHAR(9) NOT NULL,
    PRIMARY KEY (regionID)
) ON [PRIMARY];

/*DIVISION*/
CREATE TABLE divis (
	divisID INT IDENTITY(1,1) NOT NULL,
    divisFips NVARCHAR(1) NOT NULL,
    divisName NVARCHAR(18) NOT NULL,
    regionFips NVARCHAR(1) NOT NULL,
    regionID INT NOT NULL REFERENCES region(regionID),
    PRIMARY KEY (divisID)
) ON [PRIMARY];

/*STATE*/
CREATE TABLE state (
	stateID INT IDENTITY(1,1) NOT NULL,
    stateFips NVARCHAR(2) NOT NULL,
    stateName NVARCHAR(20) NOT NULL,
    stateAbbrev NVARCHAR(2) NOT NULL,
    PRIMARY KEY (stateID)
) ON [PRIMARY];

/*METRO*/
CREATE TABLE metro (
	metroID INT IDENTITY(1,1) NOT NULL,
    metroFips NVARCHAR(5) NOT NULL,
    metroName NVARCHAR(125) NOT NULL,
    PRIMARY KEY (metroID)
) ON [PRIMARY];

/*METRO DIVISION*/
CREATE TABLE metdiv (
	metdivID INT IDENTITY(1,1) NOT NULL,
    metdivFips NVARCHAR(5) NOT NULL,
    metdivName NVARCHAR(125) NOT NULL,
    metroFips NVARCHAR(5) NOT NULL,
    metroID INT NOT NULL REFERENCES metro(metroID),
    PRIMARY KEY (metdivID)
) ON [PRIMARY];

/*COUNTY*/
CREATE TABLE county (
	countyID INT IDENTITY(1,1) NOT NULL,
    countyFips NVARCHAR(5) NOT NULL,
    countyName NVARCHAR(50) NOT NULL,
    PRIMARY KEY (countyID)
) ON [PRIMARY];

/*TRACT*/
CREATE TABLE tract (
	tractID INT IDENTITY(1,1) NOT NULL,
    tractFips NVARCHAR(11) NOT NULL,
    countyID REFERENCES county(countyID),
    PRIMARY KEY (tractID)
) ON [PRIMARY];

/*BLOCK GROUP*/
CREATE TABLE blkgrp (
	blkgrpID INT IDENTITY(1,1) NOT NULL,
    blkgrpFips NVARCHAR(12) NOT NULL,
    tractFips NVARCHAR(11) NOT NULL,
    tractID REFERENCES tract(tractID),
    PRIMARY KEY (blkgrpID)
) ON [PRIMARY];

/*GEOGRAPHY LEVEL*/
CREATE TABLE geoLevel (
    geolevel INT IDENTITY(1,1) NOT NULL,
    geolevelName NVARCHAR(30) NOT NULL,
    PRIMARY KEY (geolevel)
) ON [PRIMARY];

/*Create geography table*/
Create table geography (
    geoID INT IDENTITY(1,1) NOT NULL,
    geoName NVARCHAR(125) NOT NULL,
    geoLevel INT NOT NULL,
    country NVARCHAR(2),
    regionID NVARCHAR(1),
    divisID NVARCHAR(1),
    stateID NVARCHAR(2),
    metroID NVARCHAR(5),
    metdivID NVARCHAR(5),
    countyID NVARCHAR(5),
    tractID NVARCHAR(11),
    blkgrpID NVARCHAR(12),
    geoLevel REFERENCES geolevel(geolevel),
    regionID REFERENCES region(regionID),
    divisID  REFERENCES divis(divisID),
    stateID  REFERENCES state(stateID),
    metroID  REFERENCES metro(metroID),
    metdivID REFERENCES metdiv(metdivID),
    countyID REFERENCES county(countyID),
    tractID  REFERENCES tract(tractID),
    blkgrpID REFERENCES blkgrp(blkgrpID),
    PRIMARY KEY (geoID)
) ON [PRIMARY];

/*Create theme table*/
CREATE TABLE theme (
    themeID INT IDENTITY(1,1) NOT NULL,
    themeName NVARCHAR(32) NOT NULL,
    themeDesc NVARCHAR(255) NOT NULL,
    PRIMARY KEY (themeID)
) ON [PRIMARY];

/*Create timePeriod table*/
CREATE TABLE timePeriod (
    timeID INT IDENTITY(1,1) NOT NULL,
    timeYear INT NOT NULL,
    timeQuarter INT NOT NULL,
    timeMonth INT NOT NULL,
    PRIMARY KEY (timeID)
) ON [PRIMARY];

/*Create dataSource table*/
CREATE TABLE dataSource (
    sourceID INT IDENTITY(1,1) NOT NULL,
    sourceName NVARCHAR(15) NOT NULL,
    sourceDesc NVARCHAR(100) NOT NULL,
    PRIMARY KEY (sourceID)
) ON [PRIMARY];

/*Create indicatorType table*/
CREATE TABLE indicatorType (
    indicID INT IDENTITY(1,1) NOT NULL,
    indicName NVARCHAR(32) NOT NULL,
    indicDesc NVARCHAR(300) NOT NULL,
    themeID INT NOT NULL,
    indicAvail NVARCHAR(14) NOT NULL,
    indicQuality NVARCHAR(14) NOT NULL,
    indicSpatial NVARCHAR(3) NOT NULL,
    indicFreq NVARCHAR(20) NOT NULL,
    indicNotes NVARCHAR(500) NULL,
    themeID REFERENCES theme(themeID),
    PRIMARY KEY (indicID)
) ON [PRIMARY];

/*Create indicatorValue table*/
CREATE TABLE indicatorValue (
    indicValue decimal(38,5),
    geoID   INT NOT NULL,
    timeID  INT NOT NULL,
    indicID INT NOT NULL,
    geoID   REFERENCES geography(geoID),
    timeID  REFERENCES time_period(timeID),
    indicID REFERENCES indicator_type(indicID),
    PRIMARY KEY (geoID,timeID,indicID)
) ON [PRIMARY];
