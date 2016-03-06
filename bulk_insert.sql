BULK INSERT CommunIndic.dbo.indicatorType FROM 'C:\Users\rrosso\Documents\aqoli\data\indicType.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')

BULK INSERT CommunIndic.dbo.region FROM 'C:\Users\rrosso\Documents\aqoli\data\region.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')

BULK INSERT CommunIndic.dbo.theme FROM 'C:\Users\rrosso\Documents\aqoli\data\theme.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')

BULK INSERT CommunIndic.dbo.dataSource FROM 'C:\Users\rrosso\Documents\aqoli\data\dataSource.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')

BULK INSERT CommunIndic.dbo.geolevel FROM 'C:\Users\rrosso\Documents\aqoli\data\geolevel.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')

BULK INSERT CommunIndic.dbo.divis FROM 'C:\Users\rrosso\Documents\aqoli\data\divis.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')