--Queries/Views to demonstrate the NHL database

--(1) List of all skaters in the league based on their points that season (2022)
DROP VIEW IF EXISTS skaterView;
CREATE VIEW skaterView AS
SELECT Player.name AS 'Player', Team.abbr AS 'Team', Skaterstats.i_f_goals AS 'G',
(Skaterstats.i_f_primaryassists+Skaterstats.i_f_secondaryassists) AS 'A', Skaterstats.i_f_points as 'P',Skaterstats.FK_seasonid AS 'Season'
FROM Player,Team
INNER JOIN PlayersInSeason ON Player.playerid=PlayersInSeason.FK_playerid
INNER JOIN Skaterstats ON (PlayersInSeason.FK_playerid=Skaterstats.FK_playerid AND PlayersInSeason.FK_seasonid=Skaterstats.FK_seasonid)
WHERE Skaterstats.situation='all' AND PlayersInSeason.FK_teamid=Team.teamid AND PlayersInSeason.FK_seasonid=2022
ORDER BY Skaterstats.i_f_points DESC;
SELECT * FROM skaterView;

--(2) List of all the goalies in the league based on their save percentage that season (2019)
DROP VIEW IF EXISTS goalieView;
CREATE VIEW goalieView AS
SELECT Player.Name AS 'Player', Team.abbr AS 'Team', round((1.0-CAST(Goaliestats.goals AS REAL)/CAST(Goaliestats.ongoal AS REAL)),3) AS 'Save%',
round(3600.0*CAST(Goaliestats.goals AS REAL)/CAST(Goaliestats.icetime AS REAL),2) AS 'GAA'
FROM Player,Team
INNER JOIN PlayersInSeason ON Player.playerid=PlayersInSeason.FK_playerid
INNER JOIN Goaliestats ON (PlayersInSeason.FK_playerid=Goaliestats.FK_playerid AND PlayersInSeason.FK_seasonid=Goaliestats.FK_seasonid)
WHERE Goaliestats.situation='all' AND PlayersInSeason.FK_teamid=Team.teamid AND PlayersInSeason.FK_seasonid=2019
ORDER BY CAST(Goaliestats.goals AS REAL)/CAST(Goaliestats.ongoal AS REAL);
SELECT * FROM goalieView;

--(3) List all of the teams in the league based on their expected goals percentage that season (2021)
DROP VIEW IF EXISTS teamView;
CREATE VIEW teamView AS
SELECT Team.name AS 'Team', Team.abbr AS 'Abbreviation',TeamsInSeason.FK_seasonid AS 'season',
Teamstats.goalsfor AS 'Goals',Teamstats.goalsagainst AS 'Against', Teamstats.xgoalspercentage as 'xG%'
FROM Team
INNER JOIN TeamsInSeason ON Team.teamid=TeamsInSeason.FK_teamid
INNER JOIN Teamstats ON(TeamsInSeason.FK_teamid=Teamstats.FK_teamid AND TeamsInSeason.FK_seasonid=Teamstats.FK_seasonid)
WHERE Teamstats.situation='all' AND TeamsInSeason.FK_teamid=Team.teamid AND TeamsInSeason.FK_seasonid=2021
ORDER BY Teamstats.xgoalspercentage DESC;
SELECT * FROM teamView;
        
--(4) List of all players in a team (Colorado Avalanche, 2021)
DROP VIEW IF EXISTS teamsPlayers;
CREATE VIEW teamsPlayers AS
SELECT Player.name AS 'Player', Team.abbr AS 'Team', Player.nationality AS 'Nationality',
Player.shootscatches AS 'L/R',PlayersInSeason.position AS 'Position',Player.jerseynumber AS 'Number'
FROM Player,TeamsInSeason
INNER JOIN PlayersInSeason ON Player.playerid=PlayersInSeason.FK_playerid
INNER JOIN Team ON(TeamsInSeason.FK_teamid=Team.teamid AND TeamsInSeason.FK_seasonid=PlayersInSeason.FK_seasonid)
WHERE PlayersInSeason.FK_teamid=Team.teamid AND TeamsInSeason.FK_seasonid=2021 AND Team.abbr='COL'
ORDER BY Player.jerseynumber ASC;
SELECT * FROM teamsPlayers;

--(5) Information about players stats and the team they have played from each season between 2018-2022 (Jesse Puljujarvi)
SELECT Season.seasonid AS 'Season', Team.name AS 'Team',games_played AS 'GP', A.i_f_goals AS 'G',
A.i_f_primaryassists+A.i_f_secondaryassists AS 'A', A.i_f_points AS 'P',B.onice_f_goals-B.onice_a_goals AS '+/-', A.penalityminutes AS 'PM' FROM PlayersInSeason
INNER JOIN Player ON Player.playerid=PlayersInSeason.FK_playerid
INNER JOIN Season ON PlayersInSeason.FK_seasonid=Season.seasonid
INNER JOIN Team ON PlayersInSeason.FK_teamid=Team.teamid
INNER JOIN Skaterstats A ON A.FK_playerid=Player.playerid AND Season.seasonid=A.FK_seasonid
INNER JOIN Skaterstats B ON B.FK_playerid=Player.playerid AND Season.seasonid=B.FK_seasonid
WHERE Player.name='Jesse Puljujarvi' AND A.situation='all' AND B.situation='5on5'
ORDER BY seasonid ASC;

--(6) One row of data from Player (Erik Karlsson)
SELECT * FROM Player
WHERE name='Erik Karlsson';

--(7) Many to many example on relationship in between Player and Season
SELECT name, seasonid FROM PlayersInSeason
INNER JOIN Player ON PlayersInSeason.FK_playerid=Player.playerid
INNER JOIN Season ON PlayersInSeason.FK_seasonid=Season.seasonid
ORDER BY name
LIMIT 15;