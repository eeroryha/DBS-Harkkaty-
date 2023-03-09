-- CREATE TABLES:
CREATE TABLE Player (
	playerid INT NOT NULL PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	birthdate VARCHAR(20),
	nationality VARCHAR(3),
	shootscatches VARCHAR(3),
	jerseynumber INT
	);
	
CREATE TABLE Team (
	teamid INT NOT NULL PRIMARY KEY,
	name VARCHAR (25) NOT NULL UNIQUE,
	abbr VARCHAR (3) NOT NULL UNIQUE
	);
CREATE TABLE Season (
	seasonid INT NOT NULL PRIMARY KEY,
	lockout BOOLEAN DEFAULT false
);

CREATE TABLE PlayersInSeason (
	FK_seasonid INT NOT NULL,
	FK_playerid INT NOT NULL,
	FK_teamid INT NOT NULL,
	position VARCHAR (3),
	games_played INT,
	FOREIGN KEY (FK_seasonid) REFERENCES Season (seasonid)
		ON DELETE CASCADE,
	FOREIGN KEY (FK_playerid) REFERENCES Player (playerid)
		ON DELETE CASCADE,
	FOREIGN KEY (FK_teamid) REFERENCES Team (teamid)
		ON DELETE CASCADE,
	CHECK (games_played>0)
	);
	
CREATE TABLE TeamsInSeason (
	FK_seasonid INT NOT NULL,
	FK_teamid INT NOT NULL,
	games_played INT,
	FOREIGN KEY (FK_seasonid) REFERENCES Season (seasonid)
		ON DELETE CASCADE,
	FOREIGN KEY (FK_teamid) REFERENCES Team (teamid)
		ON DELETE CASCADE
	);
	
