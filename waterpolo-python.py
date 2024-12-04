import pymysql

def connect_to_database():
    '''
    Connects to the database using user's credentials and identifies the role.
    '''
    while True:
        role = input("Are you a coach or a player? ").strip().lower()
        if role not in ["coach", "player"]:
            print("Invalid role. Please enter 'coach' or 'player'.")
            continue

        username = input("Enter MySQL username: ")
        password = input("Enter MySQL password: ")

        try:
            connection = pymysql.connect(
                host='localhost',
                user=username,
                password=password,
                database='Waterpolo'
            )
            print("Connected to Database.")
            return connection, role
        except pymysql.MySQLError as e:
            print(f"Error connecting to database: {e}. Please try again.")

def coach_menu(connection):
    '''
    Displays the main menu options available to coaches.
    '''
    while True:
        print("\nCoach Menu:")
        print("1: Display teams")
        print("2: View coach insights")
        print("3: View league insights")
        print("4: Disconnect from database and close application")

        choice = input("Enter your choice: ")
        if choice == '1':
            display_teams(connection)
            team_name = input("Enter the team name you want to manage: ").strip()
            team_options_menu(connection, team_name)
        elif choice == '2':
            view_coach_insights(connection)
        elif choice == '3':
            view_league_insights(connection)
        elif choice == '4':
            print("Disconnecting from database.")
            connection.close()
            print("Application closed.")
            break
        else:
            print("Invalid choice. Please try again.")

def player_menu(connection):
    '''
    Displays the menu and options available to players.
    '''
    while True:
        print("\nPlayer Menu:")
        print("1: Display teams")
        print("2: View league insights")
        print("3: Disconnect from database and close application")

        choice = input("Enter your choice: ")
        if choice == '1':
            display_teams(connection)
            team_name = input("Enter the team name you want to view: ").strip()
            view_team_game_record(connection, team_name)
            player_view_team_roster(connection, team_name)
        elif choice == '2':
            view_league_insights(connection)
        elif choice == '3':
            print("Disconnecting from database.")
            connection.close()
            print("Application closed.")
            break
        else:
            print("Invalid choice. Please try again.")
            
def view_league_insights(connection):
    '''
    Displays league-wide insights, including total goals, assists, and saves per league.
    '''
    try:
        with connection.cursor() as cursor:
            query = """
                SELECT 
                    l.league_name,
                    SUM(s.goals_scored) AS total_goals,
                    SUM(s.assists) AS total_assists,
                    SUM(s.saves) AS total_saves
                FROM water_polo_league AS l
                LEFT JOIN game g ON l.league_name = g.league_name
                LEFT JOIN team_game tg ON g.game_ID = tg.game_ID
                LEFT JOIN team t ON tg.team_name = t.name
                LEFT JOIN team_person tp ON t.name = tp.team_name
                LEFT JOIN player p ON tp.email_address = p.email_address
                LEFT JOIN stats s ON p.player_ID = s.player_ID
                GROUP BY l.league_name
                ORDER BY total_goals DESC, total_assists DESC, total_saves DESC;
            """
            cursor.execute(query)
            insights = cursor.fetchall()

            # Display results in a clean format
            print("\nLeague Insights:")
            print(f"{'League Name':<20} {'Total Goals':<15} {'Total Assists':<15} {'Total Saves':<15}")
            print("-" * 60)
            for row in insights:
                print(f"{row[0]:<20} {row[1]:<15} {row[2]:<15} {row[3]:<15}")
    except pymysql.MySQLError as e:
        print(f"Error retrieving league insights: {e}")

