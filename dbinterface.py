import sqlite3
db = sqlite3.connect('NHLdb.db')
cur = db.cursor()
def initializeDB():
    try:
        f = open("sqlcommands.sql", "r")
        commandstring = ""
        for line in f.readlines():
            commandstring+=line
        cur.executescript(commandstring)
    except sqlite3.OperationalError:
        print("Database exists, skip initialization")
    except:
        print("No SQL file to be used for initialization") 
    return

def main():
    initializeDB()
    userInput = -1
    while(userInput != "0"):
        print("\nMenu options:")
        print("1: Print skaters")
        print("2: Print goalies")
        print("3: Print teams")
        print("4: Search for all players in a team")
        print("5: Search for stats from each year of a players career")
        print("6: Search information about one player")
        print("7: An example how the many-to-many-relationship works")
        print("8: Insert a new player into the database")
        print("9: Change a player's jersey number")
        print("10: Delete a player from the database")
        print("0: Quit")
        userInput = input("What do you want to do? ")
        if userInput == "1":
            showSkaters()
        if userInput == "2":
            showGoalies()
        if userInput == "3":
            showTeams()
        if userInput == "4":
            showPlayersInTeam()
        if userInput == "5":
            showCareers()
        if userInput == "6":
            searchOnePlayer()
        if userInput == "7":
            manyToManyExample()
        if userInput == "8":
            insertPlayer()
        if userInput == "9":
            updatePlayer()
        if userInput == "10":
            deletePlayer()
        if userInput == "0":
            print("Ending software...")
    db.close()        
    return

def showSkaters():
    while(True):
        season=input("\nFrom which season do you want the top scorers from? (2018-2022) ")
        if(int(season)<2018 or int(season)>2022):
                    print("Give a season between 2018 and 2022")
                    continue
        #this function prints players name, team, goals, assists and points 
        cur.execute("DROP VIEW IF EXISTS skaterView;")
        cur.execute("CREATE VIEW skaterView AS\
                    SELECT Player.name AS 'Player', Team.abbr AS 'Team', Skaterstats.i_f_goals AS 'G',\
                    (Skaterstats.i_f_primaryassists+Skaterstats.i_f_secondaryassists) AS 'A', Skaterstats.i_f_points as 'P',Skaterstats.FK_seasonid AS 'Season'\
                    FROM Player,Team\
                    INNER JOIN PlayersInSeason ON Player.playerid=PlayersInSeason.FK_playerid\
                    INNER JOIN Skaterstats ON (PlayersInSeason.FK_playerid=Skaterstats.FK_playerid AND PlayersInSeason.FK_seasonid=Skaterstats.FK_seasonid)\
                    WHERE Skaterstats.situation='all' AND PlayersInSeason.FK_teamid=Team.teamid AND PlayersInSeason.FK_seasonid="+season+"\
                    ORDER BY Skaterstats.i_f_points DESC;")
        cur.execute("SELECT * FROM skaterView")
        results=cur.fetchall()
        print("\nName, Team, G, A, P, Season")
        for i in range(len(results)):
            print(results[i])
        break

    return

def showGoalies():
    #this function prints goalies name, team, and two of the most important stats, save percentage and goals against average
    season=input("\nFrom which season do you want the best goalies from? (2018-2022) ")
    cur.execute("DROP VIEW IF EXISTS goalieView;")
    cur.execute("CREATE VIEW goalieView AS\
                SELECT Player.Name AS 'Player', Team.abbr AS 'Team', round((1.0-CAST(Goaliestats.goals AS REAL)/CAST(Goaliestats.ongoal AS REAL)),3) AS 'Save%',\
                round(3600.0*CAST(Goaliestats.goals AS REAL)/CAST(Goaliestats.icetime AS REAL),2) AS 'GAA'\
                FROM Player,Team\
                INNER JOIN PlayersInSeason ON Player.playerid=PlayersInSeason.FK_playerid\
                INNER JOIN Goaliestats ON (PlayersInSeason.FK_playerid=Goaliestats.FK_playerid AND PlayersInSeason.FK_seasonid=Goaliestats.FK_seasonid)\
                WHERE Goaliestats.situation='all' AND PlayersInSeason.FK_teamid=Team.teamid AND PlayersInSeason.FK_seasonid="+season+"\
                ORDER BY CAST(Goaliestats.goals AS REAL)/CAST(Goaliestats.ongoal AS REAL);")
    cur.execute("SELECT * FROM goalieView")
    results=cur.fetchall()
    print("\nName, Team, Save%, GAA")
    for i in range(len(results)):
        print(results[i])

    return

