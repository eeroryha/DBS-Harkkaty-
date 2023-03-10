SELECT name, seasonid FROM PlayersInSeason
INNER JOIN Player ON PlayersInSeason.FK_playerid=Player.playerid
INNER JOIN Season ON PlayersInSeason.FK_seasonid=Season.seasonid
ORDER BY name
LIMIT 15