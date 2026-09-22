CREATE TABLE users (
    id biging PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar NOT NULL,
    email varchar NOT NULL,
    password_hash varchar NOT NULL
);

CREATE UNIQUE INDEX idx_on_users_email ON users (email);