CREATE TABLE Skaterstats (
   FK_playerid INT NOT NULL,
   FK_seasonid INT NOT NULL,
   situation VARCHAR (5),
   icetime INT,
   shifts INT,
   gamescore DECIMAL (5,3),
   onice_xgoalspercentage DECIMAL (5,3),
   office_xgoalspercentage DECIMAL (5,3),
   onice_corsipercentage DECIMAL (5,3),
   office_corsipercentage DECIMAL (5,3),
   onice_fenwickpercentage DECIMAL (5,3),
   office_fenwickpercentage DECIMAL (5,3),
   icetimerank DECIMAL (5,3),
   i_f_xongoal DECIMAL (5,3),
   i_f_xgoals DECIMAL (5,3),
   i_f_xrebounds DECIMAL (5,3),
   i_f_xfreeze DECIMAL (5,3),
   i_f_xplaystopped DECIMAL (5,3),
   i_f_xplaycontinuedinzone DECIMAL (5,3),
   i_f_xplaycontinuedoutsidezone DECIMAL (5,3),
   i_f_flurryadjustedxgoals DECIMAL (5,3),
   i_f_scorevenueadjustedxgoals DECIMAL (5,3),
   i_f_flurryscorevenueadjustedxgoals DECIMAL (5,3),
   i_f_primaryassists INT,
   i_f_secondaryassists INT,
   i_f_shotsongoal INT,
   i_f_missedshots INT,
   i_f_blockedshotattempts INT,
   i_f_shotattempts INT,
   i_f_points INT,
   i_f_goals INT,
   i_f_rebounds INT,
   i_f_reboundgoals INT,
   i_f_freeze INT,
   i_f_playstopped INT,
   i_f_playcontinuedinzone DECIMAL (5,3),
   i_f_playcontinuedoutsidezone DECIMAL (5,3),
   i_f_savedshotsongoal INT,
   i_f_savedunblockedshotattempts INT,
   penalties INT,
   i_f_penalityminutes INT,
   i_f_faceoffswon DECIMAL (5,3),
   i_f_hits INT,
   i_f_takeaways INT,
   i_f_giveaways INT,
   i_f_lowdangershots INT,
   i_f_mediumdangershots INT,
   i_f_highdangershots INT,
   i_f_lowdangerxgoals DECIMAL (5,3),
   i_f_mediumdangerxgoals DESIMAL (5,3),
   i_f_highdangerxgoals DECIMAL (5,3),
   i_f_lowdangergoals INT,
   i_f_mediumdangergoals INT,
   i_f_highdangergoals INT,
   i_f_scoreadjustedshotsattempts INT,
   i_f_unblockedshotattempts INT,
   i_f_scoreadjustedunblockedshotattempts INT,
   i_f_dzonegiveaways INT,
   i_f_xgoalsfromxreboundsofshots DECIMAL (5,3),
   i_f_xgoalsfromactualreboundsofshots DECIMAL (5,3),
   i_f_reboundxgoals DECIMAL (5,3),
   i_f_xgoals_with_earned_rebounds DECIMAL (5,3),
   i_f_xgoals_with_earned_rebounds_scoreadjusted DECIMAL (5,3),
   i_f_xgoals_with_earned_rebounds_scoreflurryadjusted DECIMAL (5,3),
   i_f_shifts INT,
   i_f_ozoneshiftstarts INT,
   i_f_dzoneshiftstarts INT,
   i_f_neutralzoneshiftstarts INT,
   i_f_flyshiftstarts INT,
   i_f_ozoneshiftends INT,
   i_f_dzoneshiftends INT,
   i_f_neutralzoneshiftends INT,
   i_f_flyshiftends INT,
   faceoffswon INT,
   faceoffslost INT,
   timeonbench DECIMAL (5,3),
   penalityminutes INT,
   penalityminutesdrawn INT,
   penaltiesdrawn INT,
   shotsblockedbyplayer INT,
   onice_f_xongoal DECIMAL (5,3),
   onice_f_xgoals DECIMAL (5,3),
   onice_f_flurryadjustedxgoals DECIMAL (5,3),
   onice_f_scorevenueadjustedxgoals DECIMAL (5,3),
   onice_f_flurryscorevenueadjustedxgoals DECIMAL (5,3),
   onice_f_shotsongoal INT,
   onice_f_missedshots INT,
   onice_f_blockedshotattempts INT,
   onice_f_shotattempts INT,
   onice_f_goals INT,
   onice_f_rebounds INT,
   onice_f_reboundgoals INT,
   onice_f_lowdangershots INT,
   onice_f_mediumdangershots INT,
   onice_f_highdangershots INT,
   onice_f_lowdangerxgoals DECIMAL (5,3),
   onice_f_mediumdangerxgoals DECIMAL (5,3),
   onice_f_highdangerxgoals DECIMAL (5,3),
   onice_f_lowdangergoals INT,
   onice_f_mediumdangergoals INT,
   onice_f_highdangergoals INT,
   onice_f_scoreadjustedshotsattempts DECIMAL (5,3),
   onice_f_unblockedshotattempts DECIMAL (5,3),
   onice_f_scoreadjustedunblockedshotattempts DECIMAL (5,3),
   onice_f_xgoalsfromxreboundsofshots DECIMAL (5,3),
   onice_f_xgoalsfromactualreboundsofshots DECIMAL (5,3),
   onice_f_reboundxgoals DECIMAL (5,3),
   onice_f_xgoals_with_earned_rebounds DECIMAL (5,3),
   onice_f_xgoals_with_earned_rebounds_scoreadjusted DECIMAL (5,3),
   onice_f_xgoals_with_earned_rebounds_scoreflurryadjusted DECIMAL (5,3),
   onice_a_xongoal DECIMAL (5,3),
   onice_a_xgoals DECIMAL (5,3),
   onice_a_flurryadjustedxgoals DECIMAL (5,3),
   onice_a_scorevenueadjustedxgoals DECIMAL (5,3),
   onice_a_flurryscorevenueadjustedxgoals DECIMAL (5,3),
   onice_a_shotsongoal INT,
   onice_a_missedshots INT,
   onice_a_blockedshotattempts INT,
   onice_a_shotattempts INT,
   onice_a_goals INT,
   onice_a_rebounds INT,
   onice_a_reboundgoals INT,
   onice_a_lowdangershots INT,
   onice_a_mediumdangershots INT,
   onice_a_highdangershots INT,
   onice_a_lowdangerxgoals DECIMAL (5,3),
   onice_a_mediumdangerxgoals DECIMAL (5,3),
   onice_a_highdangerxgoals DECIMAL (5,3),
   onice_a_lowdangergoals INT,
   onice_a_mediumdangergoals INT,
   onice_a_highdangergoals INT,
   onice_a_scoreadjustedshotsattempts DECIMAL (5,3),
   onice_a_unblockedshotattempts DECIMAL (5,3),
   onice_a_scoreadjustedunblockedshotattempts DECIMAL (5,3),
   onice_a_xgoalsfromxreboundsofshots DECIMAL (5,3),
   onice_a_xgoalsfromactualreboundsofshots DECIMAL (5,3),
   onice_a_reboundxgoals DECIMAL (5,3),
   onice_a_xgoals_with_earned_rebounds DECIMAL (5,3),
   onice_a_xgoals_with_earned_rebounds_scoreadjusted DECIMAL (5,3),
   onice_a_xgoals_with_earned_rebounds_scoreflurryadjusted DECIMAL (5,3),
   office_f_xgoals DECIMAL (5,3),
   office_a_xgoals DECIMAL (5,3),
   office_f_shotattempts DECIMAL (5,3),
   office_a_shotattempts DECIMAL (5,3),
   xgoalsforaftershifts DECIMAL (5,3),
   xgoalsagainstaftershifts DECIMAL (5,3),
   corsiforaftershifts DECIMAL (5,3),
   corsiagainstaftershifts DECIMAL (5,3),
   fenwickforaftershifts DECIMAL (5,3),
   fenwickagainstaftershifts DECIMAL (5,3),
   FOREIGN KEY (FK_playerid) REFERENCES Player (playerid)
		ON DELETE CASCADE,
   FOREIGN KEY (FK_seasonid) REFERENCES Season (seasonid)
		ON DELETE CASCADE
   );
  

