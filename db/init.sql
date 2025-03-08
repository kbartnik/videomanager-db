-- Switch to the videomanager database
CREATE DATABASE IF NOT EXISTS videomanager;

-- Connect to the videomanager database
\connect videomanager;

-- Drop tables if they already exist for development purposes
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,  -- Store hashed passwords for production
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create categories table
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create videos table
CREATE TABLE videos (
    video_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    url VARCHAR(255) NOT NULL,
    category_id INT REFERENCES categories(category_id) ON DELETE SET NULL,
    user_id INT REFERENCES users(user_id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create comments table
CREATE TABLE comments (
    comment_id SERIAL PRIMARY KEY,
    video_id INT REFERENCES videos(video_id) ON DELETE CASCADE,
    user_id INT REFERENCES users(user_id) ON DELETE SET NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Function to update the updated_at column
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for each table
CREATE TRIGGER update_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_categories_updated_at
BEFORE UPDATE ON categories
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_videos_updated_at
BEFORE UPDATE ON videos
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Insert some initial data into the categories table
DO $$
BEGIN
    INSERT INTO categories (name, description) VALUES 
        ('Documentary', 'Documentary films that tell real-life stories.')
    ON CONFLICT (name) DO NOTHING;  -- Prevent error if already exists
END $$;

DO $$
BEGIN
    INSERT INTO categories (name, description) VALUES 
        ('Action', 'Action-packed videos full of thrill and excitement.')
    ON CONFLICT (name) DO NOTHING;  -- Prevent error if already exists
END $$;

DO $$
BEGIN
    INSERT INTO categories (name, description) VALUES 
        ('Comedy', 'Humorous videos designed to make you laugh.')
    ON CONFLICT (name) DO NOTHING;  -- Prevent error if already exists
END $$;

DO $$
BEGIN
    INSERT INTO categories (name, description) VALUES 
        ('Drama', 'Dramatic films that focus on realistic storytelling.')
    ON CONFLICT (name) DO NOTHING;  -- Prevent error if already exists
END $$;

-- Insert some initial data into the users table
DO $$
BEGIN
    INSERT INTO users (username, password, email) VALUES 
        ('admin', 'password123', 'admin@example.com')
    ON CONFLICT (username) DO NOTHING;  -- Prevent error if already exists

    INSERT INTO users (username, password, email) VALUES 
        ('user1', 'password123', 'user1@example.com')
    ON CONFLICT (username) DO NOTHING;  -- Prevent error if already exists
END $$;

-- Insert initial videos data
DO $$
BEGIN
    INSERT INTO videos (title, description, url, category_id, user_id) VALUES 
        ('Nature Documentary', 'A beautiful glimpse into nature.', 'http://example.com/nature.mp4', 1, 1)
    ON CONFLICT (title) DO NOTHING;  -- Prevent error if already exists

    INSERT INTO videos (title, description, url, category_id, user_id) VALUES 
        ('Epic Action Movie', 'An action-packed adventure.', 'http://example.com/action.mp4', 2, 1)
    ON CONFLICT (title) DO NOTHING;  -- Prevent error if already exists

    INSERT INTO videos (title, description, url, category_id, user_id) VALUES 
        ('Stand-Up Comedy Show', 'A night filled with laughter.', 'http://example.com/comedy.mp4', 3, 2)
    ON CONFLICT (title) DO NOTHING;  -- Prevent error if already exists
END $$;

-- Insert some initial comments
DO $$
BEGIN
    INSERT INTO comments (video_id, user_id, comment_text) VALUES 
        (1, 2, 'What a beautiful documentary!')
    ON CONFLICT DO NOTHING;  -- Prevent error if already exists

    INSERT INTO comments (video_id, user_id, comment_text) VALUES 
        (2, 1, 'I loved the action scenes!')
    ON CONFLICT DO NOTHING;  -- Prevent error if already exists
END $$;