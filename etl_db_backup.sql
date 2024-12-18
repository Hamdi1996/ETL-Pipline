--
-- PostgreSQL database dump
--

-- Dumped from database version 14.15 (Ubuntu 14.15-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.15 (Ubuntu 14.15-0ubuntu0.22.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: address; Type: TABLE; Schema: public; Owner: etl
--

CREATE TABLE public.address (
    id integer NOT NULL,
    user_id integer,
    address character varying,
    city character varying,
    state character varying
);


ALTER TABLE public.address OWNER TO etl;

--
-- Name: address_id_seq; Type: SEQUENCE; Schema: public; Owner: etl
--

CREATE SEQUENCE public.address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_id_seq OWNER TO etl;

--
-- Name: address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: etl
--

ALTER SEQUENCE public.address_id_seq OWNED BY public.address.id;


--
-- Name: hair; Type: TABLE; Schema: public; Owner: etl
--

CREATE TABLE public.hair (
    id integer NOT NULL,
    user_id integer,
    color character varying,
    type character varying
);


ALTER TABLE public.hair OWNER TO etl;

--
-- Name: hair_id_seq; Type: SEQUENCE; Schema: public; Owner: etl
--

CREATE SEQUENCE public.hair_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hair_id_seq OWNER TO etl;

--
-- Name: hair_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: etl
--

ALTER SEQUENCE public.hair_id_seq OWNED BY public.hair.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: etl
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    age integer,
    email character varying
);


ALTER TABLE public.users OWNER TO etl;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: etl
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO etl;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: etl
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: address id; Type: DEFAULT; Schema: public; Owner: etl
--

ALTER TABLE ONLY public.address ALTER COLUMN id SET DEFAULT nextval('public.address_id_seq'::regclass);


--
-- Name: hair id; Type: DEFAULT; Schema: public; Owner: etl
--

ALTER TABLE ONLY public.hair ALTER COLUMN id SET DEFAULT nextval('public.hair_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: etl
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: etl
--

COPY public.address (id, user_id, address, city, state) FROM stdin;
61	1	626 Main Street	Phoenix	Mississippi
62	2	385 Fifth Street	Houston	Alabama
63	3	1642 Ninth Street	Washington	Alabama
64	4	238 Jefferson Street	Seattle	Pennsylvania
65	5	607 Fourth Street	Jacksonville	Colorado
66	6	547 First Street	Fort Worth	Tennessee
67	7	664 Maple Street	Indianapolis	Delaware
68	8	1197 First Street	Fort Worth	Rhode Island
69	9	466 Pine Street	San Antonio	Louisiana
70	10	1964 Oak Street	New York	Utah
71	11	576 Fifth Street	Denver	South Dakota
72	12	1627 Sixth Street	Jacksonville	West Virginia
73	13	1413 Maple Street	New York	North Dakota
74	14	208 Second Street	Columbus	Ohio
75	15	31 Maple Street	San Jose	Utah
76	16	1125 First Street	Columbus	Iowa
77	17	1170 Lincoln Street	San Diego	Wyoming
78	18	907 Seventh Street	Columbus	Arkansas
79	19	996 Oak Street	Chicago	New Mexico
80	20	1873 Main Street	New York	Arkansas
81	21	1892 Lincoln Street	Philadelphia	New Jersey
82	22	1701 Eighth Street	Columbus	Illinois
83	23	401 Fourth Street	Dallas	New Jersey
84	24	1578 Fourth Street	Columbus	Missouri
85	25	1591 Adams Street	Philadelphia	New York
86	26	1065 Lincoln Street	Dallas	Maine
87	27	1163 Pine Street	Los Angeles	Nevada
88	28	1946 Oak Street	Phoenix	Massachusetts
89	29	1837 Maple Street	Indianapolis	Delaware
90	30	568 Tenth Street	San Francisco	Montana
\.


--
-- Data for Name: hair; Type: TABLE DATA; Schema: public; Owner: etl
--

COPY public.hair (id, user_id, color, type) FROM stdin;
61	1	Brown	Curly
62	2	Green	Straight
63	3	White	Wavy
64	4	Blonde	Straight
65	5	White	Straight
66	6	Gray	Curly
67	7	White	Straight
68	8	Red	Kinky
69	9	Purple	Curly
70	10	Blonde	Curly
71	11	Red	Wavy
72	12	Purple	Wavy
73	13	Red	Curly
74	14	Gray	Kinky
75	15	Gray	Curly
76	16	Green	Curly
77	17	Blue	Curly
78	18	Green	Curly
79	19	Blue	Kinky
80	20	Red	Straight
81	21	Gray	Curly
82	22	Purple	Straight
83	23	Red	Kinky
84	24	Purple	Wavy
85	25	Red	Curly
86	26	Black	Wavy
87	27	Blonde	Curly
88	28	Purple	Straight
89	29	Black	Straight
90	30	Blonde	Straight
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: etl
--

COPY public.users (id, first_name, last_name, age, email) FROM stdin;
1	Emily	Johnson	28	emily.johnson@x.dummyjson.com
2	Michael	Williams	35	michael.williams@x.dummyjson.com
3	Sophia	Brown	42	sophia.brown@x.dummyjson.com
4	James	Davis	45	james.davis@x.dummyjson.com
5	Emma	Miller	30	emma.miller@x.dummyjson.com
6	Olivia	Wilson	22	olivia.wilson@x.dummyjson.com
7	Alexander	Jones	38	alexander.jones@x.dummyjson.com
8	Ava	Taylor	27	ava.taylor@x.dummyjson.com
9	Ethan	Martinez	33	ethan.martinez@x.dummyjson.com
10	Isabella	Anderson	31	isabella.anderson@x.dummyjson.com
11	Liam	Garcia	29	liam.garcia@x.dummyjson.com
12	Mia	Rodriguez	24	mia.rodriguez@x.dummyjson.com
13	Noah	Hernandez	40	noah.hernandez@x.dummyjson.com
14	Charlotte	Lopez	36	charlotte.lopez@x.dummyjson.com
15	William	Gonzalez	32	william.gonzalez@x.dummyjson.com
16	Avery	Perez	25	avery.perez@x.dummyjson.com
17	Evelyn	Sanchez	37	evelyn.sanchez@x.dummyjson.com
18	Logan	Torres	31	logan.torres@x.dummyjson.com
19	Abigail	Rivera	28	abigail.rivera@x.dummyjson.com
20	Jackson	Evans	34	jackson.evans@x.dummyjson.com
21	Madison	Collins	26	madison.collins@x.dummyjson.com
22	Elijah	Stewart	33	elijah.stewart@x.dummyjson.com
23	Chloe	Morales	39	chloe.morales@x.dummyjson.com
24	Mateo	Nguyen	30	mateo.nguyen@x.dummyjson.com
25	Harper	Kelly	27	harper.kelly@x.dummyjson.com
26	Evelyn	Gonzalez	35	evelyn.gonzalez@x.dummyjson.com
27	Daniel	Cook	41	daniel.cook@x.dummyjson.com
28	Lily	Lee	29	lily.lee@x.dummyjson.com
29	Henry	Hill	38	henry.hill@x.dummyjson.com
30	Addison	Wright	32	addison.wright@x.dummyjson.com
\.


--
-- Name: address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: etl
--

SELECT pg_catalog.setval('public.address_id_seq', 90, true);


--
-- Name: hair_id_seq; Type: SEQUENCE SET; Schema: public; Owner: etl
--

SELECT pg_catalog.setval('public.hair_id_seq', 90, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: etl
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: etl
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: hair hair_pkey; Type: CONSTRAINT; Schema: public; Owner: etl
--

ALTER TABLE ONLY public.hair
    ADD CONSTRAINT hair_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: etl
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: address address_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: etl
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: hair hair_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: etl
--

ALTER TABLE ONLY public.hair
    ADD CONSTRAINT hair_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

