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
	date DATE NOT NULL,
    league_name VARCHAR(50) NOT NULL,
    home_team VARCHAR(50) NOT NULL,
	away_team VARCHAR(50) NOT NULL,
    home_team_points INT NOT NULL,
	away_team_points INT NOT NULL,
    FOREIGN KEY (league_name) REFERENCES water_polo_league(league_name)
);

-- "pos" = position
DROP TABLE IF EXISTS pos;
CREATE TABLE pos (
	ID INT PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS player;
CREATE TABLE player (
	first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email_address VARCHAR(50) PRIMARY KEY NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
	player_ID INT UNIQUE NOT NULL,
    position_ID INT NOT NULL,
    number INT NOT NULL,
    team_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (position_ID) REFERENCES pos(ID)
);

DROP TABLE IF EXISTS coach;
CREATE TABLE coach (
	first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email_address VARCHAR(50) PRIMARY KEY NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    experience INT NOT NULL,
    salary INT NOT NULL,
    team_name VARCHAR(50) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS team;
CREATE TABLE team (
	name VARCHAR(50) PRIMARY KEY NOT NULL,
    roster VARCHAR(50) NOT NULL,
    captain VARCHAR(50) NOT NULL,
    wins VARCHAR(50) NOT NULL,
    losses VARCHAR(50) NOT NULL,
    ties VARCHAR(50) NOT NULL,
    FOREIGN KEY (captain) REFERENCES player(email_address)
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

INSERT INTO game (game_ID, league_name, home_team, away_team, home_team_points, 
away_team_points, date) VALUES
(001, 'New York League', 'Suits', 'The Office', 10, 2, '2024-11-15'),
(002, 'New York League', 'The Office', 'New Girl', 4, 6, '2024-11-16'),
(003, 'New York League', 'New Girl', 'Outer Banks', 2, 3,  '2024-11-23'),
(004, 'New York League', 'Outer Banks', 'Suits', 5, 5, '2024-11-27'),
(005, 'New York League', 'Suits', 'New Girl', 3, 2, '2024-11-29'),
(006, 'New York League', 'Outer Banks', 'The Office', 5, 4, '2024-12-01'),
(007, 'California League', 'NHL', 'Disney Channel', 6, 6, '2024-11-16'),
(008, 'California League', 'Disney Channel', 'Internet', 19, 23, '2024-11-20'),
(009, 'California League', 'Internet', 'Gilmore Girls', 7, 10, '2024-11-29'),
(010, 'California League', 'Gilmore Girls', 'NHL', 8, 12, '2024-11-30'),
(011, 'California League', 'NHL', 'Internet', 20, 2, '2024-12-03'),
(012, 'California League', 'Disney Channel', 'Gilmore Girls', 8, 9, '2024-12-05');

INSERT INTO coach (experience, salary, email_address, first_name, last_name, username, password, team_name) VALUES
(15, 95000, 'harry.styles@gmail.com', 'Harry', 'Styles', 'hstyles', 'coach123', 'Suits'),
(12, 85000, 'niall.horan@gmail.com', 'Niall', 'Horan', 'nhoran', 'coach123', 'The Office'),
(10, 80000, 'gracie.abrams@gmail.com', 'Gracie', 'Abrams', 'gabrams', 'coach123', 'New Girl'),
(14, 90000, 'role.model@gmail.com', 'Role', 'Model', 'rmodel', 'coach123', 'Outer Banks'),
(16, 100000, 'noah.kahan@gmail.com', 'Noah', 'Kahan', 'nkahan', 'coach123', 'NHL'),
(9, 78000, 'sabrina.carpenter@gmail.com', 'Sabrina', 'Carpenter', 'scarpenter', 'coach123', 'Disney Channel'),
(11, 82000, 'dominic.fike@gmail.com', 'Dominic', 'Fike', 'dfike', 'coach123', 'Internet'),
(13, 87000, 'charli.xcx@gmail.com', 'Charli', 'XCX', 'cxcx', 'coach123', 'Gilmore Girls');

INSERT INTO pos (ID, name) VALUES
(1, 'Center Forward'),
(2, 'Center Defender'),
(3, 'Left Wing'),
(4, 'Right Wing'),
(5, 'Driver'),
(6, 'Point'),
(7, 'Goalkeeper');

INSERT INTO player (player_ID, position_ID, number, email_address, first_name, last_name, username, password, team_name) VALUES
(101, 1, 43, 'harvey.specter@gmail.com', 'Harvey', 'Specter', 'hspecter', 'cap123', 'Suits'),
(102, 2, 1, 'mike.ross@gmail.com', 'Mike', 'Ross', 'mross', 'play123', 'Suits'),
(103, 3, 10, 'rachel.zane@gmail.com', 'Rachel', 'Zane', 'rzane', 'play123', 'Suits'),
(104, 4, 12, 'louis.litt@gmail.com', 'Louis', 'Litt', 'llitt', 'play123', 'Suits'),
(105, 5, 21, 'donna.paulsen@gmail.com', 'Donna', 'Paulsen', 'dpaulsen', 'play123', 'Suits'),
(106, 6, 9, 'jessica.pearson@gmail.com', 'Jessica', 'Pearson', 'jpearson', 'play123', 'Suits'),
(107, 7, 15, 'katrina.bennett@gmail.com', 'Katrina', 'Bennett', 'kbennett', 'play123', 'Suits'),
(108, 4, 14, 'alex.williams@gmail.com', 'Alex', 'Williams', 'awilliams', 'play123', 'Suits'),
(109, 5, 8, 'samantha.wheeler@gmail.com', 'Samantha', 'Wheeler', 'swheeler', 'play123', 'Suits'),
(110, 3, 23, 'sean.cahill@gmail.com', 'Sean', 'Cahill', 'scahill', 'play123', 'Suits'),
(111, 2, 7, 'dana.scott@gmail.com', 'Dana', 'Scott', 'dscott', 'play123', 'Suits'),
(112, 1, 44, 'michael.scott@gmail.com', 'Michael', 'Scott', 'mscott', 'cap123', 'The Office'),
(113, 2, 2, 'jim.halpert@gmail.com', 'Jim', 'Halpert', 'jhalpert', 'play123', 'The Office'),
(114, 3, 11, 'pam.beesly@gmail.com', 'Pam', 'Beesly', 'pbeesly', 'play123', 'The Office'),
(115, 4, 13, 'dwight.schrute@gmail.com', 'Dwight', 'Schrute', 'dschrute', 'play123', 'The Office'),
(116, 5, 16, 'angela.martin@gmail.com', 'Angela', 'Martin', 'amartin', 'play123', 'The Office'),
(117, 6, 6, 'andy.bernard@gmail.com', 'Andy', 'Bernard', 'abernard', 'play123', 'The Office'),
(118, 7, 17, 'kevin.malone@gmail.com', 'Kevin', 'Malone', 'kmalone', 'play123', 'The Office'),
(119, 3, 18, 'stanley.hudson@gmail.com', 'Stanley', 'Hudson', 'shudson', 'play123', 'The Office'),
(120, 4, 19, 'phyllis.lapinvance@gmail.com', 'Phyllis', 'Lapin-Vance', 'plapinvance', 'play123', 'The Office'),
(121, 5, 20, 'darryl.philbin@gmail.com', 'Darryl', 'Philbin', 'dphilbin', 'play123', 'The Office'),
(122, 1, 22, 'oscar.martinez@gmail.com', 'Oscar', 'Martinez', 'omartinez', 'play123', 'The Office'),
(123, 2, 3, 'jess.day@gmail.com', 'Jess', 'Day', 'jday', 'cap123', 'New Girl'),
(124, 3, 14, 'nick.miller@gmail.com', 'Nick', 'Miller', 'nmiller', 'play123', 'New Girl'),
(125, 4, 24, 'schmidt.cohen@gmail.com', 'Winston', 'Schmidt', 'schmidt', 'play123', 'New Girl'),
(126, 5, 25, 'winston.bishop@gmail.com', 'Winston', 'Bishop', 'wbishop', 'play123', 'New Girl'),
(127, 6, 26, 'cece.parekh@gmail.com', 'Cece', 'Parekh', 'cparekh', 'play123', 'New Girl'),
(128, 7, 27, 'aly.nelson@gmail.com', 'Aly', 'Nelson', 'anelson', 'play123', 'New Girl'),
(129, 3, 28, 'fawn.moscato@gmail.com', 'Fawn', 'Moscato', 'fmoscato', 'play123', 'New Girl'),
(130, 4, 29, 'sam.sweeney@gmail.com', 'Sam', 'Sweeney', 'ssweeney', 'play123', 'New Girl'),
(131, 5, 30, 'abby.day@gmail.com', 'Abby', 'Day', 'aday', 'play123', 'New Girl'),
(132, 6, 31, 'paul.genzlinger@gmail.com', 'Paul', 'Genzlinger', 'pgenzlinger', 'play123', 'New Girl'),
(133, 7, 32, 'ryan.geauxinue@gmail.com', 'Ryan', 'Geauxinue', 'rgeauxinue', 'play123', 'New Girl'),
(134, 1, 34, 'john.routledge@gmail.com', 'John', 'Routledge', 'jroutledge', 'cap123', 'Outer Banks'),
(135, 2, 35, 'sarah.cameron@gmail.com', 'Sarah', 'Cameron', 'scameron', 'play123', 'Outer Banks'),
(136, 3, 36, 'kiara.carerra@gmail.com', 'Kiara', 'Carerra', 'kcarerra', 'play123', 'Outer Banks'),
(137, 4, 37, 'pope.heyward@gmail.com', 'Pope', 'Heyward', 'pheyward', 'play123', 'Outer Banks'),
(138, 5, 38, 'jj.maybank@gmail.com', 'JJ', 'Maybank', 'jmaybank', 'play123', 'Outer Banks'),
(139, 6, 39, 'rafe.cameron@gmail.com', 'Rafe', 'Cameron', 'rcameron', 'play123', 'Outer Banks'),
(140, 7, 40, 'topper.thornton@gmail.com', 'Topper', 'Thornton', 'tthornton', 'play123', 'Outer Banks'),
(141, 3, 41, 'ward.cameron@gmail.com', 'Ward', 'Cameron', 'wcameron', 'play123', 'Outer Banks'),
(142, 4, 42, 'wheezie.cameron@gmail.com', 'Wheezie', 'Cameron', 'whcameron', 'play123', 'Outer Banks'),
(143, 5, 43, 'carlos.singh@gmail.com', 'Carlos', 'Singh', 'csingh', 'play123', 'Outer Banks'),
(144, 6, 44, 'mike.carerra@gmail.com', 'Mike', 'Carerra', 'mcarerra', 'play123', 'Outer Banks'),
(145, 1, 45, 'quinn.hughes@gmail.com', 'Quinn', 'Hughes', 'qhughes', 'cap123', 'NHL'),  -- here.
(146, 2, 46, 'jeremy.swayman@gmail.com', 'Jeremy', 'Swayman', 'jswayman', 'play123', 'NHL'),
(147, 3, 47, 'sidney.crosby@gmail.com', 'Sidney', 'Crosby', 'scrosby', 'play123', 'NHL'),
(148, 4, 48, 'connor.mcdavid@gmail.com', 'Connor', 'McDavid', 'cmcdavid', 'play123', 'NHL'),
(149, 5, 49, 'alex.ovechkin@gmail.com', 'Alex', 'Ovechkin', 'aovechkin', 'play123', 'NHL'),
(150, 6, 50, 'nathan.mackinnon@gmail.com', 'Nathan', 'MacKinnon', 'nmackinnon', 'play123', 'NHL'),
(151, 7, 51, 'leon.draisaitl@gmail.com', 'Leon', 'Draisaitl', 'ldraisaitl', 'play123', 'NHL'),
(152, 3, 52, 'patrick.kane@gmail.com', 'Patrick', 'Kane', 'pkane', 'play123', 'NHL'),
(153, 4, 53, 'mitch.marner@gmail.com', 'Mitch', 'Marner', 'mmarner', 'play123', 'NHL'),
(154, 5, 54, 'jack.hughes@gmail.com', 'Jack', 'Hughes', 'jhughes', 'play123', 'NHL'),
(155, 6, 55, 'trevor.zegras@gmail.com', 'Trevor', 'Zegras', 'tzegras', 'play123', 'NHL'),
(156, 1, 56, 'miley.stewart@gmail.com', 'Miley', 'Stewart', 'mstewart', 'cap123', 'Disney Channel'),
(157, 2, 57, 'raven.baxter@gmail.com', 'Raven', 'Baxter', 'rbaxter', 'play123', 'Disney Channel'),
(158, 3, 58, 'lizzie.mcguire@gmail.com', 'Lizzie', 'McGuire', 'lmcguire', 'play123', 'Disney Channel'),
(159, 4, 59, 'zack.martin@gmail.com', 'Zack', 'Martin', 'zmartin', 'play123', 'Disney Channel'),
(160, 5, 60, 'cody.martin@gmail.com', 'Cody', 'Martin', 'cmartin', 'play123', 'Disney Channel'),
(161, 6, 61, 'alex.russo@gmail.com', 'Alex', 'Russo', 'arusso', 'play123', 'Disney Channel'),
(162, 7, 62, 'troy.bolton@gmail.com', 'Troy', 'Bolton', 'tbolton', 'play123', 'Disney Channel'),
(163, 3, 63, 'gabriella.montez@gmail.com', 'Gabriella', 'Montez', 'gmontez', 'play123', 'Disney Channel'),
(164, 4, 64, 'london.tipton@gmail.com', 'London', 'Tipton', 'ltipton', 'play123', 'Disney Channel'),
(165, 5, 65, 'phineas.flynn@gmail.com', 'Phineas', 'Flynn', 'pflynn', 'play123', 'Disney Channel'),
(166, 6, 66, 'olivia.rodrigo@gmail.com', 'Olivia', 'Rodrigo', 'orodrigo', 'play123', 'Disney Channel'),
(167, 1, 67, 'trisha.paytas@gmail.com', 'Trisha', 'Paytas', 'tpaytas', 'cap123', 'Internet'),
(168, 2, 68, 'addison.rae@gmail.com', 'Addison', 'Rae', 'arae', 'play123', 'Internet'),
(169, 3, 69, 'charli.damelio@gmail.com', 'Charli', 'DAmelio', 'cdamelio', 'play123', 'Internet'),
(170, 4, 70, 'dixie.damelio@gmail.com', 'Dixie', 'DAmelio', 'ddamelio', 'play123', 'Internet'),
(171, 5, 71, 'emma.chamberlain@gmail.com', 'Emma', 'Chamberlain', 'echamberlain', 'play123', 'Internet'),
(172, 6, 72, 'james.charles@gmail.com', 'James', 'Charles', 'jcharles', 'play123', 'Internet'),
(173, 7, 73, 'jake.shane@gmail.com', 'Jake', 'Shane', 'jshane', 'play123', 'Internet'),
(174, 3, 74, 'logan.paul@gmail.com', 'Logan', 'Paul', 'lpaul', 'play123', 'Internet'),
(175, 4, 75, 'jake.paul@gmail.com', 'Jake', 'Paul', 'jpaul', 'play123', 'Internet'),
(176, 5, 76, 'josh.richards@gmail.com', 'Josh', 'Richards', 'jrichards', 'play123', 'Internet'),
(177, 6, 77, 'bryce.hall@gmail.com', 'Bryce', 'Hall', 'bhall', 'play123', 'Internet'),
(178, 1, 78, 'lorelai.gilmore@gmail.com', 'Lorelai', 'Gilmore', 'lgilmore', 'cap123', 'Gilmore Girls'),
(179, 2, 79, 'rory.gilmore@gmail.com', 'Rory', 'Gilmore', 'rgilmore', 'play123', 'Gilmore Girls'),
(180, 3, 80, 'luke.danes@gmail.com', 'Luke', 'Danes', 'ldanes', 'play123', 'Gilmore Girls'),
(181, 4, 81, 'emily.gilmore@gmail.com', 'Emily', 'Gilmore', 'egilmore', 'play123', 'Gilmore Girls'),
(182, 5, 82, 'tristan.dugray@gmail.com', 'Tristan', 'Dugray', 'tdugray', 'play123', 'Gilmore Girls'),
(183, 6, 83, 'paris.geller@gmail.com', 'Paris', 'Geller', 'pgeller', 'play123', 'Gilmore Girls'),
(184, 7, 84, 'lane.kim@gmail.com', 'Lane', 'Kim', 'lkim', 'play123', 'Gilmore Girls'),
(185, 3, 85, 'jess.mariano@gmail.com', 'Jess', 'Mariano', 'jmariano', 'play123', 'Gilmore Girls'),
(186, 4, 86, 'sookie.stjames@gmail.com', 'Sookie', 'St. James', 'sstjames', 'play123', 'Gilmore Girls'),
(187, 5, 87, 'logan.huntzberger@gmail.com', 'Logan', 'Huntzberger', 'lhuntzberger', 'play123', 'Gilmore Girls'),
(188, 6, 88, 'dean.forester@gmail.com', 'Dean', 'Forester', 'dforester', 'play123', 'Gilmore Girls');

INSERT INTO team (name, roster, captain, wins, losses, ties) VALUES
('Suits', 'Roster A', 'harvey.specter@gmail.com', 2, 0, 1),
('The Office', 'Roster B', 'michael.scott@gmail.com', 0, 3, 0),
('New Girl', 'Roster A', 'jess.day@gmail.com', 1, 2, 0),
('Outer Banks', 'Roster B', 'john.routledge@gmail.com', 2, 0, 1),
('NHL', 'Roster A', 'quinn.hughes@gmail.com', 2, 0, 1),
('Disney Channel', 'Roster B', 'miley.stewart@gmail.com', 0, 2, 1),
('Internet', 'Roster A', 'trisha.paytas@gmail.com', 1, 2, 0),
('Gilmore Girls', 'Roster B', 'lorelai.gilmore@gmail.com', 2, 1, 0);

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

# compare leagues and order in descending order of top goal scores, assists, and saves
SELECT 
    l.league_name,
    SUM(s.goals_scored) AS total_goals,
    SUM(s.assists) AS total_assists,
    SUM(s.saves) AS total_saves
FROM 
    water_polo_league l
JOIN 
    game g ON l.league_name = g.league_name
JOIN 
    team_game tg ON g.game_ID = tg.game_ID
JOIN 
    team t ON tg.team_name = t.name
JOIN 
    player p ON t.name = p.team_name
JOIN 
    stats s ON p.player_ID = s.player_ID
GROUP BY 
    l.league_name
ORDER BY 
    total_goals DESC, total_assists DESC, total_saves DESC;


# finds and displays in descending order the top coaches (by who coaches the team
# with the most collective goals)
SELECT 
    c.first_name AS coach_first_name,
    c.last_name AS coach_last_name,
    t.name AS team_name,
    SUM(s.goals_scored) AS total_team_goals
FROM 
    coach c
JOIN 
    team t ON c.team_name = t.name
JOIN 
    player p ON t.name = p.team_name
JOIN 
    stats s ON p.player_ID = s.player_ID
GROUP BY 
    c.first_name, c.last_name, t.name
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
    player p ON tg.team_name = p.team_name
JOIN 
    stats s ON p.player_ID = s.player_ID
GROUP BY 
    tg.team_name, tg.role
ORDER BY 
    tg.team_name, tg.role;