def showTeams():
    #This allows the user to see all the teams scored goals, goals given and expected goals percentage from any season between 2018 and 2022
    while(True):
        season=input("\nWhich season do you want the data from (2018-2022)? ")
        if(int(season)<2018 or int(season)>2022):
                print("Give a season between 2018 and 2022")
                continue
        cur.execute("DROP VIEW IF EXISTS teamView;")
        cur.execute("CREATE VIEW teamView AS\
                    SELECT Team.name AS 'Team', Team.abbr AS 'Abbreviation',TeamsInSeason.FK_seasonid AS 'season',\
                    Teamstats.goalsfor AS 'Goals',Teamstats.goalsagainst AS 'Against', Teamstats.xgoalspercentage as 'xG%'\
                    FROM Team\
                    INNER JOIN TeamsInSeason ON Team.teamid=TeamsInSeason.FK_teamid\
                    INNER JOIN Teamstats ON(TeamsInSeason.FK_teamid=Teamstats.FK_teamid AND TeamsInSeason.FK_seasonid=Teamstats.FK_seasonid)\
                    WHERE Teamstats.situation='all' AND TeamsInSeason.FK_teamid=Team.teamid AND TeamsInSeason.FK_seasonid="+season+"\
                    ORDER BY Teamstats.xgoalspercentage DESC;")
        cur.execute("SELECT * FROM teamView")
        results=cur.fetchall()
        print("\nTeam, Abbreviation, Season, Goals, Goals against, xG%")
        for i in range(len(results)):
            print(results[i])
        break
    return

def showPlayersInTeam():
    #This allows the user to search for a team and a year from which they want to see the teams roster
    while(True):
        team=input("\nWhich team do you want the players from (three letter abbreviation)? ")
        season=input("Which year do you want the roster from? ")
        if(int(season)<2018 or int(season)>2022):
            print("Give a season between 2018 and 2022")
            continue
        cur.execute("DROP VIEW IF EXISTS teamsPlayers;")
        cur.execute("CREATE VIEW teamsPlayers AS\
                    SELECT Player.name AS 'Player', Team.abbr AS 'Team', Player.nationality AS 'Nationality',\
                    Player.shootscatches AS 'L/R',PlayersInSeason.position AS 'Position',Player.jerseynumber AS 'Number'\
                    FROM Player,TeamsInSeason\
                    INNER JOIN PlayersInSeason ON Player.playerid=PlayersInSeason.FK_playerid\
                    INNER JOIN Team ON(TeamsInSeason.FK_teamid=Team.teamid AND TeamsInSeason.FK_seasonid=PlayersInSeason.FK_seasonid)\
                    WHERE PlayersInSeason.FK_teamid=Team.teamid AND TeamsInSeason.FK_seasonid="+season+" AND Team.abbr='"+team+"'\
                    ORDER BY Player.jerseynumber ASC;")
        cur.execute("SELECT * FROM teamsPlayers")
        results=cur.fetchall()
        if(len(results)==0):
            print("Give a valid team name")
            continue
        print("\nPlayer, Team, Nationality, L/R, Position, Number")
        for i in range(len(results)):
            print(results[i])
        break
    return

