-- DDL 
Use master 
GO
USE qol1;
DROP TABLE IF EXISTS Survey;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Topic;
DROP TABLE IF EXISTS Breakout;

CREATE TABLE Location (
    Id                   INT             PRIMARY KEY IDENTITY(1,1),
    Location_number      INT             NULL,
    State_abbr           VARCHAR(20)      NULL,
    State                VARCHAR(30)      NULL,
    GeoLocation          varchar(50)             NULL
    
);

CREATE TABLE Topic (
    Id                   INT             PRIMARY KEY IDENTITY(1,1),
    Topic                VARCHAR(50)     NOT NULL,
    Topic_name           VARCHAR(50)     NOT NULL,
    Question             VARCHAR(100)     NOT NULL,
    Question_name        VARCHAR(50)     NOT NULL
);

CREATE TABLE Breakout (
    Id                   INT             PRIMARY KEY IDENTITY(1,1),
    Breakout             VARCHAR(30)     NOT NULL,
    Breakout_name        VARCHAR(20)     NOT NULL,
    Breakout_category    VARCHAR(20)     NOT NULL,
    Breakout_category_name VARCHAR(20)   NOT NULL
);
CREATE TABLE Survey (
    Id                   INT             PRIMARY KEY IDENTITY(1,1),
    Year                 int              NULL,
    Sample_size          INT             NULL,
    Data_value           FLOAT           NULL,
    Data_value_type      VARCHAR(50)      NOT NULL,
    LocationId           INT             NOT  NULL,
    BreakoutId           INT              NOT NULL,
    TopicId              INT              NOT NULL,
    CONSTRAINT fk_Survey_LocationId FOREIGN KEY(LocationId) REFERENCES Location(Id),
    CONSTRAINT fk_Survey_TopicId FOREIGN KEY(TopicId) REFERENCES Topic(Id),
    CONSTRAINT fk_Survey_BreakoutId FOREIGN KEY(BreakoutId) REFERENCES Breakout(Id)
);

-- DML

SELECT *    FROM [qol1].[dbo].[QualityOfLifeTemp]

INSERT INTO Location (Location_number, State_abbr, State, GeoLocation)    
SELECT DISTINCT LocationId, LocationAbbr, LocationDesc, GeoLocation 
FROM [qol1].[dbo].[QualityOfLifeTemp];

INSERT INTO Topic (Topic, Topic_name, [Question], [Question_name])    
SELECT DISTINCT Topic, TopicId, [Question], [QuestionId]
FROM [qol1].[dbo].[QualityOfLifeTemp];

INSERT INTO Breakout (Breakout, Breakout_name, Breakout_category, Breakout_category_name)
SELECT DISTINCT Break_Out, BreakOutId, Break_Out_Category, BreakOutCategoryid
  FROM [qol1].[dbo].[QualityOfLifeTemp]

INSERT INTO Survey ([Year], Sample_size, Data_value, Data_value_type, LocationId, BreakoutId, TopicId)
SELECT Distinct [Year], Sample_Size, Data_Value, Data_Value_Type, l.Id, b.Id, t.Id

FROM QualityOfLifeTemp q
INNER JOIN Location l ON l.Location_number = q.LocationId
INNER JOIN Breakout b ON b.Breakout = q.Break_Out
INNER JOIN Topic t ON t.Question = q.Question;





