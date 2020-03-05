--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

-- Started on 2020-03-05 11:31:35 MST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 12 (class 2615 OID 29296)
-- Name: blog; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA blog;


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 12
-- Name: SCHEMA blog; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA blog IS 'simple blog schema';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 205 (class 1259 OID 29297)
-- Name: author; Type: TABLE; Schema: blog; Owner: -
--

CREATE TABLE blog.author (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text
);


--
-- TOC entry 212 (class 1259 OID 37448)
-- Name: author_comment; Type: TABLE; Schema: blog; Owner: -
--

CREATE TABLE blog.author_comment (
    comment_id uuid NOT NULL,
    author_id uuid NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 29373)
-- Name: author_post; Type: TABLE; Schema: blog; Owner: -
--

CREATE TABLE blog.author_post (
    post_id uuid NOT NULL,
    author_id uuid NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 29311)
-- Name: comment; Type: TABLE; Schema: blog; Owner: -
--

CREATE TABLE blog.comment (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    text text,
    submission_time timestamp with time zone NOT NULL
);


--
-- TOC entry 210 (class 1259 OID 29388)
-- Name: comment_post; Type: TABLE; Schema: blog; Owner: -
--

CREATE TABLE blog.comment_post (
    post_id uuid NOT NULL,
    comment_id uuid NOT NULL
);


--
-- TOC entry 207 (class 1259 OID 29318)
-- Name: image; Type: TABLE; Schema: blog; Owner: -
--

CREATE TABLE blog.image (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    size integer NOT NULL,
    url text
);


--
-- TOC entry 211 (class 1259 OID 29403)
-- Name: image_post; Type: TABLE; Schema: blog; Owner: -
--

CREATE TABLE blog.image_post (
    post_id uuid NOT NULL,
    image_id uuid NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 29325)
-- Name: post; Type: TABLE; Schema: blog; Owner: -
--

CREATE TABLE blog.post (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    title text,
    markdown text,
    submission_date timestamp with time zone NOT NULL
);


--
-- TOC entry 3402 (class 2606 OID 29333)
-- Name: author PK_Authors; Type: CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.author
    ADD CONSTRAINT "PK_Authors" PRIMARY KEY (id);


--
-- TOC entry 3404 (class 2606 OID 29337)
-- Name: comment PK_Comments; Type: CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.comment
    ADD CONSTRAINT "PK_Comments" PRIMARY KEY (id);


--
-- TOC entry 3406 (class 2606 OID 29339)
-- Name: image PK_Images; Type: CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.image
    ADD CONSTRAINT "PK_Images" PRIMARY KEY (id);


--
-- TOC entry 3408 (class 2606 OID 29341)
-- Name: post PK_Posts; Type: CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.post
    ADD CONSTRAINT "PK_Posts" PRIMARY KEY (id);


--
-- TOC entry 3416 (class 2606 OID 37452)
-- Name: author_comment author_comment_pkey; Type: CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.author_comment
    ADD CONSTRAINT author_comment_pkey PRIMARY KEY (author_id, comment_id);


--
-- TOC entry 3410 (class 2606 OID 29377)
-- Name: author_post author_post_pkey; Type: CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.author_post
    ADD CONSTRAINT author_post_pkey PRIMARY KEY (author_id, post_id);


--
-- TOC entry 3412 (class 2606 OID 29392)
-- Name: comment_post comment_post_pkey; Type: CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.comment_post
    ADD CONSTRAINT comment_post_pkey PRIMARY KEY (comment_id, post_id);


--
-- TOC entry 3414 (class 2606 OID 29407)
-- Name: image_post image_post_pkey; Type: CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.image_post
    ADD CONSTRAINT image_post_pkey PRIMARY KEY (image_id, post_id);


--
-- TOC entry 3423 (class 2606 OID 37453)
-- Name: author_comment author_comment_author_id_fkey; Type: FK CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.author_comment
    ADD CONSTRAINT author_comment_author_id_fkey FOREIGN KEY (author_id) REFERENCES blog.author(id) ON UPDATE CASCADE;


--
-- TOC entry 3424 (class 2606 OID 37458)
-- Name: author_comment author_comment_comment_id_fkey; Type: FK CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.author_comment
    ADD CONSTRAINT author_comment_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES blog.comment(id) ON UPDATE CASCADE;


--
-- TOC entry 3418 (class 2606 OID 29383)
-- Name: author_post author_post_author_id_fkey; Type: FK CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.author_post
    ADD CONSTRAINT author_post_author_id_fkey FOREIGN KEY (author_id) REFERENCES blog.author(id) ON UPDATE CASCADE;


--
-- TOC entry 3417 (class 2606 OID 29378)
-- Name: author_post author_post_post_id_fkey; Type: FK CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.author_post
    ADD CONSTRAINT author_post_post_id_fkey FOREIGN KEY (post_id) REFERENCES blog.post(id) ON UPDATE CASCADE;


--
-- TOC entry 3420 (class 2606 OID 29398)
-- Name: comment_post comment_post_comment_id_fkey; Type: FK CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.comment_post
    ADD CONSTRAINT comment_post_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES blog.comment(id) ON UPDATE CASCADE;


--
-- TOC entry 3419 (class 2606 OID 29393)
-- Name: comment_post comment_post_post_id_fkey; Type: FK CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.comment_post
    ADD CONSTRAINT comment_post_post_id_fkey FOREIGN KEY (post_id) REFERENCES blog.post(id) ON UPDATE CASCADE;


--
-- TOC entry 3422 (class 2606 OID 29413)
-- Name: image_post image_post_image_id_fkey; Type: FK CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.image_post
    ADD CONSTRAINT image_post_image_id_fkey FOREIGN KEY (image_id) REFERENCES blog.image(id) ON UPDATE CASCADE;


--
-- TOC entry 3421 (class 2606 OID 29408)
-- Name: image_post image_post_post_id_fkey; Type: FK CONSTRAINT; Schema: blog; Owner: -
--

ALTER TABLE ONLY blog.image_post
    ADD CONSTRAINT image_post_post_id_fkey FOREIGN KEY (post_id) REFERENCES blog.post(id) ON UPDATE CASCADE;


-- Completed on 2020-03-05 11:31:36 MST

--
-- PostgreSQL database dump complete
--

