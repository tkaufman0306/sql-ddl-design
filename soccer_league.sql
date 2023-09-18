


DROP DATABASE IF EXISTS soccer_league;

CREATE DATABASE soccer_league;

\c soccer_league

-- Create the teams table
CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(255) NOT NULL,
    team_logo BYTEA -- You can use BYTEA for storing image data (team logos)
);

-- Create the players table
CREATE TABLE players (
    player_id SERIAL PRIMARY KEY,
    player_name VARCHAR(255) NOT NULL,
    team_id INT REFERENCES teams(team_id)
);

-- Create the referees table
CREATE TABLE referees (
    referee_id SERIAL PRIMARY KEY,
    referee_name VARCHAR(255) NOT NULL
);

-- Create the matches table
CREATE TABLE matches (
    match_id SERIAL PRIMARY KEY,
    home_team_id INT REFERENCES teams(team_id),
    away_team_id INT REFERENCES teams(team_id),
    match_date_time TIMESTAMP,
    referee_id INT REFERENCES referees(referee_id)
);
-- Create the goals table
CREATE TABLE goals (
    goal_id SERIAL PRIMARY KEY,
    player_id INT REFERENCES players(player_id),
    match_id INT REFERENCES matches(match_id),
    goal_timestamp TIMESTAMP,
    scoring_team_id INT REFERENCES teams(team_id),
    assisting_player_id INT REFERENCES players(player_id)
);

-- Create the seasons table
CREATE TABLE seasons (
    season_id SERIAL PRIMARY KEY,
    season_name VARCHAR(255) NOT NULL,
    start_date DATE,
    end_date DATE
);

-- Create the standings table
CREATE TABLE standings (
    standings_id SERIAL PRIMARY KEY,
    season_id INT REFERENCES seasons(season_id),
    team_id INT REFERENCES teams(team_id),
    wins INT,
    draws INT,
    losses INT,
    goals_for INT,
    goals_against INT,
    points INT
);


-- Insert sample data into the teams table
INSERT INTO teams (team_name, team_logo)
VALUES
    ('Team A', NULL),
    ('Team B', NULL),
    ('Team C', NULL);

-- Insert sample data into the players table
INSERT INTO players (player_name, team_id)
VALUES
    ('Player 1', 1),
    ('Player 2', 1),
    ('Player 3', 2),
    ('Player 4', 3);

-- Insert sample data into the referees table
INSERT INTO referees (referee_name)
VALUES
    ('Referee 1'),
    ('Referee 2');

-- Insert sample data into the matches table
INSERT INTO matches (home_team_id, away_team_id, match_date_time, referee_id)
VALUES
    (1, 2, '2023-09-10 14:00:00', 1),
    (2, 3, '2023-09-12 15:30:00', 2);

-- Insert sample data into the seasons table
INSERT INTO seasons (season_name, start_date, end_date)
VALUES
    ('2023 Season', '2023-01-01', '2023-12-31');

-- Insert sample data into the standings table
INSERT INTO standings (season_id, team_id, wins, draws, losses, goals_for, goals_against, points)
VALUES
    (1, 1, 2, 1, 0, 8, 4, 7),
    (1, 2, 1, 1, 1, 5, 5, 4),
    (1, 3, 0, 0, 2, 2, 6, 0);

-- Insert sample data into the goals table
INSERT INTO goals (player_id, match_id, goal_timestamp, scoring_team_id, assisting_player_id)
VALUES
    (1, 1, '2023-09-10 14:15:00', 1, NULL),
    (3, 1, '2023-09-10 14:25:00', 2, 4),
    (2, 2, '2023-09-12 15:40:00', 1, NULL);


SELECT * FROM teams;

SELECT players.player_name, teams.team_name
FROM players
JOIN teams ON players.team_id = teams.team_id;

SELECT matches.match_date_time, teams_home.team_name AS home_team, teams_away.team_name AS away_team, referees.referee_name
FROM matches
JOIN teams AS teams_home ON matches.home_team_id = teams_home.team_id
JOIN teams AS teams_away ON matches.away_team_id = teams_away.team_id
JOIN referees ON matches.referee_id = referees.referee_id;

SELECT teams.team_name, standings.wins, standings.draws, standings.losses, standings.goals_for, standings.goals_against, standings.points
FROM standings
JOIN teams ON standings.team_id = teams.team_id
WHERE standings.season_id = 1; -- Assuming season_id 1 is the 2023 Season


-- Retrieve Goals Scored with Player Names and Match Details:
SELECT goals.goal_timestamp, players.player_name AS scorer, assisting_player.player_name AS assistant, teams.team_name AS scoring_team
FROM goals
JOIN players ON goals.player_id = players.player_id
LEFT JOIN players AS assisting_player ON goals.assisting_player_id = assisting_player.player_id
JOIN teams ON goals.scoring_team_id = teams.team_id
JOIN matches ON goals.match_id = matches.match_id;
