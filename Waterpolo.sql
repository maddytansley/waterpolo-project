DROP DATABASE IF EXISTS Waterpolo;
CREATE DATABASE Waterpolo;
USE Waterpolo;

DROP TABLE IF EXISTS water_polo_league;
CREATE TABLE water_polo_league (
	league_name VARCHAR(50) PRIMARY KEY NOT NULL
);

DROP TABLE IF EXISTS game;
CREATE TABLE game (
	game_ID INT PRIMARY KEY NOT NULL,
    league_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (league_name) REFERENCES water_polo_league(league_name)
);

DROP TABLE IF EXISTS person;
CREATE TABLE person (
	first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email_address VARCHAR(50) PRIMARY KEY NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULl
);

DROP TABLE IF EXISTS team;
CREATE TABLE team (
	name VARCHAR(50) PRIMARY KEY NOT NULL,
    roster VARCHAR(50) NOT NULL,
    captain VARCHAR(50) NOT NULL,
    coach VARCHAR(50) NOT NULL,
    FOREIGN KEY (captain) REFERENCES person(email_address),
    FOREIGN KEY (coach) REFERENCES person(email_address)
);

-- junction table
DROP TABLE IF EXISTS team_game;
CREATE TABLE team_game (
    team_name VARCHAR(50) NOT NULL,
    game_ID INT NOT NULL,
    role ENUM('home', 'away') NOT NULL,
    PRIMARY KEY (team_name , game_ID),
    FOREIGN KEY (team_name)
        REFERENCES team (name),
    FOREIGN KEY (game_ID)
        REFERENCES game (game_ID)
);

DROP TABLE IF EXISTS game_record;
CREATE TABLE game_record (
	record_ID INT PRIMARY KEY NOT NULL,
	wins INT NOT NULL, 
    losses INT NOT NULL,
    ties INT NOT NULL
);

-- junction table
DROP TABLE IF EXISTS game_record_team;
CREATE TABLE game_record_team (
    record_ID INT NOT NULL,
    team_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (record_ID, team_name),
    FOREIGN KEY (record_ID) REFERENCES game_record(record_ID),
    FOREIGN KEY (team_name) REFERENCES team(name)
);

-- junction table
DROP TABLE IF EXISTS team_person;
CREATE TABLE team_person (
    team_name VARCHAR(50) NOT NULL,
    email_address VARCHAR(50) PRIMARY KEY NOT NULL,
    FOREIGN KEY (team_name) REFERENCES team(name),
    FOREIGN KEY (email_address) REFERENCES person(email_address)
);

DROP TABLE IF EXISTS coach;
CREATE TABLE coach (
    experience INT NOT NULL,
    salary INT NOT NULL,
    email_address VARCHAR(50) NOT NULL,  -- do we need this to connect each coach and player to the "person" or no
    FOREIGN KEY (email_address) REFERENCES person(email_address)
);

