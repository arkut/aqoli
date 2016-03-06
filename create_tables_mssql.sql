/* Sample Code for Creating SQL Data Warehouse for Alexandria Community Indicators */

/* CREATE GEOGRAPHY TABLES */
/* Not all geographies necessary right now for Alexandria -- future-proofing */

/*REGION*/
CREATE TABLE region (
    regionID INT IDENTITY(1,1) NOT NULL,
    regionFips INT NOT NULL,
    regionName NVARCHAR(9) NOT NULL,
    PRIMARY KEY (regionID)
) ON [PRIMARY];

/*DIVISION*/
CREATE TABLE divis (
	divisID INT IDENTITY(1,1) NOT NULL,
    divisFips INT NOT NULL,
    divisName NVARCHAR(18) NOT NULL,
    regionID INT NOT NULL REFERENCES region(regionID),
    PRIMARY KEY (divisID)
) ON [PRIMARY];

/*STATE*/
CREATE TABLE states (
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
    countyID INT NOT NULL REFERENCES county(countyID),
    PRIMARY KEY (tractID)
) ON [PRIMARY];

/*BLOCK GROUP*/
CREATE TABLE blkgrp (
	blkgrpID INT IDENTITY(1,1) NOT NULL,
    blkgrpFips NVARCHAR(12) NOT NULL,
    tractFips NVARCHAR(11) NOT NULL,
    tractID INT NOT NULL REFERENCES tract(tractID),
    PRIMARY KEY (blkgrpID)
) ON [PRIMARY];

/*ZCTA (Zip Codes)*/
CREATE TABLE zcta (
    zctaID INT IDENTITY(1,1) NOT NULL,
    zcta NVARCHAR(12) NOT NULL,
    PRIMARY KEY (zctaID)
) ON [PRIMARY];

/*GEOGRAPHY LEVEL*/
/*CREATE TABLE geoLevel (
    geolevel INT IDENTITY(1,1) NOT NULL,
    geolevelName NVARCHAR(30) NOT NULL,
    PRIMARY KEY (geolevel)
) ON [PRIMARY];*/

/*Create geos fact table*/
Create table geos (
    geoID      INT IDENTITY(1,1) NOT NULL,
    geoName    NVARCHAR(125) NOT NULL,
    country    NVARCHAR(2),
    regionFips INT,
    divisFips  INT,
    stateFips  INT,
    metroFips  INT,
    metdivFips INT,
    countyFips INT,
    tractFips  INT,
    blkgrpFips INT,
    zcta       INT,
    regionID INT REFERENCES region(regionID),
    divisID  INT REFERENCES divis(divisID),
    stateID  INT REFERENCES states(stateID),
    metroID  INT REFERENCES metro(metroID),
    metdivID INT REFERENCES metdiv(metdivID),
    countyID INT REFERENCES county(countyID),
    tractID  INT REFERENCES tract(tractID),
    blkgrpID INT REFERENCES blkgrp(blkgrpID),
    zctaID   INT REFERENCES zcta(zctaID),
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
    indicID      INT IDENTITY(1,1) NOT NULL,
    indicName    NVARCHAR(32) NOT NULL,
    indicDesc    NVARCHAR(255) NOT NULL,
    indicAvail   INT NOT NULL,
    indicQuality INT NOT NULL,
    indicSpatial INT NOT NULL,
    indicFreq    INT NOT NULL,
    indicNotes   NVARCHAR(255) NULL,
    themeID      INT NOT NULL REFERENCES theme(themeID),
    PRIMARY KEY (indicID)
) ON [PRIMARY];

/*Create indicatorValue table*/
CREATE TABLE indicatorValue (
    indicValue decimal(38,5),
    geoID   INT NOT NULL REFERENCES geos(geoID),
    timeID  INT NOT NULL REFERENCES timePeriod(timeID),
    indicID INT NOT NULL REFERENCES indicatorType(indicID),
    PRIMARY KEY (geoID,timeID,indicID)
) ON [PRIMARY];
