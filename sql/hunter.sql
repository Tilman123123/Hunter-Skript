-- hunter.sql

-- Tabelle für Tiere
CREATE TABLE IF NOT EXISTS hunted_animals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    player_id VARCHAR(50),
    animal_type VARCHAR(50),
    kill_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabelle für Belohnungen
CREATE TABLE IF NOT EXISTS rewards_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    player_id VARCHAR(50),
    reward_item VARCHAR(50),
    amount INTEGER,
    reward_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Spieler Fortschritt
CREATE TABLE IF NOT EXISTS player_progress (
    player_id VARCHAR(50) PRIMARY KEY,
    total_kills INTEGER DEFAULT 0,
    last_kill_time TIMESTAMP
);

CREATE TABLE IF NOT EXISTS hunters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(64) NOT NULL,
    name VARCHAR(64) NOT NULL,
    level INT DEFAULT 1,
    experience INT DEFAULT 0,
    kills INT DEFAULT 0,
    last_hunt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS hunted_animals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hunter_id INT,
    animal_type VARCHAR(64),
    location VARCHAR(128),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (hunter_id) REFERENCES hunters(id) ON DELETE CASCADE
);

ALTER TABLE hunter_players ADD COLUMN xp INT DEFAULT 0;

CREATE TABLE IF NOT EXISTS hunter_rewards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    identifier TEXT,
    animal TEXT,
    reward INTEGER,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- sql/hunter.sql

CREATE TABLE IF NOT EXISTS hunted_animals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    identifier VARCHAR(64),
    animal_type VARCHAR(50),
    reward INTEGER,
    drop_item VARCHAR(50),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabelle für getötete Tiere
CREATE TABLE IF NOT EXISTS hunter_kills (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    player_id VARCHAR(50) NOT NULL,
    animal_type VARCHAR(50) NOT NULL,
    reward_amount INT NOT NULL,
    drop_item VARCHAR(50),
    kill_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