def view_coach_insights(connection):
    '''
    Displays insights for coaches, including total team goals.
    '''
    try:
        with connection.cursor() as cursor:
            query = """
                SELECT 
                    coach.first_name AS coach_first_name,
                    coach.last_name AS coach_last_name,
                    t.name AS team_name,
                    SUM(s.goals_scored) AS total_team_goals
                FROM coach c
                JOIN person coach ON c.email_address = coach.email_address
                JOIN team t ON t.coach = coach.email_address
                JOIN team_person tp ON t.name = tp.team_name
                JOIN player pl ON tp.email_address = pl.email_address
                JOIN stats s ON pl.player_ID = s.player_ID
                GROUP BY coach.first_name, coach.last_name, t.name
                ORDER BY total_team_goals DESC;
            """
            cursor.execute(query)
            insights = cursor.fetchall()
            
            print("\nCoach Insights:")
            print("")
            print(f"{'Coach Name':<20} {'Team Name':<20} {'Total Team Goals':<15}")
            print("-" * 60)
            for row in insights:
                coach_name = f"{row[0]} {row[1]}"
                print(f"{coach_name:<20} {row[2]:<20} {row[3]:<15}")
    except pymysql.MySQLError as e:
        print(f"Error retrieving coach insights: {e}")

def view_team_game_insights(connection, team_name):
    '''
    Displays game insights for a specific team, including goals, assists, shot blocks, and games played.
    '''
    try:
        with connection.cursor() as cursor:
            query = """
                SELECT 
                    tg.team_name,
                    tg.role AS game_role, -- 'home' or 'away'
                    SUM(s.goals_scored) AS total_goals,
                    SUM(s.assists) AS total_assists,
                    SUM(s.shot_blocks) AS total_shot_blocks,
                    COUNT(g.game_ID) AS total_games_played
                FROM team_game tg
                JOIN game g ON tg.game_ID = g.game_ID
                JOIN team_person tp ON tg.team_name = tp.team_name
                JOIN player pl ON tp.email_address = pl.email_address
                JOIN stats s ON pl.player_ID = s.player_ID
                WHERE tg.team_name = %s
                GROUP BY tg.team_name, tg.role
                ORDER BY tg.team_name, tg.role;
            """
            cursor.execute(query, (team_name,))
            insights = cursor.fetchall()

            print(f"\nGame Insights for {team_name}:")
            print(f"{'Role':<10} {'Total Goals':<15} {'Total Assists':<15} {'Total Shot Blocks':<20} {'Games Played':<15}")
            print("-" * 75)
            for row in insights:
                print(f"{row[1]:<10} {row[2]:<15} {row[3]:<15} {row[4]:<20} {row[5]:<15}")
    except pymysql.MySQLError as e:
        print(f"Error retrieving game insights: {e}")
        
def display_teams(connection):
    '''
    Displays the list of teams.
    '''
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT name FROM team;")
            teams = cursor.fetchall()
            print("\nTeams:")
            for team in teams:
                print(f"- {team[0]}")
    except pymysql.MySQLError as e:
        print(f"Error retrieving teams: {e}")

def team_options_menu(connection, team_name):
    '''
    Displays options for a specific team.
    '''
    while True:
        print(f"\nOptions for Team: {team_name}")
        print("")
        print("1: View team game record")
        print("2: View team roster")
        print("3: View team game insights")
        print("4: Add a new player to the team")
        print("5: Remove a player from the team")
        print("6: Return to main menu")
        print("")

        choice = input("Enter your choice: ")
        if choice == '1':
            view_team_game_record(connection, team_name)
        elif choice == '2':
            coach_view_team_roster(connection, team_name)
            player_id = input("\nEnter the player ID to view or update stats, or press Enter to skip: ").strip()
            if player_id:
                view_player_stats(connection, player_id)
                update_choice = input("\nDo you want to update a stat for this player? (yes/no): ").strip().lower()
                if update_choice == 'yes':
                    update_player_stats(connection, player_id)
        elif choice == '3':
            view_team_game_insights(connection, team_name)
        elif choice == '4':
            add_player_to_team(connection, team_name)
        elif choice == '5':
            remove_player_from_team(connection, team_name)
        elif choice == '6':
            break
        else:
            print("Invalid choice. Please try again.")

