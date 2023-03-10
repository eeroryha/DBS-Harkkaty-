--CREATE VIEW PlayerCareer AS

SELECT Season.seasonid AS 'Season', Team.name AS 'Team',games_played AS 'GP', i_f_goals AS 'G',
 i_f_primaryassists+i_f_secondaryassists AS 'A', i_f_points AS 'P', penalityminutes AS 'PM' FROM PlayersInSeason
INNER JOIN Player ON Player.playerid=PlayersInSeason.FK_playerid
INNER JOIN Season ON PlayersInSeason.FK_seasonid=Season.seasonid
INNER JOIN Team ON PlayersInSeason.FK_teamid=Team.teamid
INNER JOIN Skaterstats ON Skaterstats.FK_playerid=Player.playerid AND Season.seasonid=Skaterstats.FK_seasonid
WHERE Player.name='Nathan MacKinnon' AND situation='all'
ORDER BY seasonid ASC;

SELECT SUM(games_played) AS 'Games Played', SUM (i_f_goals) AS 'Goals Total', SUM(i_f_primaryassists+i_f_secondaryassists) AS 'Assists Total',
 SUM(i_f_points) AS 'Points Total', SUM(penalityminutes) AS 'Penalty Minutes' FROM PlayersInSeason
INNER JOIN Player ON Player.playerid=PlayersInSeason.FK_playerid
INNER JOIN Season ON PlayersInSeason.FK_seasonid=Season.seasonid
INNER JOIN Team ON PlayersInSeason.FK_teamid=Team.teamid
INNER JOIN Skaterstats ON Skaterstats.FK_playerid=Player.playerid AND Season.seasonid=Skaterstats.FK_seasonid
WHERE Player.name='Nathan MacKinnon' AND situation='all';

/*
SELECT Season.seasonid AS 'Season', Team.name AS 'Team',games_played AS 'GP', i_f_goals AS 'G',
 i_f_primaryassists+i_f_secondaryassists AS 'A', i_f_points AS 'P', (onice_f_goals-onice_a_goals) FROM PlayersInSeason
INNER JOIN Player ON Player.playerid=PlayersInSeason.FK_playerid
INNER JOIN Season ON PlayersInSeason.FK_seasonid=Season.seasonid
INNER JOIN Team ON PlayersInSeason.FK_teamid=Team.teamid
INNER JOIN Skaterstats ON Skaterstats.FK_playerid=Player.playerid AND Season.seasonid=Skaterstats.FK_seasonid
WHERE Player.name='Nathan MacKinnon' AND (situation='5on5')
ORDER BY seasonid ASC;