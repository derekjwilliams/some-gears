/*Connecting to the database automatically creates it*/
\connect artwork;

CREATE SCHEMA mimi;

CREATE TABLE mimi.creator (
    id SERIAL PRIMARY KEY,
    name TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE mimi.creator IS
'Creator';

CREATE TABLE mimi.collection (
    id SERIAL PRIMARY KEY,
    title TEXT,
    cover_image_url TEXT
);

COMMENT ON TABLE mimi.collection IS
'A Collection of Albums';

CREATE TABLE mimi.album (
    id SERIAL PRIMARY KEY,
    title TEXT,
    body TEXT,
    cover_image_url TEXT,
    creator_id INTEGER NOT NULL REFERENCES mimi.creator(id),
    collection_id INTEGER NOT NULL REFERENCES mimi.collection(id)
);

COMMENT ON TABLE mimi.album IS
'An Album of CreativeWorks';