def view_team_game_record(connection, team_name):
    '''
    Displays the game record of a team.
    '''
    try:
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT g.wins, g.losses, g.ties "
                "FROM game_record g "
                "JOIN game_record_team grt ON g.record_ID = grt.record_ID "
                "WHERE grt.team_name = %s;", (team_name,)
            )
            record = cursor.fetchone()
            if record:
                print(f"\nGame Record for {team_name}:")
                print(f"Wins: {record[0]}, Losses: {record[1]}, Ties: {record[2]}")
            else:
                print(f"No game record found for team {team_name}.")
    except pymysql.MySQLError as e:
        print(f"Error retrieving game record: {e}")

def player_view_team_roster(connection, team_name):
    '''
    Displays the roster for the specified team, including player number and name.
    '''
    try:
        with connection.cursor() as cursor:
            query = """
                SELECT p.number, pr.first_name, pr.last_name
                FROM player p
                INNER JOIN person pr ON p.email_address = pr.email_address
                INNER JOIN team_person tp ON tp.email_address = pr.email_address
                WHERE tp.team_name = %s;
            """
            cursor.execute(query, (team_name,))
            roster = cursor.fetchall()
            if roster:
                print(f"\nRoster for {team_name}:")
                print("")
                print(f"{'Number':<10} {'Name':<25}")
                print("-" * 30)
                for player in roster:
                    player_name = f"{player[1]} {player[2]}"
                    print(f"{player[0]:<10} {player_name:<25}")
            else:
                print(f"No roster information found for {team_name}.")
    except pymysql.MySQLError as e:
        print(f"Error retrieving roster: {e}")

def coach_view_team_roster(connection, team_name):
    '''
    Displays the roster for the specified team, including player IDs.
    '''
    try:
        with connection.cursor() as cursor:
            query = """
                SELECT p.player_ID, p.number, pr.first_name, pr.last_name
                FROM player p
                INNER JOIN person pr ON p.email_address = pr.email_address
                INNER JOIN team_person tp ON tp.email_address = pr.email_address
                WHERE tp.team_name = %s;
            """
            cursor.execute(query, (team_name,))
            roster = cursor.fetchall()
            if roster:
                print(f"\nRoster for {team_name}:")
                print(f"{'Player ID':<10} {'Number':<10} {'Name':<20}")
                print("-" * 40)
                for player in roster:
                    print(f"{player[0]:<10} {player[1]:<10} {player[2]} {player[3]}")
            else:
                print(f"No roster information found for {team_name}.")
    except pymysql.MySQLError as e:
        print(f"Error retrieving roster: {e}")

def add_player_to_team(connection, team_name):
    '''
    Adds a new player to the specified team roster.
    '''
    try:
        with connection.cursor() as cursor:
            print("\nAdding a new player to the team.")

            # Get player information
            email_address = input("Enter the player's email address: ").strip()
            first_name = input("Enter the player's first name: ").strip()
            last_name = input("Enter the player's last name: ").strip()
            cap_number = input("Enter the player's cap number: ").strip()
            username = input("Create a username for the player: ").strip()
            password = input("Create a password for the player: ").strip()

            # Display positions in a neat format
            positions = (
                (1, "Center Forward"),
                (2, "Center Defender"),
                (3, "Left Wing"),
                (4, "Right Wing"),
                (5, "Driver"),
                (6, "Point"),
                (7, "Goalkeeper")
            )
            print("\nAvailable Positions:")
            for position in positions:
                print(f"{position[0]}: {position[1]}")

            # Prompt user to assign a position ID
            position_id = input("Assign position ID for the player from the above options: ").strip()
            player_id = input("Assign player ID for the player: ").strip()


            # Insert data into person table
            person_query = """
                INSERT INTO person (email_address, first_name, last_name, username, password)
                VALUES (%s, %s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE
                first_name = VALUES(first_name), last_name = VALUES(last_name);
            """
            cursor.execute(person_query, (email_address, first_name, last_name, username, password))

            # Insert data into player table
            player_query = """
                INSERT INTO player (email_address, number, player_ID, position_ID)
                VALUES (%s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE
                number = VALUES(number), position_ID = VALUES(position_ID);
            """
            cursor.execute(player_query, (email_address, cap_number, player_id, position_id))

            # Link player to the team
            team_person_query = """
                INSERT INTO team_person (email_address, team_name)
                VALUES (%s, %s);
            """
            cursor.execute(team_person_query, (email_address, team_name))

            connection.commit()
            print(f"Player {first_name} {last_name} successfully added to {team_name}.")
    except pymysql.MySQLError as e:
        print(f"Error adding player: {e}")

