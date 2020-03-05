--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

-- Started on 2020-02-25 10:22:52 MST

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
-- TOC entry 10 (class 2615 OID 29296)
-- Name: lilac; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lilac;


ALTER SCHEMA lilac OWNER TO postgres;

--
-- TOC entry 3257 (class 0 OID 0)
-- Dependencies: 10
-- Name: SCHEMA lilac; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA lilac IS 'standard lilac schema';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 203 (class 1259 OID 29297)
-- Name: author; Type: TABLE; Schema: lilac; Owner: postgres
--

CREATE TABLE lilac.author (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text
);


ALTER TABLE lilac.author OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 37448)
-- Name: author_comment; Type: TABLE; Schema: lilac; Owner: postgres
--

CREATE TABLE lilac.author_comment (
    comment_id uuid NOT NULL,
    author_id uuid NOT NULL
);


ALTER TABLE lilac.author_comment OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 29373)
-- Name: author_post; Type: TABLE; Schema: lilac; Owner: postgres
--

CREATE TABLE lilac.author_post (
    post_id uuid NOT NULL,
    author_id uuid NOT NULL
);


ALTER TABLE lilac.author_post OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 29311)
-- Name: comment; Type: TABLE; Schema: lilac; Owner: postgres
--

CREATE TABLE lilac.comment (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    text text,
    submission_time timestamp with time zone NOT NULL
);


ALTER TABLE lilac.comment OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 29388)
-- Name: comment_post; Type: TABLE; Schema: lilac; Owner: postgres
--

CREATE TABLE lilac.comment_post (
    post_id uuid NOT NULL,
    comment_id uuid NOT NULL
);


ALTER TABLE lilac.comment_post OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 29318)
-- Name: image; Type: TABLE; Schema: lilac; Owner: postgres
--

CREATE TABLE lilac.image (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    size integer NOT NULL,
    url text
);


ALTER TABLE lilac.image OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 29403)
-- Name: image_post; Type: TABLE; Schema: lilac; Owner: postgres
--

CREATE TABLE lilac.image_post (
    post_id uuid NOT NULL,
    image_id uuid NOT NULL
);


ALTER TABLE lilac.image_post OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 29325)
-- Name: post; Type: TABLE; Schema: lilac; Owner: postgres
--

CREATE TABLE lilac.post (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    title text,
    markdown text,
    submission_date timestamp with time zone NOT NULL
);


ALTER TABLE lilac.post OWNER TO postgres;

--
-- TOC entry 3108 (class 2606 OID 29333)
-- Name: author PK_Authors; Type: CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.author
    ADD CONSTRAINT "PK_Authors" PRIMARY KEY (id);


--
-- TOC entry 3110 (class 2606 OID 29337)
-- Name: comment PK_Comments; Type: CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.comment
    ADD CONSTRAINT "PK_Comments" PRIMARY KEY (id);


--
-- TOC entry 3112 (class 2606 OID 29339)
-- Name: image PK_Images; Type: CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.image
    ADD CONSTRAINT "PK_Images" PRIMARY KEY (id);


--
-- TOC entry 3114 (class 2606 OID 29341)
-- Name: post PK_Posts; Type: CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.post
    ADD CONSTRAINT "PK_Posts" PRIMARY KEY (id);


--
-- TOC entry 3122 (class 2606 OID 37452)
-- Name: author_comment author_comment_pkey; Type: CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.author_comment
    ADD CONSTRAINT author_comment_pkey PRIMARY KEY (author_id, comment_id);


--
-- TOC entry 3116 (class 2606 OID 29377)
-- Name: author_post author_post_pkey; Type: CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.author_post
    ADD CONSTRAINT author_post_pkey PRIMARY KEY (author_id, post_id);


--
-- TOC entry 3118 (class 2606 OID 29392)
-- Name: comment_post comment_post_pkey; Type: CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.comment_post
    ADD CONSTRAINT comment_post_pkey PRIMARY KEY (comment_id, post_id);


--
-- TOC entry 3120 (class 2606 OID 29407)
-- Name: image_post image_post_pkey; Type: CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.image_post
    ADD CONSTRAINT image_post_pkey PRIMARY KEY (image_id, post_id);


--
-- TOC entry 3129 (class 2606 OID 37453)
-- Name: author_comment author_comment_author_id_fkey; Type: FK CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.author_comment
    ADD CONSTRAINT author_comment_author_id_fkey FOREIGN KEY (author_id) REFERENCES lilac.author(id) ON UPDATE CASCADE;


--
-- TOC entry 3130 (class 2606 OID 37458)
-- Name: author_comment author_comment_comment_id_fkey; Type: FK CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.author_comment
    ADD CONSTRAINT author_comment_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES lilac.comment(id) ON UPDATE CASCADE;


--
-- TOC entry 3124 (class 2606 OID 29383)
-- Name: author_post author_post_author_id_fkey; Type: FK CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.author_post
    ADD CONSTRAINT author_post_author_id_fkey FOREIGN KEY (author_id) REFERENCES lilac.author(id) ON UPDATE CASCADE;


--
-- TOC entry 3123 (class 2606 OID 29378)
-- Name: author_post author_post_post_id_fkey; Type: FK CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.author_post
    ADD CONSTRAINT author_post_post_id_fkey FOREIGN KEY (post_id) REFERENCES lilac.post(id) ON UPDATE CASCADE;


--
-- TOC entry 3126 (class 2606 OID 29398)
-- Name: comment_post comment_post_comment_id_fkey; Type: FK CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.comment_post
    ADD CONSTRAINT comment_post_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES lilac.comment(id) ON UPDATE CASCADE;


--
-- TOC entry 3125 (class 2606 OID 29393)
-- Name: comment_post comment_post_post_id_fkey; Type: FK CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.comment_post
    ADD CONSTRAINT comment_post_post_id_fkey FOREIGN KEY (post_id) REFERENCES lilac.post(id) ON UPDATE CASCADE;


--
-- TOC entry 3128 (class 2606 OID 29413)
-- Name: image_post image_post_image_id_fkey; Type: FK CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.image_post
    ADD CONSTRAINT image_post_image_id_fkey FOREIGN KEY (image_id) REFERENCES lilac.image(id) ON UPDATE CASCADE;


--
-- TOC entry 3127 (class 2606 OID 29408)
-- Name: image_post image_post_post_id_fkey; Type: FK CONSTRAINT; Schema: lilac; Owner: postgres
--

ALTER TABLE ONLY lilac.image_post
    ADD CONSTRAINT image_post_post_id_fkey FOREIGN KEY (post_id) REFERENCES lilac.post(id) ON UPDATE CASCADE;


-- Completed on 2020-02-25 10:22:53 MST

--
-- PostgreSQL database dump complete
--

