-- in terminal:
-- psql < ddl.sql
-- psql craigslist

DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;

\c craigslist

--Create the regions table

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
    -- Add other user-relaed columns here
);

CREATE TABLE regions (
    region_id SERIAL PRIMARY KEY,
    region_name VARCHAR(255) NOT NULL
    --add other region-related columns here
);

CREATE TABLE posts (
    post_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    text TEXT NOT NULL,
    user_id INT REFERENCES users(user_id),
    location VARCHAR(255) NOT NULL,
    region_id INT REFERENCES regions(region_id)
    -- Add other post-related colums here
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

-- Create the user_regions table (many-to-many junction table)
CREATE TABLE user_preferred_regions (
    user_id INT REFERENCES users(user_id),
    region_id INT REFERENCES regions(region_id),
    PRIMARY KEY (user_id, region_id)
);

-- Create the post_categories table (many-to-many junction table)
CREATE TABLE post_categories (
    post_id INT REFERENCES posts(post_id),
    category_id INT REFERENCES categories(category_id),
    PRIMARY KEY (post_id, category_id)
);

INSERT INTO regions (region_name)
VALUES
    ('San Francisco'),
    ('Atlanta'),
    ('Seattle');

INSERT INTO categories (category_name)
VALUES 
    ('Housing'),
    ('Jobs'),
    ('Services');

INSERT INTO users (username, email, password)
VALUES  
    ('user1', 'user1@example.com', 'password1'),
    ('user2', 'user2@example.com', 'password2');

INSERT INTO user_preferred_regions (user_id, region_id)
VALUES
    (1, 1), -- User 1 prefers San Francisco
    (1, 3), -- User 1 prefers Seattle
    (2, 2); --User 2 prefers Atlanta

INSERT INTO posts (title, text, user_id, location, region_id)
VALUES
    ('Apartment for rent', 'Spacious 2-bedroom apartment available.', 1, '123 Made Up Street', 1),
    ('Job Opening', 'Software Engineer position avaiable.', 2, '456 Elm St', 2);

INSERT INTO post_categories (post_id, category_id)
VALUES
    (1, 1),
    (2, 2);

SELECT * FROM users;
SELECT * FROM regions;
SELECT * FROM categories;
SELECT * FROM posts;
SELECT * FROM user_preferred_regions;
SELECT * FROM post_categories;