-- "pos" = position
DROP TABLE IF EXISTS pos;
CREATE TABLE pos (
	ID INT PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS player;
CREATE TABLE player (
	player_ID INT UNIQUE NOT NULL,
    position_ID INT NOT NULL,
    number INT NOT NULL,
    email_address VARCHAR(50) NOT NULL,
    FOREIGN KEY (email_address) REFERENCES person(email_address),
    FOREIGN KEY (position_ID) REFERENCES pos(ID)
);

DROP TABLE IF EXISTS stats;
CREATE TABLE stats (
	player_ID INT PRIMARY KEY NOT NULL,
	games_played INT NOT NULL,
    goals_scored INT NOT NULL,
    assists INT NOT NULL,
    steals INT NOT NULL,
    earned_ejections INT NOT NULL,
    ejections INT NOT NULL,
    shot_blocks INT NOT NULL,
    saves INT NOT NULL,
    FOREIGN KEY (player_ID) REFERENCES player(player_ID)
);


-- INSERT DATA INTO TABLES
INSERT INTO water_polo_league (league_name) VALUES
('New York League'),
('California League');

INSERT INTO game (game_ID, league_name, location, date) VALUES
(001, 'New York League', 'Long Island', '2024-11-15'),
(002, 'New York League', 'Queens', '2024-11-16'),
(003, 'New York League', 'Brooklyn', '2024-11-23'),
(004, 'New York League', 'Upper East Side', '2024-11-27'),
(005, 'New York League', 'Soho', '2024-11-29'),
(006, 'New York League', 'Staten Island', '2024-12-01'),
(007, 'California League', 'San Diego', '2024-11-16'),
(008, 'California League', 'San Francisco', '2024-11-20'),
(009, 'California League', 'Anaheim', '2024-11-29'),
(010, 'California League', 'Calabasis', '2024-11-30'),
(011, 'California League', 'Los Angeles', '2024-12-03'),
(012, 'California League', 'Venice', '2024-12-05');

INSERT INTO person (first_name, last_name, email_address, username, password) VALUES
# team 1 (suits)
('Harry', 'Styles', 'harry.styles@gmail.com', 'hstyles', 'coach123'),
('Harvey', 'Specter', 'harvey.specter@gmail.com', 'hspecter', 'cap123'),
('Mike', 'Ross', 'mike.ross@gmail.com', 'mross', 'play123'),
('Rachel', 'Zane', 'rachel.zane@gmail.com', 'rzane', 'play123'),
('Louis', 'Litt', 'louis.litt@gmail.com', 'llitt', 'play123'),
('Donna', 'Paulsen', 'donna.paulsen@gmail.com', 'dpaulsen', 'play123'),
('Jessica', 'Pearson', 'jessica.pearson@gmail.com', 'jpearson', 'play123'),
('Katrina', 'Bennett', 'katrina.bennett@gmail.com', 'kbennett', 'play123'),
('Alex', 'Williams', 'alex.williams@gmail.com', 'awilliams', 'play123'),
('Samantha', 'Wheeler', 'samantha.wheeler@gmail.com', 'swheeler', 'play123'),
('Sean', 'Cahill', 'sean.cahill@gmail.com', 'scahill', 'play123'),
('Dana', 'Scott', 'dana.scott@gmail.com', 'dscott', 'play123'),

# team 2 (the office)
('Niall', 'Horan', 'niall.horan@gmail.com', 'nhoran', 'coach123'),
('Michael', 'Scott', 'michael.scott@gmail.com', 'mscott', 'cap123'),
('Jim', 'Halpert', 'jim.halpert@gmail.com', 'jhalpert', 'play123'),
('Pam', 'Beesly', 'pam.beesly@gmail.com', 'pbeesly', 'play123'),
('Dwight', 'Schrute', 'dwight.schrute@gmail.com', 'dschrute', 'play123'),
('Angela', 'Martin', 'angela.martin@gmail.com', 'amartin', 'play123'),
('Andy', 'Bernard', 'andy.bernard@gmail.com', 'abernard', 'play123'),
('Kevin', 'Malone', 'kevin.malone@gmail.com', 'kmalone', 'play123'),
('Stanley', 'Hudson', 'stanley.hudson@gmail.com', 'shudson', 'play123'),
('Phyllis', 'Lapin-Vance', 'phyllis.lapinvance@gmail.com', 'plapinvance', 'play123'),
('Darryl', 'Philbin', 'darryl.philbin@gmail.com', 'dphilbin', 'play123'),
('Oscar', 'Martinez', 'oscar.martinez@gmail.com', 'omartinez', 'play123'),

# team 3 (new girl)
('Gracie', 'Abrams', 'gracie.abrams@gmail.com', 'gabrams', 'coach123'),
('Jess', 'Day', 'jess.day@gmail.com', 'jday', 'cap123'),
('Nick', 'Miller', 'nick.miller@gmail.com', 'nmiller', 'play123'),
('Winston', 'Schmidt', 'schmidt.cohen@gmail.com', 'schmidt', 'play123'),
('Winston', 'Bishop', 'winston.bishop@gmail.com', 'wbishop', 'play123'),
('Cece', 'Parekh', 'cece.parekh@gmail.com', 'cparekh', 'play123'),
('Aly', 'Nelson', 'aly.nelson@gmail.com', 'anelson', 'play123'),
('Fawn', 'Moscato', 'fawn.moscato@gmail.com', 'fmoscato', 'play123'),
('Sam', 'Sweeney', 'sam.sweeney@gmail.com', 'ssweeney', 'play123'),
('Abby', 'Day', 'abby.day@gmail.com', 'aday', 'play123'),
('Paul', 'Genzlinger', 'paul.genzlinger@gmail.com', 'pgenzlinger', 'play123'),
('Ryan', 'Geauxinue', 'ryan.geauxinue@gmail.com', 'rgeauxinue', 'play123'),

# team 4 (outer banks)
('Role', 'Model', 'role.model@gmail.com', 'rmodel', 'coach123'),
('John', 'Routledge', 'john.routledge@gmail.com', 'jroutledge', 'cap123'),
('Sarah', 'Cameron', 'sarah.cameron@gmail.com', 'scameron', 'play123'),
('Kiara', 'Carerra', 'kiara.carerra@gmail.com', 'kcarerra', 'play123'),
('Pope', 'Heyward', 'pope.heyward@gmail.com', 'pheyward', 'play123'),
('JJ', 'Maybank', 'jj.maybank@gmail.com', 'jmaybank', 'play123'),
('Rafe', 'Cameron', 'rafe.cameron@gmail.com', 'rcameron', 'play123'),
('Topper', 'Thornton', 'topper.thornton@gmail.com', 'tthornton', 'play123'),
('Ward', 'Cameron', 'ward.cameron@gmail.com', 'wcameron', 'play123'),
('Wheezie', 'Cameron', 'wheezie.cameron@gmail.com', 'whcameron', 'play123'),
('Carlos', 'Singh', 'carlos.singh@gmail.com', 'csingh', 'play123'),
('Mike', 'Carerra', 'mike.carerra@gmail.com', 'mcarerra', 'play123'),

# team 5 (nhl)
('Noah', 'Kahan', 'noah.kahan@gmail.com', 'nkahan', 'coach123'),
('Quinn', 'Hughes', 'quinn.hughes@gmail.com', 'qhughes', 'cap123'),
('Jeremy', 'Swayman', 'jeremy.swayman@gmail.com', 'jswayman', 'play123'),
('Sidney', 'Crosby', 'sidney.crosby@gmail.com', 'scrosby', 'play123'),
('Connor', 'McDavid', 'connor.mcdavid@gmail.com', 'cmcdavid', 'play123'),
('Alex', 'Ovechkin', 'alex.ovechkin@gmail.com', 'aovechkin', 'play123'),
('Nathan', 'MacKinnon', 'nathan.mackinnon@gmail.com', 'nmackinnon', 'play123'),
('Leon', 'Draisaitl', 'leon.draisaitl@gmail.com', 'ldraisaitl', 'play123'),
('Patrick', 'Kane', 'patrick.kane@gmail.com', 'pkane', 'play123'),
('Mitch', 'Marner', 'mitch.marner@gmail.com', 'mmarner', 'play123'),
('Jack', 'Hughes', 'jack.hughes@gmail.com', 'jhughes', 'play123'),
('Trevor', 'Zegras', 'trevor.zegras@gmail.com', 'tzegras', 'play123'),

# team 6 (disney channel)
('Sabrina', 'Carpenter', 'sabrina.carpenter@gmail.com', 'scarpenter', 'coach123'),
('Miley', 'Stewart', 'miley.stewart@gmail.com', 'mstewart', 'cap123'),
('Raven', 'Baxter', 'raven.baxter@gmail.com', 'rbaxter', 'play123'),
('Lizzie', 'McGuire', 'lizzie.mcguire@gmail.com', 'lmcguire', 'play123'),
('Zack', 'Martin', 'zack.martin@gmail.com', 'zmartin', 'play123'),
('Cody', 'Martin', 'cody.martin@gmail.com', 'cmartin', 'play123'),
('Alex', 'Russo', 'alex.russo@gmail.com', 'arusso', 'play123'),
('Troy', 'Bolton', 'troy.bolton@gmail.com', 'tbolton', 'play123'),
('Gabriella', 'Montez', 'gabriella.montez@gmail.com', 'gmontez', 'play123'),
('London', 'Tipton', 'london.tipton@gmail.com', 'ltipton', 'play123'),
('Phineas', 'Flynn', 'phineas.flynn@gmail.com', 'pflynn', 'play123'),
('Olivia', 'Rodrigo', 'olivia.rodrigo@gmail.com', 'orodrigo', 'play123'),

# team 7 (internet)
('Dominic', 'Fike', 'dominic.fike@gmail.com', 'dfike', 'coach123'),
('Trisha', 'Paytas', 'trisha.paytas@gmail.com', 'tpaytas', 'cap123'),
('Addison', 'Rae', 'addison.rae@gmail.com', 'arae', 'play123'),
('Charli', 'DAmelio', 'charli.damelio@gmail.com', 'cdamelio', 'play123'),
('Dixie', 'DAmelio', 'dixie.damelio@gmail.com', 'ddamelio', 'play123'),
('Emma', 'Chamberlain', 'emma.chamberlain@gmail.com', 'echamberlain', 'play123'),
('James', 'Charles', 'james.charles@gmail.com', 'jcharles', 'play123'),
('Jake', 'Shane', 'jake.shane@gmail.com', 'jshane', 'play123'),
('Logan', 'Paul', 'logan.paul@gmail.com', 'lpaul', 'play123'),
('Jake', 'Paul', 'jake.paul@gmail.com', 'jpaul', 'play123'),
('Josh', 'Richards', 'josh.richards@gmail.com', 'jrichards', 'play123'),
('Bryce', 'Hall', 'bryce.hall@gmail.com', 'bhall', 'play123'),

# team 8 (gilmore girls)
('Charli', 'XCX', 'charli.xcx@gmail.com', 'cxcx', 'coach123'),
('Lorelai', 'Gilmore', 'lorelai.gilmore@gmail.com', 'lgilmore', 'cap123'),
('Rory', 'Gilmore', 'rory.gilmore@gmail.com', 'rgilmore', 'play123'),
('Luke', 'Danes', 'luke.danes@gmail.com', 'ldanes', 'play123'),
('Emily', 'Gilmore', 'emily.gilmore@gmail.com', 'egilmore', 'play123'),
('Tristan', 'Dugray', 'tristan.dugray@gmail.com', 'tdugray', 'play123'),
('Paris', 'Geller', 'paris.geller@gmail.com', 'pgeller', 'play123'),
('Lane', 'Kim', 'lane.kim@gmail.com', 'lkim', 'play123'),
('Jess', 'Mariano', 'jess.mariano@gmail.com', 'jmariano', 'play123'),
('Sookie', 'St. James', 'sookie.stjames@gmail.com', 'sstjames', 'play123'),
('Logan', 'Huntzberger', 'logan.huntzberger@gmail.com', 'lhuntzberger', 'play123'),
('Dean', 'Forester', 'dean.forester@gmail.com', 'dforester', 'play123');


INSERT INTO team (name, roster, captain, coach) VALUES
('Suits', 'Roster A', 'harvey.specter@gmail.com', 'harry.styles@gmail.com'),
('The Office', 'Roster B', 'michael.scott@gmail.com', 'niall.horan@gmail.com'),
('New Girl', 'Roster A', 'jess.day@gmail.com', 'gracie.abrams@gmail.com'),
('Outer Banks', 'Roster B', 'john.routledge@gmail.com', 'role.model@gmail.com'),
('NHL', 'Roster A', 'quinn.hughes@gmail.com', 'noah.kahan@gmail.com'),
('Disney Channel', 'Roster B', 'miley.stewart@gmail.com', 'sabrina.carpenter@gmail.com'),
('Internet', 'Roster A', 'trisha.paytas@gmail.com', 'dominic.fike@gmail.com'),
('Gilmore Girls', 'Roster B', 'lorelai.gilmore@gmail.com', 'charli.xcx@gmail.com');


INSERT INTO game_record (record_ID, wins, losses, ties) VALUES
(1, 3, 2, 1),
(2, 1, 5, 0),
(3, 5, 0, 1),
(4, 2, 4, 0),
(5, 6, 1, 0),
(6, 0, 7, 0),
(7, 3, 3, 1),
(8, 4, 2, 0);

INSERT INTO game_record_team (record_ID, team_name) VALUES
(1, 'Suits'),
(2, 'The Office'),
(3, 'New Girl'),
(4, 'Outer Banks'),
(5, 'NHL'),
(6, 'Disney Channel'),
(7, 'Internet'),
(8, 'Gilmore Girls');

INSERT INTO team_person (team_name, email_address) VALUES
('Suits', 'harvey.specter@gmail.com'),
('Suits', 'mike.ross@gmail.com'),
('Suits', 'rachel.zane@gmail.com'),
('Suits', 'louis.litt@gmail.com'),
('Suits', 'donna.paulsen@gmail.com'),
('Suits', 'jessica.pearson@gmail.com'),
('Suits', 'katrina.bennett@gmail.com'),
('Suits', 'alex.williams@gmail.com'),
('Suits', 'samantha.wheeler@gmail.com'),
('Suits', 'sean.cahill@gmail.com'),
('Suits', 'dana.scott@gmail.com'),
('The Office', 'michael.scott@gmail.com'),
('The Office', 'jim.halpert@gmail.com'),
('The Office', 'pam.beesly@gmail.com'),
('The Office', 'dwight.schrute@gmail.com'),
('The Office', 'angela.martin@gmail.com'),
('The Office', 'andy.bernard@gmail.com'),
('The Office', 'kevin.malone@gmail.com'),
('The Office', 'stanley.hudson@gmail.com'),
('The Office', 'phyllis.lapinvance@gmail.com'),
('The Office', 'darryl.philbin@gmail.com'),
('The Office', 'oscar.martinez@gmail.com'),
('New Girl', 'jess.day@gmail.com'),
('New Girl', 'nick.miller@gmail.com'),
('New Girl', 'schmidt.cohen@gmail.com'),
('New Girl', 'winston.bishop@gmail.com'),
('New Girl', 'cece.parekh@gmail.com'),
('New Girl', 'aly.nelson@gmail.com'),
('New Girl', 'fawn.moscato@gmail.com'),
('New Girl', 'sam.sweeney@gmail.com'),
('New Girl', 'abby.day@gmail.com'),
('New Girl', 'paul.genzlinger@gmail.com'),
('New Girl', 'ryan.geauxinue@gmail.com'),
('Outer Banks', 'john.routledge@gmail.com'),
('Outer Banks', 'sarah.cameron@gmail.com'),
('Outer Banks', 'kiara.carerra@gmail.com'),
('Outer Banks', 'pope.heyward@gmail.com'),
('Outer Banks', 'jj.maybank@gmail.com'),
('Outer Banks', 'rafe.cameron@gmail.com'),
('Outer Banks', 'topper.thornton@gmail.com'),
('Outer Banks', 'ward.cameron@gmail.com'),
('Outer Banks', 'wheezie.cameron@gmail.com'),
('Outer Banks', 'carlos.singh@gmail.com'),
('Outer Banks', 'mike.carerra@gmail.com'),
('NHL', 'quinn.hughes@gmail.com'),
('NHL', 'jeremy.swayman@gmail.com'),
('NHL', 'sidney.crosby@gmail.com'),
('NHL', 'connor.mcdavid@gmail.com'),
('NHL', 'alex.ovechkin@gmail.com'),
('NHL', 'nathan.mackinnon@gmail.com'),
('NHL', 'leon.draisaitl@gmail.com'),
('NHL', 'patrick.kane@gmail.com'),
('NHL', 'mitch.marner@gmail.com'),
('NHL', 'jack.hughes@gmail.com'),
('NHL', 'trevor.zegras@gmail.com'),
('Disney Channel', 'miley.stewart@gmail.com'),
('Disney Channel', 'raven.baxter@gmail.com'),
('Disney Channel', 'lizzie.mcguire@gmail.com'),
('Disney Channel', 'zack.martin@gmail.com'),
('Disney Channel', 'cody.martin@gmail.com'),
('Disney Channel', 'alex.russo@gmail.com'),
('Disney Channel', 'troy.bolton@gmail.com'),
('Disney Channel', 'gabriella.montez@gmail.com'),
('Disney Channel', 'london.tipton@gmail.com'),
('Disney Channel', 'phineas.flynn@gmail.com'),
('Disney Channel', 'olivia.rodrigo@gmail.com'),
('Internet', 'trisha.paytas@gmail.com'),
('Internet', 'addison.rae@gmail.com'),
('Internet', 'charli.damelio@gmail.com'),
('Internet', 'dixie.damelio@gmail.com'),
('Internet', 'emma.chamberlain@gmail.com'),
('Internet', 'james.charles@gmail.com'),
('Internet', 'jake.shane@gmail.com'),
('Internet', 'logan.paul@gmail.com'),
('Internet', 'jake.paul@gmail.com'),
('Internet', 'josh.richards@gmail.com'),
('Internet', 'bryce.hall@gmail.com'),
('Gilmore Girls', 'lorelai.gilmore@gmail.com'),
('Gilmore Girls', 'rory.gilmore@gmail.com'),
('Gilmore Girls', 'luke.danes@gmail.com'),
('Gilmore Girls', 'emily.gilmore@gmail.com'),
('Gilmore Girls', 'tristan.dugray@gmail.com'),
('Gilmore Girls', 'paris.geller@gmail.com'),
('Gilmore Girls', 'lane.kim@gmail.com'),
('Gilmore Girls', 'jess.mariano@gmail.com'),
('Gilmore Girls', 'sookie.stjames@gmail.com'),
('Gilmore Girls', 'logan.huntzberger@gmail.com'),
('Gilmore Girls', 'dean.forester@gmail.com'),
('Suits', 'harry.styles@gmail.com'),
('The Office', 'niall.horan@gmail.com'),
('New Girl', 'gracie.abrams@gmail.com'),
('Outer Banks', 'role.model@gmail.com'),
('NHL', 'noah.kahan@gmail.com'),
('Disney Channel', 'sabrina.carpenter@gmail.com'),
('Internet', 'dominic.fike@gmail.com'),
('Gilmore Girls', 'charli.xcx@gmail.com');

INSERT INTO coach (experience, salary, email_address) VALUES
(15, 95000, 'harry.styles@gmail.com'),
(12, 85000, 'niall.horan@gmail.com'),
(10, 80000, 'gracie.abrams@gmail.com'),
(14, 90000, 'role.model@gmail.com'),
(16, 100000, 'noah.kahan@gmail.com'),
(9, 78000, 'sabrina.carpenter@gmail.com'),
(11, 82000, 'dominic.fike@gmail.com'),
(13, 87000, 'charli.xcx@gmail.com');

INSERT INTO pos (ID, name) VALUES
(1, 'Center Forward'),
(2, 'Center Defender'),
(3, 'Left Wing'),
(4, 'Right Wing'),
(5, 'Driver'),
(6, 'Point'),
(7, 'Goalkeeper');

INSERT INTO player (player_ID, position_ID, number, email_address) VALUES
(101, 1, 43, 'harvey.specter@gmail.com'),
(102, 2, 1, 'mike.ross@gmail.com'),
(103, 3, 10, 'rachel.zane@gmail.com'),
(104, 4, 12, 'louis.litt@gmail.com'),
(105, 5, 21, 'donna.paulsen@gmail.com'),
(106, 6, 9, 'jessica.pearson@gmail.com'),
(107, 7, 15, 'katrina.bennett@gmail.com'),
(108, 4, 14, 'alex.williams@gmail.com'),
(109, 5, 8, 'samantha.wheeler@gmail.com'),
(110, 3, 23, 'sean.cahill@gmail.com'),
(111, 2, 7, 'dana.scott@gmail.com'),
(112, 1, 44, 'michael.scott@gmail.com'),
(113, 2, 2, 'jim.halpert@gmail.com'),
(114, 3, 11, 'pam.beesly@gmail.com'),
(115, 4, 13, 'dwight.schrute@gmail.com'),
(116, 5, 16, 'angela.martin@gmail.com'),
(117, 6, 6, 'andy.bernard@gmail.com'),
(118, 7, 17, 'kevin.malone@gmail.com'),
(119, 3, 18, 'stanley.hudson@gmail.com'),
(120, 4, 19, 'phyllis.lapinvance@gmail.com'),
(121, 5, 20, 'darryl.philbin@gmail.com'),
(122, 1, 22, 'oscar.martinez@gmail.com'),
(123, 2, 3, 'jess.day@gmail.com'),
(124, 3, 14, 'nick.miller@gmail.com'),
(125, 4, 24, 'schmidt.cohen@gmail.com'),
(126, 5, 25, 'winston.bishop@gmail.com'),
(127, 6, 26, 'cece.parekh@gmail.com'),
(128, 7, 27, 'aly.nelson@gmail.com'),
(129, 3, 28, 'fawn.moscato@gmail.com'),
(130, 4, 29, 'sam.sweeney@gmail.com'),
(131, 5, 30, 'abby.day@gmail.com'),
(132, 6, 31, 'paul.genzlinger@gmail.com'),
(133, 7, 32, 'ryan.geauxinue@gmail.com'),
(134, 1, 34, 'john.routledge@gmail.com'),
(135, 2, 35, 'sarah.cameron@gmail.com'),
(136, 3, 36, 'kiara.carerra@gmail.com'),
(137, 4, 37, 'pope.heyward@gmail.com'),
(138, 5, 38, 'jj.maybank@gmail.com'),
(139, 6, 39, 'rafe.cameron@gmail.com'),
(140, 7, 40, 'topper.thornton@gmail.com'),
(141, 3, 41, 'ward.cameron@gmail.com'),
(142, 4, 42, 'wheezie.cameron@gmail.com'),
(143, 5, 43, 'carlos.singh@gmail.com'),
(144, 6, 44, 'mike.carerra@gmail.com'),
(145, 1, 45, 'quinn.hughes@gmail.com'),
(146, 2, 46, 'jeremy.swayman@gmail.com'),
(147, 3, 47, 'sidney.crosby@gmail.com'),
(148, 4, 48, 'connor.mcdavid@gmail.com'),
(149, 5, 49, 'alex.ovechkin@gmail.com'),
(150, 6, 50, 'nathan.mackinnon@gmail.com'),
(151, 7, 51, 'leon.draisaitl@gmail.com'),
(152, 3, 52, 'patrick.kane@gmail.com'),
(153, 4, 53, 'mitch.marner@gmail.com'),
(154, 5, 54, 'jack.hughes@gmail.com'),
(155, 6, 55, 'trevor.zegras@gmail.com'),
(156, 1, 56, 'miley.stewart@gmail.com'),
(157, 2, 57, 'raven.baxter@gmail.com'),
(158, 3, 58, 'lizzie.mcguire@gmail.com'),
(159, 4, 59, 'zack.martin@gmail.com'),
(160, 5, 60, 'cody.martin@gmail.com'),
(161, 6, 61, 'alex.russo@gmail.com'),
(162, 7, 62, 'troy.bolton@gmail.com'),
(163, 3, 63, 'gabriella.montez@gmail.com'),
(164, 4, 64, 'london.tipton@gmail.com'),
(165, 5, 65, 'phineas.flynn@gmail.com'),
(166, 6, 66, 'olivia.rodrigo@gmail.com'),
(167, 1, 67, 'trisha.paytas@gmail.com'),
(168, 2, 68, 'addison.rae@gmail.com'),
(169, 3, 69, 'charli.damelio@gmail.com'),
(170, 4, 70, 'dixie.damelio@gmail.com'),
(171, 5, 71, 'emma.chamberlain@gmail.com'),
(172, 6, 72, 'james.charles@gmail.com'),
(173, 7, 73, 'jake.shane@gmail.com'),
(174, 3, 74, 'logan.paul@gmail.com'),
(175, 4, 75, 'jake.paul@gmail.com'),
(176, 5, 76, 'josh.richards@gmail.com'),
(177, 6, 77, 'bryce.hall@gmail.com'),
(178, 1, 78, 'lorelai.gilmore@gmail.com'),
(179, 2, 79, 'rory.gilmore@gmail.com'),
(180, 3, 80, 'luke.danes@gmail.com'),
(181, 4, 81, 'emily.gilmore@gmail.com'),
(182, 5, 82, 'tristan.dugray@gmail.com'),
(183, 6, 83, 'paris.geller@gmail.com'),
(184, 7, 84, 'lane.kim@gmail.com'),
(185, 3, 85, 'jess.mariano@gmail.com'),
(186, 4, 86, 'sookie.stjames@gmail.com'),
(187, 5, 87, 'logan.huntzberger@gmail.com'),
(188, 6, 88, 'dean.forester@gmail.com');

INSERT INTO stats (player_ID, games_played, goals_scored, assists, steals, earned_ejections, ejections, shot_blocks, saves) VALUES
(101, 6, 2, 6, 3, 2, 0, 1, 0),
(102, 6, 0, 3, 2, 1, 0, 0, 50),
(103, 6, 12, 3, 5, 3, 8, 0, 0),
(104, 6, 5, 8, 4, 1, 1, 0, 0),
(105, 5, 9, 7, 6, 2, 3, 0, 0),
(106, 5, 11, 6, 8, 4, 2, 1, 0),
(107, 6, 4, 9, 3, 3, 1, 0, 0),
(108, 6, 6, 4, 5, 2, 0, 2, 0),
(109, 6, 8, 5, 6, 1, 1, 1, 0),
(110, 5, 10, 3, 7, 2, 2, 0, 0),
(111, 5, 0, 6, 2, 1, 0, 0, 40),
(112, 5, 1, 8, 4, 3, 1, 0, 0),
(113, 6, 3, 6, 3, 1, 0, 0, 35),
(114, 5, 7, 9, 5, 2, 1, 0, 0),
(115, 6, 8, 4, 6, 2, 2, 0, 0),
(116, 5, 5, 5, 4, 1, 1, 0, 0),
(117, 6, 2, 7, 3, 3, 1, 0, 0),
(118, 5, 0, 6, 2, 1, 0, 0, 45),
(119, 6, 9, 3, 8, 3, 2, 0, 0),
(120, 5, 6, 6, 4, 2, 1, 0, 0),
(121, 6, 7, 4, 5, 2, 1, 1, 0),
(122, 5, 1, 8, 3, 2, 0, 0, 0),
(123, 6, 3, 7, 4, 2, 0, 0, 40),
(124, 5, 5, 9, 3, 1, 1, 0, 0),
(125, 6, 8, 5, 6, 3, 1, 0, 0),
(126, 6, 10, 4, 8, 3, 2, 1, 0),
(127, 5, 6, 6, 4, 1, 1, 0, 0),
(128, 6, 0, 5, 3, 2, 0, 0, 30),
(129, 5, 4, 7, 2, 1, 1, 0, 0),
(130, 5, 5, 8, 3, 2, 1, 0, 0),
(131, 6, 7, 3, 5, 1, 0, 1, 0),
(132, 5, 11, 2, 9, 4, 2, 1, 0),
(133, 6, 0, 6, 2, 1, 0, 0, 60),
(134, 5, 9, 5, 6, 3, 2, 1, 0),
(135, 6, 4, 8, 3, 1, 1, 0, 0),
(136, 5, 7, 6, 4, 2, 1, 0, 0),
(137, 6, 10, 4, 5, 3, 1, 1, 0),
(138, 6, 3, 8, 3, 1, 1, 0, 0),
(139, 5, 6, 5, 4, 2, 1, 0, 0),
(140, 6, 0, 5, 2, 1, 0, 0, 55),
(141, 5, 8, 4, 6, 3, 1, 1, 0),
(142, 5, 4, 6, 3, 1, 0, 0, 0),
(143, 6, 7, 5, 6, 2, 2, 0, 0),
(144, 5, 3, 7, 4, 1, 1, 0, 0),
(145, 6, 0, 8, 3, 2, 0, 0, 45),
(146, 5, 1, 5, 2, 1, 0, 0, 50),
(147, 6, 9, 6, 8, 3, 1, 1, 0),
(148, 6, 12, 3, 7, 2, 1, 0, 0),
(149, 5, 10, 4, 5, 3, 2, 1, 0),
(150, 5, 8, 3, 6, 2, 1, 0, 0),
(151, 6, 7, 4, 4, 2, 1, 1, 0),
(152, 5, 5, 9, 3, 1, 1, 0, 0),
(153, 6, 6, 5, 4, 2, 1, 1, 0),
(154, 5, 7, 3, 5, 2, 0, 1, 0),
(155, 6, 3, 7, 4, 2, 1, 0, 0),
(156, 5, 2, 8, 3, 1, 1, 0, 0),
(157, 5, 0, 6, 2, 1, 0, 0, 60),
(158, 6, 4, 9, 3, 2, 1, 0, 0),
(159, 5, 6, 7, 4, 2, 1, 0, 0),
(160, 5, 8, 5, 6, 3, 2, 1, 0),
(161, 6, 10, 4, 8, 2, 1, 1, 0),
(162, 6, 0, 7, 3, 1, 0, 0, 50),
(163, 5, 7, 6, 4, 2, 1, 0, 0),
(164, 5, 8, 4, 5, 2, 1, 1, 0),
(165, 6, 9, 5, 6, 3, 1, 0, 0),
(166, 5, 11, 3, 9, 2, 2, 1, 0),
(167, 6, 0, 6, 2, 1, 0, 0, 45),
(168, 5, 3, 7, 2, 1, 0, 0, 35),
(169, 6, 4, 8, 3, 1, 1, 0, 0),
(170, 5, 5, 6, 4, 2, 1, 0, 0),
(171, 5, 7, 5, 5, 2, 1, 1, 0),
(172, 6, 9, 4, 6, 3, 1, 1, 0),
(173, 6, 2, 8, 4, 3, 1, 0, 0),
(174, 5, 0, 5, 2, 1, 0, 0, 40),
(175, 6, 8, 7, 5, 2, 1, 1, 0),
(176, 5, 6, 5, 4, 1, 0, 0, 0),
(177, 6, 10, 3, 8, 2, 1, 0, 0),
(178, 5, 1, 7, 3, 1, 0, 0, 0),
(179, 6, 0, 6, 2, 1, 0, 0, 35),
(180, 5, 5, 8, 4, 1, 1, 0, 0),
(181, 6, 6, 6, 5, 2, 1, 0, 0),
(182, 5, 7, 5, 4, 1, 0, 0, 0),
(183, 6, 10, 4, 7, 2, 1, 1, 0),
(184, 5, 4, 7, 2, 1, 1, 0, 0),
(185, 6, 3, 8, 4, 2, 1, 0, 0),
(186, 5, 9, 4, 7, 2, 1, 1, 0),
(187, 6, 8, 5, 6, 3, 1, 1, 0),
(188, 5, 5, 6, 3, 1, 0, 0, 0);


INSERT INTO team_game (team_name, game_ID, role) VALUES
# new york league
('Suits', 001, 'home'),
('The Office', 001, 'away'),
('New Girl', 002, 'home'),
('Outer Banks', 002, 'away'),
('Suits', 003, 'home'),
('New Girl', 003, 'away'),
('The Office', 004, 'home'),
('Outer Banks', 004, 'away'),
('Suits', 005, 'home'),
('The Office', 005, 'away'),
('New Girl', 006, 'home'),
('Outer Banks', 006, 'away'),
# california league
('Gilmore Girls', 007, 'home'),
('NHL', 007, 'away'),
('Disney Channel', 008, 'home'),
('Internet', 008, 'away'),
('NHL', 009, 'home'),
('Disney Channel', 009, 'away'),
('Internet', 010, 'home'),
('Gilmore Girls', 010, 'away'),
('Disney Channel', 011, 'home'),
('Gilmore Girls', 011, 'away'),
('Internet', 012, 'home'),
('NHL', 012, 'away');

-- FUNCTIONS TO USE IN PYTHON

# retrieves all teams from database
DROP PROCEDURE IF EXISTS fetch_all_teams;
DELIMITER //
CREATE PROCEDURE fetch_all_teams()
BEGIN
    SELECT DISTINCT name AS team_name
    FROM team;
END //
DELIMITER ;

# retrieves all the players from a team
DROP PROCEDURE IF EXISTS fetch_all_players;
DELIMITER //
CREATE PROCEDURE fetch_all_players(IN team_name VARCHAR(50))
BEGIN
    SELECT *
    FROM person p
    JOIN team_person tp ON p.email_address = tp.email_address
    WHERE tp.team_name = team_name;
END //
DELIMITER ;

# retrieves all stats from a player
DROP PROCEDURE IF EXISTS fetch_all_stats;
DELIMITER //
CREATE PROCEDURE fetch_all_stats(IN player_ID INT)
BEGIN
    SELECT *
    FROM stats s
    WHERE s.player_ID = player_ID;
END //
DELIMITER ;


-- INTERESTING QUERIES

SELECT 
    t.name AS team_name,
    pos.name AS position_name,
    CONCAT(per.first_name, ' ', per.last_name) AS player_name,
    (s.goals_scored + s.assists) AS total_points
FROM 
    team t
JOIN 
    team_person tp ON t.name = tp.team_name
JOIN 
    player pl ON tp.email_address = pl.email_address
JOIN 
    person per ON tp.email_address = per.email_address
JOIN 
    pos ON pl.position_ID = pos.ID
JOIN 
    stats s ON pl.player_ID = s.player_ID
WHERE 
    pos.name = 'Center Forward'
    AND (s.goals_scored + s.assists) = (
        SELECT MAX(s2.goals_scored + s2.assists)
        FROM stats s2
        JOIN player p2 ON s2.player_ID = p2.player_ID
        JOIN team_person tp2 ON p2.email_address = tp2.email_address
        WHERE tp2.team_name = t.name AND p2.position_ID = pl.position_ID
    )
ORDER BY 
    team_name, total_points DESC;




    
# finds and displays in descending order the top coaches (by who coaches the team
# with the most collective goals)
SELECT 
    coach.first_name AS coach_first_name,
    coach.last_name AS coach_last_name,
    t.name AS team_name,
    SUM(s.goals_scored) AS total_team_goals
FROM 
    coach c
JOIN 
    person coach ON c.email_address = coach.email_address
JOIN 
    team t ON t.coach = coach.email_address
JOIN 
    team_person tp ON t.name = tp.team_name
JOIN 
    player pl ON tp.email_address = pl.email_address
JOIN 
    stats s ON pl.player_ID = s.player_ID
GROUP BY 
    coach.first_name, coach.last_name, t.name
ORDER BY 
    total_team_goals DESC;

# compares each teams stats whether they're home or away
SELECT 
    tg.team_name,
    tg.role AS game_role, -- 'home' or 'away'
    SUM(s.goals_scored) AS total_goals,
    SUM(s.assists) AS total_assists,
    SUM(s.shot_blocks) AS total_shot_blocks,
    COUNT(g.game_ID) AS total_games_played
FROM 
    team_game tg
JOIN 
    game g ON tg.game_ID = g.game_ID
JOIN 
    team_person tp ON tg.team_name = tp.team_name
JOIN 
    player pl ON tp.email_address = pl.email_address
JOIN 
    stats s ON pl.player_ID = s.player_ID
GROUP BY 
    tg.team_name, tg.role
ORDER BY 
    tg.team_name, tg.role;