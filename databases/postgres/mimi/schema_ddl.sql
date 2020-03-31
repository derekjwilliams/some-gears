/*Connecting to the database automatically creates it*/
\connect artwork;

CREATE SCHEMA mimi;

ALTER SCHEMA mimi OWNER TO postgres;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" with schema public;

CREATE TABLE mimi.album (
    id uuid DEFAULT mimi.uuid_generate_v4() NOT NULL,
    title text,
    href text,
    thumbnail_image_url text
);
COMMENT ON TABLE mimi.album IS 'An Album of Creative Works';

CREATE TABLE mimi.collection (
    id uuid DEFAULT mimi.uuid_generate_v4() NOT NULL,
    title text,
    thumbnail_image_url text,
    href text
);
COMMENT ON TABLE mimi.collection IS 'A Collection of Albums';

CREATE TABLE mimi.collection_album (
    album_id uuid NOT NULL,
    collection_id uuid NOT NULL
);

ALTER TABLE ONLY mimi.album
    ADD CONSTRAINT "PK_Albums" PRIMARY KEY (id);

ALTER TABLE ONLY mimi.collection
    ADD CONSTRAINT "PK_Collections" PRIMARY KEY (id);


ALTER TABLE ONLY mimi.collection_album
    ADD CONSTRAINT collection_album_pkey PRIMARY KEY (album_id, collection_id);


ALTER TABLE ONLY mimi.collection_album
    ADD CONSTRAINT collection_album_album_id_fkey FOREIGN KEY (album_id) REFERENCES mimi.album(id) ON UPDATE CASCADE;


ALTER TABLE ONLY mimi.collection_album
    ADD CONSTRAINT collection_album_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES mimi.collection(id) ON UPDATE CASCADE;