def showCareers():
    #This allows the user to search for one player in the database, and see their stats from 2018-2022 and the totals from those seasons
    while(True):
        player=input("\nWhich player do you want the career stats from? ")
        print()
        cur.execute("SELECT Season.seasonid AS 'Season', Team.name AS 'Team',games_played AS 'GP', A.i_f_goals AS 'G',\
                    A.i_f_primaryassists+A.i_f_secondaryassists AS 'A', A.i_f_points AS 'P',B.onice_f_goals-B.onice_a_goals AS '+/-', A.penalityminutes AS 'PM' FROM PlayersInSeason\
                    INNER JOIN Player ON Player.playerid=PlayersInSeason.FK_playerid\
                    INNER JOIN Season ON PlayersInSeason.FK_seasonid=Season.seasonid\
                    INNER JOIN Team ON PlayersInSeason.FK_teamid=Team.teamid\
                    INNER JOIN Skaterstats A ON A.FK_playerid=Player.playerid AND Season.seasonid=A.FK_seasonid\
                    INNER JOIN Skaterstats B ON B.FK_playerid=Player.playerid AND Season.seasonid=B.FK_seasonid\
                    WHERE Player.name='"+player+"' AND A.situation='all' AND B.situation='5on5'\
                    ORDER BY seasonid ASC;")
        results=cur.fetchall()
        if(len(results)==0):
            print("Give a valid player name.")
            continue

        print("Season, Team, GP, Goals, Assists, Points, +/-, PM")
        for i in range(len(results)):
            print(results[i])
        
        cur.execute("SELECT SUM(games_played) AS 'Games Played', SUM (A.i_f_goals) AS 'Goals Total', SUM(A.i_f_primaryassists+A.i_f_secondaryassists) AS 'Assists Total',\
                    SUM(A.i_f_points) AS 'Points Total',SUM(B.onice_f_goals-B.onice_a_goals) AS '+/-', SUM(A.penalityminutes) AS 'Penalty Minutes' FROM PlayersInSeason\
                    INNER JOIN Player ON Player.playerid=PlayersInSeason.FK_playerid\
                    INNER JOIN Season ON PlayersInSeason.FK_seasonid=Season.seasonid\
                    INNER JOIN Team ON PlayersInSeason.FK_teamid=Team.teamid\
                    INNER JOIN Skaterstats A ON A.FK_playerid=Player.playerid AND Season.seasonid=A.FK_seasonid\
                    INNER JOIN Skaterstats B ON B.FK_playerid=Player.playerid AND Season.seasonid=B.FK_seasonid\
                    WHERE Player.name='"+player+"' AND A.situation='all' AND B.situation='5on5';")
        results=cur.fetchall()
        print("\nTotal")
        print("GP, G, A, P, +/-, PM")
        for i in range(len(results)):
            print(results[i])
        break
    return

def searchOnePlayer():
    #this allows user to search for one row in the Player-table
    name=input("\nWhich players information you want to search? ")
    cur.execute("SELECT * FROM Player WHERE Player.name='"+name+"';")
    results=cur.fetchall()
    if(len(results)==0):
        print("\nNo such player found.")
        return
    print("\nID, Name, Birthdate, Nationality, L/R, Number")
    print(results[0])
    return

def manyToManyExample():
    #Each player has played during multiple seasons, and each season has multiple players
    cur.execute("SELECT name, seasonid FROM PlayersInSeason\
                INNER JOIN Player ON PlayersInSeason.FK_playerid=Player.playerid\
                INNER JOIN Season ON PlayersInSeason.FK_seasonid=Season.seasonid\
                ORDER BY name\
                LIMIT 15")
    results=cur.fetchall()
    print("Name, Season")
    for i in range(len(results)):
        print(results[i])
    return

def insertPlayer():
    try: # This function allows user to insert a new player into the database
        #playerID is calculated automatically
        name=input("\nEnter the name of the new player (first_name last_name): ")
        birthdate=input("Please enter the birthdate of the new player (YYYY-MM-DD): ")
        nationality=input("Please enter the nationality of the player (TLA): ")
        handedness=input("Please enter the handedness of the player (L/R): ")
        number=int(input("Please enter the jersey number of the player: "))
        cur.execute("INSERT INTO Player VALUES ((SELECT MAX(playerid) FROM Player)+1,?,?,?,?,?);",\
                    (name,birthdate,nationality,handedness,number))
        db.commit()
        cur.execute("SELECT * FROM Player WHERE Player.name='"+name+"';")
        results=cur.fetchall()
        print("\nID, Name, Birthdate, Nationality, L/R, Number")
        print(results[0])
        return
    except Exception:
        print("\nSomething went wrong, please try again.")
        db.rollback()
        return
def updatePlayer():
    #This function allows user to update a player's jersey number
    try:
        name=input("\nEnter the name of the player: ")
        number=input("Enter the new jersey number of the player: ")
        cur.execute("UPDATE Player SET jerseynumber=? WHERE name=?;",(number,name))
        db.commit()
        print(f"The player's jersey number has been updated.")
        cur.execute("SELECT * FROM Player WHERE Player.name='"+name+"';")
        results=cur.fetchall()
        print("\nID, Name, Birthdate, Nationality, L/R, Number")
        print(results[0])
    except Exception as error:
        print(f"Something went wrong: {error}. Please try again.")
    return
def deletePlayer():
    try:
        name=input("\nEnter the name of the player to be removed: ")
        cur.execute("DELETE FROM Player WHERE name=('"+name+"');")
        db.commit()
        print(f"\nPlayer '{name}' has been removed from the database.")
    except Exception as error:
        print(f"\nSomething went wrong: {error}. Please try again.")
        db.rollback()
    return

main()