def remove_player_from_team(connection, team_name):
    '''
    Removes a player from the specified team.
    '''
    try:
        with connection.cursor() as cursor:
            print("\nRemoving a player from the team.")

            # Display the team roster
            coach_view_team_roster(connection, team_name)

            # Select player to remove
            player_id = input("Enter the Player ID of the player to remove: ").strip()

            # Validate the player exists
            cursor.execute("SELECT email_address FROM player WHERE player_ID = %s;", (player_id,))
            result = cursor.fetchone()
            if not result:
                print(f"No player found with ID {player_id}.")
                return
            email_address = result[0]

            # Remove player stats
            cursor.execute("DELETE FROM stats WHERE player_ID = %s;", (player_id,))

            # Remove player from team_person
            cursor.execute("""
                DELETE FROM team_person 
                WHERE email_address = %s
                AND team_name = %s;
            """, (email_address, team_name))

            # Remove the player record
            cursor.execute("DELETE FROM player WHERE player_ID = %s;", (player_id,))

            # Remove the person record
            cursor.execute("DELETE FROM person WHERE email_address = %s;", (email_address,))

            # Commit all changes
            connection.commit()
            print(f"Player with ID {player_id} removed from {team_name}.")
    except pymysql.MySQLError as e:
        print(f"Error removing player: {e}")
        
def view_player_stats(connection, player_id):
    '''
    Displays stats for a specific player by player ID.
    '''
    try:
        with connection.cursor() as cursor:
            query = """
                SELECT games_played, goals_scored, assists, steals, 
                       earned_ejections, ejections, shot_blocks, saves
                FROM stats
                WHERE player_ID = %s;
            """
            cursor.execute(query, (player_id,))
            stats = cursor.fetchone()
            if stats:
                print(f"\nPlayer ID: {player_id}")
                print(f"Games Played: {stats[0]}, Goals Scored: {stats[1]}, Assists: {stats[2]}")
                print(f"Steals: {stats[3]}, Earned Ejections: {stats[4]}")
                print(f"Ejections: {stats[5]}, Shot Blocks: {stats[6]}, Saves: {stats[7]}")
            else:
                print("No stats found for the selected player.")
    except pymysql.MySQLError as e:
        print(f"Error fetching player stats: {e}")

def update_player_stats(connection, player_id):
    '''
    Allows the coach to update a single stat for a specific player.
    '''
    try:
        with connection.cursor() as cursor:
            # Display list of valid stats for clarity
            valid_stats = [
                "games_played", "goals_scored", "assists", "steals", 
                "earned_ejections", "ejections", "shot_blocks", "saves"
            ]
            print("\nAvailable stats to update:")
            for stat in valid_stats:
                print(f"- {stat}")

            # Prompt for stat selection
            stat = input("\nEnter the stat to update (e.g., 'goals_scored'): ").strip()
            if stat not in valid_stats:
                print("Invalid stat name. Please try again.")
                return

            # Prompt for the new value
            try:
                value = int(input(f"Enter the new value for {stat}: ").strip())
            except ValueError:
                print("Invalid input. The value must be a number.")
                return

            # Update the selected stat
            query = f"UPDATE stats SET {stat} = %s WHERE player_ID = %s;"
            cursor.execute(query, (value, player_id))
            connection.commit()
            print(f"Successfully updated {stat} for Player ID {player_id} to {value}.")
    except pymysql.MySQLError as e:
        print(f"Error updating player stats: {e}")

def main():
    try:
        connection, role = connect_to_database()

        if role == "player":
            player_menu(connection)
        elif role == "coach":
            coach_menu(connection)
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    main()
