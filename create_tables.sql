/* Sample Code for Creating SQL Data Warehouse for Alexandria Community Indicators */

/* CREATE GEOGRAPHY TABLES */
/* Not all geographies necessary right now for Alexandria -- future-proofing */

/*REGION*/
Create table region (
	regionID int NOT NULL,
    regionFips varchar(1) NOT NULL,
    regionName varchar(9) NOT NULL,
    Primary key (regionID)
);

/*DIVISION*/
Create table divis (
	divisID int NOT NULL,
    divisFips varchar(1) NOT NULL,
    divisName varchar(18) NOT NULL,
    regionFips varchar(1) NOT NULL,
    Primary key (divisID),
    foreign key (regionID) references region(regionID)
);

/*STATE*/
Create table state (
	stateID int NOT NULL,
    stateFips varchar(2) NOT NULL,
    stateName varchar(20) NOT NULL,
    stateAbbrev varchar(2) NOT NULL,
Primary key (stateID)
);

/*METRO*/
create table metro (
	metroID int NOT NULL,
    metroFips varchar(5) NOT NULL,
    metroName varchar(125) NOT NULL,
    primary key (metroID)
);

/*METRO DIVISION*/
create table metdiv (
	metdivID int NOT NULL,
    metdivFips varchar(5) NOT NULL,
    metdivName varchar(125) NOT NULL,
    metroFips varchar(5) NOT NULL,
    primary key (metdivID),
    foreign key (metroID) references metro(metroID)
);

/*COUNTY*/
create table county (
	countyID int NOT NULL,
    countyFips varchar(5) NOT NULL,
    countyName varchar(50) NOT NULL,
    primary key (countyID)
);

/*TRACT*/
create table tract (
	tractID int NOT NULL,
    tractFips varchar(11) NOT NULL,
    countyFips varchar(5) NOT NULL,
    primary key (tractID),
    foreign key (countyID) references county(countyID)
);

/*BLOCK GROUP*/
create table blkgrp (
	blkgrpID int NOT NULL,
    blkgrpFips varchar(12) NOT NULL,
    tractFips varchar(11) NOT NULL,
    primary key (blkgrpID),
    foreign key (tractID) references tract(tractID)
);

/*GEOGRAPHY LEVEL*/
create table geoLevel (
    geolevel int NOT NULL,
    geolevelName varchar(30) NOT NULL,
    primary key (geolevel)
);

/*Create geography table*/
Create table geography (
    geoID integer NOT NULL,
    geoName varchar(125) NOT NULL,
    geoLevel integer NOT NULL,
    country varchar(2),
    regionID varchar(1),
    divisID varchar(1),
    stateID varchar(2),
    metroID varchar(5),
    metdivID varchar(5),
    countyID varchar(5),
    tractID varchar(11),
    blkgrpID varchar(12),
    Primary key (geoID),
    foreign key (geoLevel) references geolevel(geolevel),
    foreign key (regionID) references region(regionID),
    foreign key (divisID) references divis(divisID),
    foreign key (stateID) references state(stateID),
    foreign key (metroID) references metro(metroID),
    foreign key (metdivID) references metdiv(metdivID),
    foreign key (countyID) references county(countyID),
    foreign key (tractID) references tract(tractID),
    foreign key (blkgrpID) references blkgrp(blkgrpID)
);

/*Create theme table*/
create table theme (
    themeID integer NOT NULL,
    themeName varchar(32) NOT NULL,
    themeDesc varchar(255) NOT NULL,
    Primary key (themeID)
);

/*Create timePeriod table*/
create table timePeriod (
    timeID integer NOT NULL,
    timeYear integer NOT NULL,
    timeQuarter integer NOT NULL,
    timeMonth integer NOT NULL,
    Primary key (timeID)
);

/*Create dataSource table*/
create table dataSource (
    sourceID integer NOT NULL,
    sourceName varchar(15) NOT NULL,
    sourceDesc varchar(100) NOT NULL,
    Primary key (sourceID)
);

/*Create indicatorType table*/
create table indicatorType (
    indicID integer NOT NULL,
    indicName varchar(32) NOT NULL,
    indicDesc varchar(300) NOT NULL,
    themeID integer NOT NULL,
    indicAvail varchar(14) NOT NULL,
    indicQuality varchar(14) NOT NULL,
    indicSpatial varchar(3) NOT NULL,
    indicFreq varchar(20) NOT NULL,
    indicNotes varchar(500) NULL,
    Primary key (indicID),
    foreign key (themeID) references theme(themeID)
);

/*Create indicatorValue table*/
create table indicatorValue (
    indicValue decimal(38,5),
    geoID integer NOT NULL,
    timeID integer NOT NULL,
    indicID integer NOT NULL,
    primary key (geoID,timeID,indicID),
    foreign key (geoID) references geography(geoID),
    foreign key (timeID) references time_period(timeID),
    foreign key (indicID) references indicator_type(indicID)
);
