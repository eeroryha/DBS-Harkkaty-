
--Tällä saa pelaajan statsit kausittain
SELECT Season.seasonid AS 'Season', Team.name AS 'Team',games_played AS 'GP', A.i_f_goals AS 'G',
 A.i_f_primaryassists+A.i_f_secondaryassists AS 'A', A.i_f_points AS 'P',B.onice_f_goals-B.onice_a_goals AS '+/-', A.penalityminutes AS 'PM' FROM PlayersInSeason
INNER JOIN Player ON Player.playerid=PlayersInSeason.FK_playerid
INNER JOIN Season ON PlayersInSeason.FK_seasonid=Season.seasonid
INNER JOIN Team ON PlayersInSeason.FK_teamid=Team.teamid
INNER JOIN Skaterstats A ON A.FK_playerid=Player.playerid AND Season.seasonid=A.FK_seasonid
INNER JOIN Skaterstats B ON B.FK_playerid=Player.playerid AND Season.seasonid=B.FK_seasonid
WHERE Player.name='Cale Makar' AND A.situation='all' AND B.situation='5on5'
ORDER BY seasonid ASC;


--Tällä saa pelaajan kausien statsit laskettuna yhteen
SELECT SUM(games_played) AS 'Games Played', SUM (A.i_f_goals) AS 'Goals Total', SUM(A.i_f_primaryassists+A.i_f_secondaryassists) AS 'Assists Total',
 SUM(A.i_f_points) AS 'Points Total',SUM(B.onice_f_goals-B.onice_a_goals) AS '+/-', SUM(A.penalityminutes) AS 'Penalty Minutes' FROM PlayersInSeason
INNER JOIN Player ON Player.playerid=PlayersInSeason.FK_playerid
INNER JOIN Season ON PlayersInSeason.FK_seasonid=Season.seasonid
INNER JOIN Team ON PlayersInSeason.FK_teamid=Team.teamid
INNER JOIN Skaterstats A ON A.FK_playerid=Player.playerid AND Season.seasonid=A.FK_seasonid
INNER JOIN Skaterstats B ON B.FK_playerid=Player.playerid AND Season.seasonid=B.FK_seasonid
WHERE Player.name='Cale Makar' AND A.situation='all' AND B.situation='5on5';