CREATE TABLE Goaliestats ( 
   FK_playerid INT NOT NULL,
   FK_seasonid INT NOT NULL,
   situation VARCHAR (5),
   icetime DECIMAL (6,3),
   xgoals DECIMAL (6,3),
   goals INT,
   unblocked_shot_attempts INT,
   xrebounds DECIMAL (6,3),
   rebounds INT,
   xfreeze DECIMAL (6,3),
   freeze INT,
   xongoal DECIMAL (6,3),
   ongoal INT,
   xplaystopped DECIMAL (6,3),
   playstopped INT,
   xplaycontinuedinzone DECIMAL (6,3),
   playcontinuedinzone INT,
   xplaycontinuedoutsidezone DECIMAL (6,3),
   playcontinuedoutsidezone INT,
   flurryadjustedxgoals DECIMAL (6,3),
   lowdangershots INT,
   mediumdangershots INT,
   highdangershots INT,
   lowdangerxgoals DECIMAL (6,3),
   mediumdangerxgoals DECIMAL (6,3),
   highdangerxgoals DECIMAL (6,3),
   lowdangergoals INT,
   mediumdangergoals INT,
   highdangergoals INT,
   blocked_shot_attempts DECIMAL (6,3),
   penalityminutes INT,
   penalties INT,
   FOREIGN KEY (FK_playerid) REFERENCES Player (playerid)
		ON DELETE CASCADE,
   FOREIGN KEY (FK_seasonid) REFERENCES Season (seasonid)
		ON DELETE CASCADE
	);


CREATE TABLE Teamstats ( 
   FK_teamid INT NOT NULL,
   FK_seasonid INT NOT NULL,
   situation VARCHAR (5),
   xgoalspercentage DECIMAL (6,3),
   corsipercentage DECIMAL (6,3),
   fenwickpercentage DECIMAL (6,3),
   icetime DECIMAL (6,3),
   xongoalfor DECIMAL (6,3),
   xgoalsfor DECIMAL (6,3),
   xreboundsfor DECIMAL (6,3),
   xfreezefor DECIMAL (6,3),
   xplaystoppedfor DECIMAL (6,3),
   xplaycontinuedinzonefor DECIMAL (6,3),
   xplaycontinuedoutsidezonefor DECIMAL (6,3),
   flurryadjustedxgoalsfor DECIMAL (6,3),
   scorevenueadjustedxgoalsfor DECIMAL (6,3),
   flurryscorevenueadjustedxgoalsfor DECIMAL (6,3),
   shotsongoalfor INT,
   missedshotsfor INT,
   blockedshotattemptsfor INT,
   shotattemptsfor INT,
   goalsfor INT,
   reboundsfor INT,
   reboundgoalsfor INT,
   freezefor INT,
   playstoppedfor INT,
   playcontinuedinzonefor INT,
   playcontinuedoutsidezonefor INT,
   savedshotsongoalfor INT,
   savedunblockedshotattemptsfor INT,
   penaltiesfor INT,
   penalityminutesfor INT,
   faceoffswonfor INT,
   hitsfor INT,
   takeawaysfor INT
   giveawaysfor INT
   lowdangershotsfor INT,
   mediumdangershotsfor INT,
   highdangershotsfor INT,
   lowdangerxgoalsfor DECIMAL (6,3),
   mediumdangerxgoalsfor DECIMAL (6,3),
   highdangerxgoalsfor DECIMAL (6,3),
   lowdangergoalsfor INT,
   mediumdangergoalsfor INT,
   highdangergoalsfor INT,
   scoreadjustedshotsattemptsfor INT,
   unblockedshotattemptsfor INT,
   scoreadjustedunblockedshotattemptsfor DECIMAL (6,3),
   dzonegiveawaysfor INT,
   xgoalsfromxreboundsofshotsfor DECIMAL (6,3),
   xgoalsfromactualreboundsofshotsfor DECIMAL (6,3),
   reboundxgoalsfor DECIMAL (6,3),
   totalshotcreditfor DECIMAL (6,3),
   scoreadjustedtotalshotcreditfor DECIMAL (6,3),
   scoreflurryadjustedtotalshotcreditfor DECIMAL (6,3),
   xongoalagainst DECIMAL (6,3),
   xgoalsagainst DECIMAL (6,3),
   xreboundsagainst DECIMAL (6,3),
   xfreezeagainst DECIMAL (6,3),
   xplaystoppedagainst DECIMAL (6,3),
   xplaycontinuedinzoneagainst DECIMAL (6,3),
   xplaycontinuedoutsidezoneagainst DECIMAL (6,3),
   flurryadjustedxgoalsagainst DECIMAL (6,3),
   scorevenueadjustedxgoalsagainst DECIMAL (6,3),
   flurryscorevenueadjustedxgoalsagainst DECIMAL (6,3),
   shotsongoalagainst INT,
   missedshotsagainst INT,
   blockedshotattemptsagainst INT,
   shotattemptsagainst INT,
   goalsagainst INT,
   reboundsagainst INT,
   reboundgoalsagainst INT,
   freezeagainst INT,
   playstoppedagainst INT,
   playcontinuedinzoneagainst INT,
   playcontinuedoutsidezoneagainst INT,
   savedshotsongoalagainst INT,
   savedunblockedshotattemptsagainst INT,
   penaltiesagainst INT,
   penalityminutesagainst INT,
   faceoffswonagainst INT,
   hitsagainst INT,
   takeawaysagainst INT,
   giveawaysagainst INT,
   lowdangershotsagainst INT,
   mediumdangershotsagainst INT,
   highdangershotsagainst INT,
   lowdangerxgoalsagainst DECIMAL (6,3),
   mediumdangerxgoalsagainst DECIMAL (6,3),
   highdangerxgoalsagainst DECIMAL (6,3),
   lowdangergoalsagainst INT,
   mediumdangergoalsagainst INT,
   highdangergoalsagainst INT,
   scoreadjustedshotsattemptsagainst DECIMAL (6,3),
   unblockedshotattemptsagainst DECIMAL (6,3),
   scoreadjustedunblockedshotattemptsagainst DECIMAL (6,3),
   dzonegiveawaysagainst INT,
   xgoalsfromxreboundsofshotsagainst DECIMAL (6,3),
   xgoalsfromactualreboundsofshotsagainst DECIMAL (6,3),
   reboundxgoalsagainst DECIMAL (6,3),
   totalshotcreditagainst DECIMAL (6,3),
   scoreadjustedtotalshotcreditagainst DECIMAL (6,3),
   scoreflurryadjustedtotalshotcreditagainst DECIMAL (6,3),
   FOREIGN KEY (FK_seasonid) REFERENCES Season (seasonid)
		ON DELETE CASCADE,
   FOREIGN KEY (FK_teamid) REFERENCES Team (teamid)
		ON DELETE CASCADE
);

-- CREATE INDICES
CREATE INDEX PlayersInSeasonIndex ON PlayersInSeason(FK_seasonid,FK_playerid,FK_teamid);
CREATE INDEX TeamsInSeasonIndex ON TeamsInSeason(FK_seasonid,FK_teamid);
CREATE INDEX SkaterstatsIndex ON Skaterstats(FK_playerid,FK_seasonid);
CREATE INDEX GoaliestatsIndex ON Goaliestats(FK_playerid,FK_seasonid);
CREATE INDEX TeamstatsIndex ON Teamstats(FK_teamid,FK_seasonid);
