--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    active boolean DEFAULT true
);


ALTER TABLE public.categories OWNER TO lagtv;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO lagtv;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('categories_id_seq', 20, true);


--
-- Name: comments; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    replay_id integer NOT NULL,
    text text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    rating integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.comments OWNER TO lagtv;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO lagtv;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('comments_id_seq', 20, true);


--
-- Name: forem_categories; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE forem_categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.forem_categories OWNER TO lagtv;

--
-- Name: forem_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE forem_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forem_categories_id_seq OWNER TO lagtv;

--
-- Name: forem_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE forem_categories_id_seq OWNED BY forem_categories.id;


--
-- Name: forem_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('forem_categories_id_seq', 17, true);


--
-- Name: forem_forums; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE forem_forums (
    id integer NOT NULL,
    title character varying(255),
    description text,
    category_id integer,
    views_count integer DEFAULT 0
);


ALTER TABLE public.forem_forums OWNER TO lagtv;

--
-- Name: forem_forums_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE forem_forums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forem_forums_id_seq OWNER TO lagtv;

--
-- Name: forem_forums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE forem_forums_id_seq OWNED BY forem_forums.id;


--
-- Name: forem_forums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('forem_forums_id_seq', 43, true);


--
-- Name: forem_groups; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE forem_groups (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.forem_groups OWNER TO lagtv;

--
-- Name: forem_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE forem_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forem_groups_id_seq OWNER TO lagtv;

--
-- Name: forem_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE forem_groups_id_seq OWNED BY forem_groups.id;


--
-- Name: forem_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('forem_groups_id_seq', 1, true);


--
-- Name: forem_memberships; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE forem_memberships (
    id integer NOT NULL,
    group_id integer,
    member_id integer
);


ALTER TABLE public.forem_memberships OWNER TO lagtv;

--
-- Name: forem_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE forem_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forem_memberships_id_seq OWNER TO lagtv;

--
-- Name: forem_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE forem_memberships_id_seq OWNED BY forem_memberships.id;


--
-- Name: forem_memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('forem_memberships_id_seq', 2, true);


--
-- Name: forem_moderator_groups; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE forem_moderator_groups (
    id integer NOT NULL,
    forum_id integer,
    group_id integer
);


ALTER TABLE public.forem_moderator_groups OWNER TO lagtv;

--
-- Name: forem_moderator_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE forem_moderator_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forem_moderator_groups_id_seq OWNER TO lagtv;

--
-- Name: forem_moderator_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE forem_moderator_groups_id_seq OWNED BY forem_moderator_groups.id;


--
-- Name: forem_moderator_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('forem_moderator_groups_id_seq', 1, true);


--
-- Name: forem_posts; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE forem_posts (
    id integer NOT NULL,
    topic_id integer,
    text text,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reply_to_id integer,
    state character varying(255) DEFAULT 'pending_review'::character varying,
    notified boolean DEFAULT false
);


ALTER TABLE public.forem_posts OWNER TO lagtv;

--
-- Name: forem_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE forem_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forem_posts_id_seq OWNER TO lagtv;

--
-- Name: forem_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE forem_posts_id_seq OWNED BY forem_posts.id;


--
-- Name: forem_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('forem_posts_id_seq', 69, true);


--
-- Name: forem_subscriptions; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE forem_subscriptions (
    id integer NOT NULL,
    subscriber_id integer,
    topic_id integer
);


ALTER TABLE public.forem_subscriptions OWNER TO lagtv;

--
-- Name: forem_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE forem_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forem_subscriptions_id_seq OWNER TO lagtv;

--
-- Name: forem_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE forem_subscriptions_id_seq OWNED BY forem_subscriptions.id;


--
-- Name: forem_subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('forem_subscriptions_id_seq', 11, true);


--
-- Name: forem_topics; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE forem_topics (
    id integer NOT NULL,
    forum_id integer,
    user_id integer,
    subject character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    locked boolean DEFAULT false NOT NULL,
    pinned boolean DEFAULT false,
    hidden boolean DEFAULT false,
    last_post_at timestamp without time zone,
    state character varying(255) DEFAULT 'pending_review'::character varying,
    views_count integer DEFAULT 0
);


ALTER TABLE public.forem_topics OWNER TO lagtv;

--
-- Name: forem_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE forem_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forem_topics_id_seq OWNER TO lagtv;

--
-- Name: forem_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE forem_topics_id_seq OWNED BY forem_topics.id;


--
-- Name: forem_topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('forem_topics_id_seq', 11, true);


--
-- Name: forem_views; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE forem_views (
    id integer NOT NULL,
    user_id integer,
    viewable_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    count integer DEFAULT 0,
    viewable_type character varying(255),
    current_viewed_at timestamp without time zone,
    past_viewed_at timestamp without time zone
);


ALTER TABLE public.forem_views OWNER TO lagtv;

--
-- Name: forem_views_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE forem_views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forem_views_id_seq OWNER TO lagtv;

--
-- Name: forem_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE forem_views_id_seq OWNED BY forem_views.id;


--
-- Name: forem_views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('forem_views_id_seq', 48, true);


--
-- Name: replays; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE replays (
    id integer NOT NULL,
    title character varying(255),
    description text,
    protoss boolean,
    zerg boolean,
    terran boolean,
    players character varying(255),
    league character varying(255),
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    replay_file character varying(255),
    user_id integer,
    status character varying(255) DEFAULT 'new'::character varying NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    average_rating double precision DEFAULT 0.0 NOT NULL
);


ALTER TABLE public.replays OWNER TO lagtv;

--
-- Name: replays_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE replays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.replays_id_seq OWNER TO lagtv;

--
-- Name: replays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE replays_id_seq OWNED BY replays.id;


--
-- Name: replays_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('replays_id_seq', 8, true);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO lagtv;

--
-- Name: users; Type: TABLE; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    password_digest character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    role character varying(255) DEFAULT 'member'::character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    auth_token character varying(255),
    password_reset_token character varying(255),
    forem_admin boolean DEFAULT false,
    forem_state character varying(255) DEFAULT 'pending_review'::character varying,
    last_viewed_all_at timestamp without time zone,
    signature text,
    show_signature boolean DEFAULT true,
    hide_others_signatures boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO lagtv;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: lagtv
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO lagtv;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lagtv
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lagtv
--

SELECT pg_catalog.setval('users_id_seq', 9, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY forem_categories ALTER COLUMN id SET DEFAULT nextval('forem_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY forem_forums ALTER COLUMN id SET DEFAULT nextval('forem_forums_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY forem_groups ALTER COLUMN id SET DEFAULT nextval('forem_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY forem_memberships ALTER COLUMN id SET DEFAULT nextval('forem_memberships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY forem_moderator_groups ALTER COLUMN id SET DEFAULT nextval('forem_moderator_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY forem_posts ALTER COLUMN id SET DEFAULT nextval('forem_posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY forem_subscriptions ALTER COLUMN id SET DEFAULT nextval('forem_subscriptions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY forem_topics ALTER COLUMN id SET DEFAULT nextval('forem_topics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY forem_views ALTER COLUMN id SET DEFAULT nextval('forem_views_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY replays ALTER COLUMN id SET DEFAULT nextval('replays_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lagtv
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY categories (id, name, created_at, updated_at, active) FROM stdin;
16	Normal game	2012-06-30 23:37:30.398223	2012-06-30 23:37:30.398223	t
17	When cheese fails	2012-06-30 23:37:30.40837	2012-06-30 23:37:30.40837	t
18	Will cheese fail	2012-06-30 23:37:30.409882	2012-06-30 23:37:30.409882	t
20	meh	2012-10-26 10:35:55.048555	2012-10-26 10:35:55.048555	f
19	blah1	2012-10-26 10:33:09.894518	2012-10-26 10:36:00.712458	t
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY comments (id, replay_id, text, user_id, created_at, updated_at, rating) FROM stdin;
1	1	1	1	2012-07-22 13:23:00.636478	2012-07-22 13:23:00.636478	0
2	1	2	1	2012-07-22 13:23:07.932515	2012-07-22 13:23:07.932515	3
3	1	3	1	2012-07-22 13:23:13.731502	2012-07-22 13:23:13.731502	4
4	1	4	1	2012-07-22 13:23:20.133177	2012-07-22 13:23:20.133177	2
5	1	5	1	2012-07-22 13:23:24.317555	2012-07-22 13:23:24.317555	4
6	1	6	1	2012-07-22 13:23:29.345197	2012-07-22 13:23:29.345197	1
7	1	7	1	2012-07-22 13:23:45.592814	2012-07-22 13:23:45.592814	5
8	1	8	1	2012-07-22 14:21:03.836111	2012-07-22 14:21:03.836111	0
9	1	9	1	2012-07-22 14:21:09.458684	2012-07-22 14:21:09.458684	0
10	1	10	1	2012-07-22 14:21:12.587718	2012-07-22 14:21:12.587718	0
11	1	11	1	2012-07-22 14:21:14.893914	2012-07-22 14:21:14.893914	0
12	1	12	1	2012-07-22 14:21:17.432165	2012-07-22 14:21:17.432165	0
13	1	13	1	2012-07-22 14:21:21.486994	2012-07-22 14:21:21.486994	0
14	1	hello	1	2012-10-14 19:15:46.474154	2012-10-14 19:15:46.474154	3
15	7	blah	1	2012-10-14 21:27:49.916661	2012-10-14 21:27:49.916661	0
16	7	blah	1	2012-10-14 21:28:55.219715	2012-10-14 21:28:55.219715	3
17	7	hello	1	2012-10-16 21:37:11.107231	2012-10-16 21:37:11.107231	3
18	7	test	1	2012-10-16 23:27:14.888421	2012-10-16 23:27:14.888421	4
19	8	123	3	2012-10-30 14:04:10.380242	2012-10-30 14:04:10.380242	0
20	8	123	3	2012-10-30 14:04:14.732192	2012-10-30 14:04:14.732192	3
\.


--
-- Data for Name: forem_categories; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY forem_categories (id, name, created_at, updated_at) FROM stdin;
11	Platforms	2012-06-30 23:37:30.747532	2012-06-30 23:37:30.747532
12	Gaming	2012-06-30 23:37:30.788543	2012-06-30 23:37:30.788543
13	E-Sports	2012-06-30 23:37:30.792251	2012-06-30 23:37:30.792251
14	LAG TV	2012-06-30 23:37:30.795659	2012-06-30 23:37:30.795659
15	Off-Topic	2012-06-30 23:37:30.802908	2012-06-30 23:37:30.802908
16	Tech	2012-06-30 23:37:30.806522	2012-06-30 23:37:30.806522
17	Support	2012-06-30 23:37:30.811769	2012-06-30 23:37:30.811769
\.


--
-- Data for Name: forem_forums; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY forem_forums (id, title, description, category_id, views_count) FROM stdin;
36	Minecraft Channel	Talk all about Minecraft Channel stuff	14	12
29	Xbox	Talk all about Xbox stuff	11	28
33	General	Talk all about General stuff	12	0
35	Starcraft 2 Channel	Talk all about Starcraft 2 Channel stuff	14	0
38	General	Talk all about General stuff	15	0
40	Software	Talk all about Software stuff	16	0
41	User FAQ	Talk all about User FAQ stuff	17	0
42	Report Bugs	Talk all about Report Bugs stuff	17	0
43	Suggestions	Talk all about Suggestions stuff	17	0
39	Hardware	Talk all about Hardware stuff	16	1
37	Events	Talk all about Events stuff	14	2
31	Wii	Talk all about Wii stuff	11	1
32	Handheld / Mobile	Talk all about Handheld / Mobile stuff	11	2
34	General	Talk all about General stuff	13	1
28	PC	Talk all about PC stuff	11	37
30	PS3	Talk all about PS3 stuff	11	5
\.


--
-- Data for Name: forem_groups; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY forem_groups (id, name) FROM stdin;
1	Test Group
\.


--
-- Data for Name: forem_memberships; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY forem_memberships (id, group_id, member_id) FROM stdin;
1	1	2
2	1	1
\.


--
-- Data for Name: forem_moderator_groups; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY forem_moderator_groups (id, forum_id, group_id) FROM stdin;
1	29	1
\.


--
-- Data for Name: forem_posts; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY forem_posts (id, topic_id, text, user_id, created_at, updated_at, reply_to_id, state, notified) FROM stdin;
50	8	16	1	2012-10-30 16:17:44.09869	2012-10-30 16:17:44.09869	\N	approved	t
51	8	Replying to 8 which is on page 1	1	2012-10-30 16:31:52.574063	2012-10-30 16:31:52.574063	42	approved	t
52	8	meh - not read	1	2012-10-30 17:21:29.710537	2012-10-30 17:21:29.710537	51	approved	t
59	10	<p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "><b>LAGTV TERMS &amp; CONDITIONS [last updated 11/2012]</b></p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">While we want everyone to have a good time while here, that doesn't mean that there aren't restrictions. Being a user on LAGTV comes with some responsibilities.</p><h2 style="color: rgb(0, 0, 0); font-family: Times; line-height: normal; ">USER ACCOUNTS</h2><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">While we currently have no age restrictions for user accounts, it is at the discretion of the user as to whether or not they partake in the forum. We are not responsible for underage users being exposed to content subjectively deemed unfit for children.</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">We may use the email you provide to us in your user account to provide you with service messages and updates. By becoming a site member you are consenting to the receipt of these communications.</p><h2 style="color: rgb(0, 0, 0); font-family: Times; line-height: normal; ">CONTENT YOU POST ON THE SITE</h2><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">You are responsible for all content that you post on or transmit through the site. You may not post content that:</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "></p><ul style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "><li>Infringes the copyright, trademark, patent right or other proprietary right of any person or that is used without the permission of the owner;</li><li>You know to be inaccurate;</li><li>is pornographic, sexually explicit or obscene;</li><li>exploits children or minors;</li><li>is libelous, slanderous or defamatory;</li><li>contains any personally identifying information about any person without their consent or about any person who is a minor;</li><li>may be deemed generally offensive to the site community, including blatant expressions of bigotry, prejudice, racism, hatred or profanity;</li><li>includes advertisements, promotions, solicitations or offers to sell any goods or services for any commercial purpose;</li><li>promotes or provides instructional information about illegal or illicit activities; or</li><li>contains software viruses or any other computer code, files or programs designed to destroy, interrupt or otherwise limit the functionality of any computer software, computer hardware or other equipment.</li></ul><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "></p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">We may remove any content that violates these Terms and Conditions or that we determine is otherwise not appropriate for the site.</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">When you post or transmit content on or through the site, you grant LAGTV a nonexclusive, perpetual, irrevocable, worldwide, sub licensable, royalty-free license to use, store, display, publish, transmit, transfer, distribute, reproduce, rearrange, edit, modify, aggregate, create derivative works of and publicly perform the content that you submit to the site for any purpose, in any form, medium, or technology now known or later developed. You also grant us a license to use your name, city and state (or province or applicable) in connection with our use of any content you provide us. You also consent to the display of advertising within or adjacent to any of your content.</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">LAGTV grants its users the right to reprint, republish or reuse any content you contribute to the site for non-commercial purpose under the&nbsp;<a href="http://creativecommons.org/licenses/by-nc/3.0/" title="Creative Commons Attribution-Noncommercial 3.0 Unported License" target="_blank">Creative Commons' Attribution-Noncommercial 3.0 Unported License</a>. By posting content to the site you consent to the granting of this license.</p><h2 style="color: rgb(0, 0, 0); font-family: Times; line-height: normal; ">YOUR USE OF THE SITE</h2><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">All of the content available through the site is protected by our copyrights or trademarks and the copyrights or trademarks of our partners and/or users. You may not use, store, display, publish, transmit, distribute, modify, reproduce, create derivative works of or in any way exploit any of this content, in whole or in part, outside of the specific usage rights granted to you by LAGTV as part of the services we provided.</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">You may not use the site to do any of the following:</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "></p><ul style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "><li>harass or advocate harassment of another person or entity;</li><li>perform any activities that violate any local, federal, or international laws or regulations;</li><li>impersonate any person or entity or misrepresent in any way your affiliation with a person or entity;</li><li>transmit unsolicited mass mailing or "spam;"</li><li>collect or store any information about other users or members, other than in the normal course of using the site for its intended purpose of facilitating voluntary communication among users;</li><li>transmit any virus, worm, defect, Trojan horse or similar destructive or harmful item.</li></ul><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "></p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">You may not do any of the following to the site:<br></p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "></p><ul style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "><li>use it in any manner that could damage, disable, overburden, disrupt or impair the site or our network or interfere with any other party's use and enjoyment of the site;</li><li>modify, adapt, translate or reverse engineer the site;</li><li>use any robot, spider, site search/retrieval application, or other device to retrieve or index any portion of the site (though LAGTV grants the operators of public search engines permission to use spiders to copy materials from the site for the sole purpose of creating publicly available searchable indices of the content on the site that link back to the site for the full text of the content)</li><li>frame the site or reformat it in any way; or</li><li>create user accounts using any automated means or under false pretenses</li></ul><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "></p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">All of the content available through the site is subject to the copyrights and trademarks of LAGTV, or partners, or users. We grant you a license to reprint, republish or reuse any content on the site for non-commercial purposes under the&nbsp;<a href="http://creativecommons.org/licenses/by-nc/3.0/" title="Creative Commons Attribution-Noncommercial 3.0 Unported License" target="_blank">Creative Commons' Attribution-Noncommercial 3.0 Unported License</a>, provided you provide attribution to the LAGTV community.</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">Except as described in the previous paragraph, you may not store, display, publish, transmit, distribute, modify, reproduce, create derivative works of or in any way exploit any of the site content, in whole or in part.</p><h2 style="color: rgb(0, 0, 0); font-family: Times; line-height: normal; ">THIRD-PARTY SITES, PRODUCTS, AND SERVICES</h2><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">The site provides access and contains links to third party Internet sites and services. Your use of those sites and services is subject to the terms and conditions of those sites. LAGTV is not responsible for the activities of any third-party site.</p><h2 style="color: rgb(0, 0, 0); font-family: Times; line-height: normal; ">EMBEDDABLE ITEMS</h2><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">LAGTV may make available charts, graphics or other items that your can embed on your own website. If you use any of these embeddable items, you must include a prominent link back to the site on the pages containing the embeddable item and you may not modify, build upon, or block any portion of the embeddable item in any way or present it in any manner that is false or misleading.</p><h2 style="color: rgb(0, 0, 0); font-family: Times; line-height: normal; ">INTELLECTUAL PROPERTY RIGHTS POLICY</h2><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">LAGTV respects the rights of intellectual property holders. If you believe that any content on the site violates these Terms and Conditions or your intellectual property rights, you may report such violations to us. In the case of an alleged infringement, please provide the following information:</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "></p><ul style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "><li>A description of the copyrighted work or other intellectual property that you claim has been infringed;</li><li>A description of where the material that you claim is infringing is located on the site (including the exact URL);</li><li>An address, telephone number, and an e-mail address where we can contact you;</li><li>A statement that you have a good-faith belief that the use is not authorized by the copyright or other intellectual property rights owner, by its agent, or by law;</li><li>A statement by you under penalty of perjury that the information in your notice is accurate and that you are the copyright or intellectual property owner or are authorized to act on the owner's behalf;</li><li>Your electronic or physical signature.</li></ul><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "></p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">We may request additional information before we remove allegedly infringing material. You may report a copyright violation by providing the above information to the LAGTV Administrator listed below:</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">Adam Morehouse<br>Email: LAGTVNovaWar@gmail.com</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">We will terminate the user account of any user who repeatedly submits content that violated our intellectual property policies.</p><h2 style="color: rgb(0, 0, 0); font-family: Times; line-height: normal; ">OUR RIGHTS AND RESPONSIBILITIES</h2><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">We maintain the right to do any of the following any time, with or without prior notice:</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "></p><ul style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "><li>restrict, suspend, or terminate your access to all or any part of our services;</li><li>change, suspend, or discontinue all or any part of our services;</li><li>refuse, move, or remove any content;</li><li>refuse to register any user name that may be deemed offensive and</li><li>establish general practices, fees and policies concerning the site and the services we provide</li></ul><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; "></p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">We do not make any representations about the accuracy of any content posted on the site, whether posted by us, our users, or third parties. All information and services provided on the site are offered "as-is" without any express or implied warranty, and you should not rely on the information presented on the site. Your use of the site is at your own risk.</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">We disclaim any responsibility for inaccuracies on the site. We are not responsible for any loss, harm, error or omission that may result from use of the site or the services we provide or for any service failure or interruption, regardless of the cause.</p><h2 style="color: rgb(0, 0, 0); font-family: Times; line-height: normal; ">APPLICABLE LAW</h2><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">These Terms shall be construed in accordance with the laws of the Province of Nova Scotia, and the parties irrevocably consent to bring any action to enforce these Terms and Conditions before an arbitration panel or before a court of competent jurisdiction in Halifax, Nova Scotia if seeking interim or preliminary relief or enforcement of an arbitration award.</p><h2 style="color: rgb(0, 0, 0); font-family: Times; line-height: normal; ">CONSEQUENCES OF VIOLATION OF THESE TERMS</h2><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">By utilizing the site you agree to indemnify, defend and hold LAGTV and its administrators, moderators, community managers, analysts, and affiliates harmless from and against any and all liability, losses, costs, and expenses (including attorney's fees) incurred by LAGTV through your use of the site or your posting or transmission of content in violation of these Terms. You also agree to take sole responsibility for any royalties, fees or other monies owed to any person by reason of any content you post or transmit through the site or the services we provide.</p><p style="color: rgb(0, 0, 0); font-family: Times; font-size: medium; line-height: normal; ">We reserve the right to terminate your access to the site if you fail to abide by these Terms and Conditions. We also reserve the right to inform law enforcement authorities of any potential illegal activities and to provide them with all information about the account through which such activities occurred, as described in our Privacy Policy.</p>	1	2012-10-30 21:13:46.167556	2012-10-30 21:13:46.167556	\N	approved	t
6	4	is this in markdown\r\n\r\n* one\r\n* two\r\n* three\r\n\r\nbouse	1	2012-07-01 07:45:11.048092	2012-07-01 07:45:11.048092	\N	approved	t
7	4	<blockquote>is this in markdown\r\n      \r\n      * one\r\n      * two\r\n      * three\r\n      \r\n      bouse</blockquote>	1	2012-07-01 07:45:25.249674	2012-07-01 07:45:25.249674	6	approved	t
60	8	should be on top	1	2012-10-31 21:53:30.667427	2012-10-31 21:53:30.667427	\N	approved	t
56	9	hello	1	2012-10-30 17:35:09.969415	2012-10-30 17:35:09.969415	\N	approved	t
25	7	blah	1	2012-10-30 11:55:20.292809	2012-10-30 11:55:20.292809	\N	approved	t
16	4	this is an autolink test:<div><br></div><div><a href="http://www.youtube.com" title="YouTube" target="">http://www.youtube.com</a></div><div><br></div><div>meh</div>	1	2012-07-04 12:30:42.409824	2012-07-04 12:33:11.670569	\N	approved	t
57	9	blah	1	2012-10-30 17:41:19.15122	2012-10-30 17:41:19.15122	56	approved	t
17	4	:happy:<div><br></div><div>:+1:</div>	1	2012-07-04 20:07:39.902461	2012-07-04 20:23:28.574951	16	approved	t
61	8	meh	1	2012-10-31 22:12:00.481446	2012-10-31 22:12:00.481446	\N	approved	t
18	4	<br>	1	2012-07-04 20:24:05.913765	2012-07-04 20:24:05.913765	17	approved	t
19	6	:smile:	1	2012-07-04 21:18:50.467575	2012-07-04 21:18:50.467575	\N	approved	t
20	7	blah :1:	1	2012-07-14 22:37:09.773123	2012-07-14 22:37:09.773123	\N	approved	t
21	8	testing :)	1	2012-10-10 22:53:36.120333	2012-10-10 22:53:36.120333	\N	approved	t
22	4	:smile:<div><br></div><div>http://andy.com</div><div><br></div><div><a href="http://andy.com" title="" target="">http://andy.com</a><br></div>	1	2012-10-13 15:34:24.095356	2012-10-13 15:34:24.095356	18	approved	t
8	4	here is a link http://andypike.com blah	1	2012-07-01 15:42:29.823138	2012-10-14 21:11:19.023046	\N	approved	t
62	9	top	1	2012-10-31 22:21:50.899995	2012-10-31 22:21:50.899995	\N	approved	t
23	7	uk :uk:	1	2012-10-30 11:09:20.578553	2012-10-30 11:09:20.578553	\N	approved	t
24	7	<b>LAGTV TERMS &amp; CONDITIONS [last updated 11/2012]</b><div><br></div><div>While we want everyone to have a good time while here, that doesn't mean that there aren't restrictions. Being a user on LAGTV comes with some responsibilities.</div><div><br></div><div><font size="5"><b>USER ACCOUNTS</b></font></div><div><br></div><div>While we currently have no age restrictions for user accounts, it is at the discretion of the user as to whether or not they partake in the forum. We are not responsible for underage users being exposed to content subjectively deemed not unfit for children.</div><div><br></div><div>We may use the email you provide to us in your user account to provide you with service messages and updates. By becoming a site member you are consenting to the receipt of these communications.</div><div><br></div><div><br></div><div><font size="5"><b>CONTENT YOU POST ON THE SITE</b></font></div><div><br></div><div>You are responsible for all content that you post on or transmit through the site. You may not post content that:</div><div><ul><li>Infringes the copyright, trademark, patent right or other proprietary right of any person or that is used without the permission of the owner;</li><li>You know to be inaccurate;</li><li>is pornographic, sexually explicit or obscene;</li><li>exploits children or minors;</li><li>is libelous, slanderous or defamatory;</li><li>contains any personally identifying information about any person without their consent or about any person who is a minor;</li><li>may be deemed generally offensive to the site community, including blatant expressions of bigotry, prejudice, racism, hated or profanity;</li><li>includes advertisements, promotions, solicitations or offers to sell any goods or services for any commercial purpose;</li><li>promotes or provides instructional information about illegal or illicit activities; or</li><li>contains software viruses or any other computer code, files or programs designed to destroy, interrupt or otherwise limit the functionality of any computer software, computer hardware or other equipment.&nbsp;</li></ul><div>We may remove any content that violates these Terms and Conditions or that we determine is otherwise not appropriate for the site.</div></div><div><br></div><div>When you post or transmit content on or through the site, you grant LAGTV a nonexclusive, perpetual, irrevocable, worldwide, sub licensable, royalty-free license to use, store, display, publish, transmit, transfer, distribute, reproduce, rearrange, edit, modify, aggregate, create derivative works of and publicly perform the content that you submit to the site for any purpose, in any form, medium, or technology now known or later developed. You also grant us a license to use your name, city and state (or province or applicable) in connection with our use of any content you provide us. You also consent to the display of advertising within or adjacent to any of your content.&nbsp;</div><div><br></div><div>LAGTV grants its users the right to reprint, republish or reuse any content you contribute to the site for non-commercial purpose under the&nbsp;<a href="http://creativecommons.org/licenses/by-nc/3.0/" title="Creative Commons Attribution-Noncommercial 3.0 Unported License" target="_blank">Creative Commons' Attribution-Noncommercial 3.0 Unported License</a>. By posting content to the site you consent to the granting of this license.</div><div><br></div><div style="text-align: center; "><font size="5"><b><br></b></font></div><div style="text-align: center; "><font size="5"><b>YOUR USE OF THE SITE</b></font></div><div><br></div><div><font size="2">All of the content&nbsp;available&nbsp;through the site is protected by our copyrights or trademarks and the copyrights or trademarks of our partners and/or users. You may not use, store, display, publish, transmit, distribute, modify, reproduce, create derivative works of or in any way exploit any of this content, in whole or in part, outside of the specific usage rights granted to you by LAGTV as part of the services we provided.</font></div><div><font size="2"><br></font></div><div><font size="2">You may not use the site to do any of the following:</font></div><div><font size="2"><br></font></div><div><ul><li><font size="2">harass or advocate harassment of another person or entity;</font></li><li><font size="2">perform any activities that violate any local, federal, or international laws or regulations;</font></li><li><font size="2">impersonate any person or entity or misrepresent in any way your affiliation with a person or entity;</font></li><li><font size="2">transmit unsolicited mass mailing or "spam;"</font></li><li><font size="2">collect or store any information about other users or members, other than in the normal course of using the site for its intended purpose of facilitating voluntary communication among users;</font></li><li><font size="2">transmit any virus, worm, defect,&nbsp;Trojan&nbsp;horse or similar destructive or harmful item.</font></li></ul><div><span style="font-size: small; ">You may not do any of the following to the site:</span><br></div><div><font size="2"><br></font></div><div><ul><li><font size="2">use it in any manner that could damage, disable, overburden, disrupt or impair the site or our network or interfere with any other party's use and enjoyment of the site;</font></li><li><font size="2">modify, adapt, translate or reverse engineer the site;</font></li><li><font size="2">use any robot, spider, site search/retrieval application, or other device to retrieve or index any portion of the site (though LAGTV grants the operators of public search engines permission to use spiders to copy materials from the site for the sole purpose of creating publicly&nbsp;available&nbsp;searchable indices of the content on the site that link back to the site for the full text of the content);</font></li><li><font size="2">frame the site or reformat it in any way; or</font></li><li><font size="2">create user accounts using any automated means or under false pretenses</font></li></ul><div><font size="2"><br></font></div></div><div><font size="2">All of the content available through the site is subject to the copyrights and trademarks of LAGTV, or partners, or users. We grant you a license to reprint, republish or reuse any content on the site for non-commercial purposes under the&nbsp;<a href="http://creativecommons.org/licenses/by-nc/3.0/" title="Creative Commons Attribution-Noncommercial 3.0 Unported License" target="_blank">Creative Commons' Attribution-Noncommercial 3.0 Unported License</a>, provided you provide attribution to the LAGTV community.</font></div><div><font size="2"><br></font></div><div><font size="2">Except as described in the previous paragraph, you may not store, display, publish, transmit, distribute, modify, reproduce, create derivative works of or in any way exploit any of the site content, in&nbsp;whole&nbsp;or in part.&nbsp;</font></div><div><font size="2"><br></font></div><div><br></div><div style="text-align: center; "><b><font size="5">THIRD-PARTY SITES, PRODUCTS, AND SERVICES</font></b></div><div style="text-align: center; "><b><font size="5"><br></font></b></div><div><font size="2">The site provides access and contains links to third party Internet sites and services. Your use of those sites and services is subject to the terms and conditions of those sites. LAGTV is not responsible for the activities of any third-party site.</font></div><div><font size="2"><br></font></div><div><font size="2"><br></font></div><div style="text-align: center; "><b><font size="5">EMBEDDABLE ITEMS</font></b></div><div style="text-align: center; "><b><font size="5"><br></font></b></div><div><font size="2">LAGTV may make available charts, graphics or other items that your can embed on your own website. If you use any of these embeddable items, you must include a prominent link back to the site on the pages containing the embeddable item and you may not modify, build upon, or block any portion of the embeddable item in any way or present it in any manner that is false or misleading.</font></div><div><font size="2"><br></font></div><div><font size="2"><br></font></div><div style="text-align: center; "><b><font size="5">INTELLECTUAL PROPERTY RIGHTS POLICY</font></b></div><div style="text-align: center; "><b><font size="5"><br></font></b></div><div><br></div><div>LAGTV respects the rights of intellectual property holders. If you believe that any content on the site violates these Terms and Conditions or your intellectual property rights, you can report such violation to us. In the case of an alleged infringement, please provide the following information:</div><div><br><ul><li>A description of the copyrighted work or other intellectual property that you claim has been infringed;</li><li>A description of where the material that you claim is infringing is located on the site (including the exact URL);</li><li>An address, telephone number, and an e-mail address where we can contact you;</li><li>A statement that you have a good-faith belief that the use is not authorized by the copyright or other intellectual property rights owner, by its agent, or by law;</li><li>A statement by you under penalty of perjury that the information in your notice is accurate and that you are the copyright or intellectual property owner or are authorized to act on the owner's behalf;</li><li>Your electronic or physical signature.</li></ul><div><br></div><div>We may request additional information before we remove allegedly infringing material. You may report a copyright violation by providing the above information to the LAGTV Administrator listed below:</div><div><br></div><div>Adam Morehouse</div><div>Email: LAGTVNovaWar@gmail.com</div><div><br></div><div>We will terminate the user account of any user who repeatedly submits content that violated our intellectual property policies.&nbsp;</div><div><br></div><div><br></div><div style="text-align: center; "><b><font size="5">OUR RIGHTS AND RESPONSIBILITIES</font></b></div><div style="text-align: center; "><b><font size="5"><br></font></b></div><div><font size="2">We maintain the right to do any of the following any time, with or without prior notice:</font></div><div><font size="2"><br></font></div><div><ul><li><font size="2">restrict, suspend, or terminate your access to all or any part of our services;</font></li><li><font size="2">change, suspend, or discontinue all or any part of our services;</font></li><li><font size="2">refuse, move, or remove any content;</font></li><li><font size="2">refuse to register any user name that may be deemed offensive and</font></li><li><font size="2">establish general practices, fees and policies concerning the site and the services we provide</font></li></ul><div><span style="font-size: small; ">We do not make any representations about the accuracy of any content posted on the site, whether posted by us, our users, or third parties. All information and services provided on the site are offered "as-is" without any express or implied warranty, and you should not rely on the information presented on the site. Your use of the site is at your own risk.</span><br></div><div><font size="2"><br></font></div><div><font size="2">We disclaim any responsibility for inaccuracies on the site. We are not responsible for any loss, harm, error or omission that may result from use of the site or the services we provide or for any service failure or interruption, regardless of the cause.</font></div><div><font size="2"><br></font></div><div><font size="2"><br></font></div><div style="text-align: center; "><b><font size="5">APPLICABLE LAW</font></b></div><div style="text-align: center; "><b><font size="5"><br></font></b></div><div><font size="2">These Terms shall be construed in accordance with the laws of the Province of Nova Scotia, and the parties irrevocably consent to bring any action to enforce these Terms and Conditions before an arbitration panel or before a court of competent jurisdiction in Halifax, Nova Scotia if seeking interim or preliminary relief or enforcement of an arbitration award.&nbsp;</font></div></div><div style="text-align: center; "><br></div><div><br></div><div style="text-align: center; "><b><font size="5">CONSEQUENCES OF VIOLATION OF THESE TERMS</font></b></div><div style="text-align: center; "><b><font size="5"><br></font></b></div><div><font size="2">By utilizing the site you agree to indemnify, defend and hold LAGTV and its administrators, moderators, community managers, analysts, and affiliates harmless from and against any and all liability, losses, costs, and expenses (including attorney's fees) incurred by LAGTV through your use of the site or your posting or transmission of content in violation of these Terms. You also agree to take sole responsibility for any royalties, fees or other monies owed to any person by reason of any content you post or transmit through the site or the services we provide.</font></div><div><font size="2"><br></font></div><div><font size="2">We reserve the right to terminate your access to the site if you fail to abide by these Terms and Conditions. We also reserve the right to inform law enforcement&nbsp;authorities&nbsp;of any potential illegal activities and to provide them with all information about the account through which such activities occurred, as described in our Privacy Policy.</font></div></div></div>	1	2012-10-30 11:44:30.28068	2012-10-30 11:44:30.28068	\N	approved	t
26	8	blah	3	2012-10-30 14:05:01.018819	2012-10-30 14:05:01.018819	\N	approved	t
67	10	Reply test	1	2012-11-05 23:11:28.334682	2012-11-05 23:11:28.334682	59	approved	t
27	9	blah	3	2012-10-30 14:13:39.067596	2012-10-30 14:13:39.067596	\N	approved	t
28	8	meh	3	2012-10-30 14:13:51.695152	2012-10-30 14:13:51.695152	\N	approved	t
29	9	yo	3	2012-10-30 14:17:30.951767	2012-10-30 14:17:30.951767	\N	approved	t
64	10	<img src="http://media.blizzard.com/sc2/media/wallpapers/wall011/wall011-1600x900.jpg" alt="" align="none"><br>	1	2012-11-04 12:58:16.252826	2012-11-04 12:58:16.252826	\N	approved	t
30	8	bouse	3	2012-10-30 14:18:22.682098	2012-10-30 14:18:22.682098	\N	approved	t
31	9	latest	3	2012-10-30 14:20:14.468175	2012-10-30 14:20:14.468175	\N	approved	t
33	9	test2	1	2012-10-30 15:41:18.049976	2012-10-30 15:41:18.049976	\N	approved	t
32	8	test1 - 2	1	2012-10-30 15:40:52.328977	2012-10-30 15:41:57.771185	\N	approved	t
65	11	Topic from blah updated2	6	2012-11-04 14:30:53.879215	2012-11-04 14:31:05.298967	\N	approved	t
34	8	1	1	2012-10-30 16:15:17.193859	2012-10-30 16:15:17.193859	\N	approved	t
35	8	2	1	2012-10-30 16:15:23.272849	2012-10-30 16:15:23.272849	\N	approved	t
36	8	3	1	2012-10-30 16:15:30.326085	2012-10-30 16:15:30.326085	\N	approved	t
66	11	testing	9	2012-11-04 21:24:31.820695	2012-11-04 21:24:31.820695	\N	approved	t
37	8	4	1	2012-10-30 16:15:35.823946	2012-10-30 16:15:35.823946	\N	approved	t
38	8	5	1	2012-10-30 16:15:41.183615	2012-10-30 16:15:41.183615	\N	approved	t
39	8	5	1	2012-10-30 16:15:47.213274	2012-10-30 16:15:47.213274	\N	approved	t
40	8	6	1	2012-10-30 16:15:53.814389	2012-10-30 16:15:53.814389	\N	approved	t
41	8	7	1	2012-10-30 16:15:59.721115	2012-10-30 16:15:59.721115	\N	approved	t
68	10	Bouse dlkjhgf kjsdhgf kajhsdfg kjahsgdf kjhdgf kajhsdgf kjashdgf kjashdgf kjahdsgf kjashdgf kajshdgf kajshdgf kjahsgdf kjahsdg fkjahsdfg kjahsdgf kjhasdg fkjahsgf kjahsdgf kjhasdgf kjahsdgf kjashdgf kjahsdgf kjahsdgf kjahsgdf kjhsdgf d<div>Bouse dlkjhgf kjsdhgf kajhsdfg kjahsgdf kjhdgf kajhsdgf kjashdgf kjashdgf kjahdsgf kjashdgf kajshdgf kajshdgf kjahsgdf kjahsdg fkjahsdfg kjahsdgf kjhasdg fkjahsgf kjahsdgf kjhasdgf kjahsdgf kjashdgf kjahsdgf kjahsdgf kjahsgdf kjhsdgf d<br></div><div>Bouse dlkjhgf kjsdhgf kajhsdfg kjahsgdf kjhdgf kajhsdgf kjashdgf kjashdgf kjahdsgf kjashdgf kajshdgf kajshdgf kjahsgdf kjahsdg fkjahsdfg kjahsdgf kjhasdg fkjahsgf kjahsdgf kjhasdgf kjahsdgf kjashdgf kjahsdgf kjahsdgf kjahsgdf kjhsdgf d<br></div><div>Bouse dlkjhgf kjsdhgf kajhsdfg kjahsgdf kjhdgf kajhsdgf kjashdgf kjashdgf kjahdsgf kjashdgf kajshdgf kajshdgf kjahsgdf kjahsdg fkjahsdfg kjahsdgf kjhasdg fkjahsgf kjahsdgf kjhasdgf kjahsdgf kjashdgf kjahsdgf kjahsdgf kjahsgdf kjhsdgf d<br></div><div>Bouse dlkjhgf kjsdhgf kajhsdfg kjahsgdf kjhdgf kajhsdgf kjashdgf kjashdgf kjahdsgf kjashdgf kajshdgf kajshdgf kjahsgdf kjahsdg fkjahsdfg kjahsdgf kjhasdg fkjahsgf kjahsdgf kjhasdgf kjahsdgf kjashdgf kjahsdgf kjahsdgf kjahsgdf kjhsdgf d<br></div><div>Bouse dlkjhgf kjsdhgf kajhsdfg kjahsgdf kjhdgf kajhsdgf kjashdgf kjashdgf kjahdsgf kjashdgf kajshdgf kajshdgf kjahsgdf kjahsdg fkjahsdfg kjahsdgf kjhasdg fkjahsgf kjahsdgf kjhasdgf kjahsdgf kjashdgf kjahsdgf kjahsdgf kjahsgdf kjhsdgf d<br></div><div>Bouse dlkjhgf kjsdhgf kajhsdfg kjahsgdf kjhdgf kajhsdgf kjashdgf kjashdgf kjahdsgf kjashdgf kajshdgf kajshdgf kjahsgdf kjahsdg fkjahsdfg kjahsdgf kjhasdg fkjahsgf kjahsdgf kjhasdgf kjahsdgf kjashdgf kjahsdgf kjahsdgf kjahsgdf kjhsdgf d<br></div><div>Bouse dlkjhgf kjsdhgf kajhsdfg kjahsgdf kjhdgf kajhsdgf kjashdgf kjashdgf kjahdsgf kjashdgf kajshdgf kajshdgf kjahsgdf kjahsdg fkjahsdfg kjahsdgf kjhasdg fkjahsgf kjahsdgf kjhasdgf kjahsdgf kjashdgf kjahsdgf kjahsdgf kjahsgdf kjhsdgf d<br></div>	6	2012-11-05 23:26:19.052779	2012-11-05 23:27:37.291742	67	approved	t
42	8	8	1	2012-10-30 16:16:08.962446	2012-10-30 16:16:08.962446	\N	approved	t
43	8	9	1	2012-10-30 16:16:16.091781	2012-10-30 16:16:16.091781	\N	approved	t
44	8	10	1	2012-10-30 16:16:24.172944	2012-10-30 16:16:24.172944	\N	approved	t
69	10	hello	1	2012-11-07 22:32:58.175616	2012-11-07 22:32:58.175616	\N	approved	t
45	8	11	1	2012-10-30 16:16:31.659927	2012-10-30 16:16:31.659927	\N	approved	t
46	8	12	1	2012-10-30 16:16:38.969009	2012-10-30 16:16:38.969009	\N	approved	t
47	8	13	1	2012-10-30 16:16:46.667847	2012-10-30 16:16:46.667847	\N	approved	t
48	8	14	1	2012-10-30 16:16:54.6699	2012-10-30 16:16:54.6699	\N	approved	t
49	8	15	1	2012-10-30 16:17:02.517634	2012-10-30 16:17:02.517634	\N	approved	t
\.


--
-- Data for Name: forem_subscriptions; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY forem_subscriptions (id, subscriber_id, topic_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	3	9
10	1	10
11	6	11
\.


--
-- Data for Name: forem_topics; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY forem_topics (id, forum_id, user_id, subject, created_at, updated_at, locked, pinned, hidden, last_post_at, state, views_count) FROM stdin;
8	36	1	This is a long title dhfg jsdhfg jshdg fjshg dfjhgs djfhg sjdhfg jshdgf jshdgf fghdgf hdgf hd fhdgf hdg fhdg fhdgf hdgf dhfgdhf 	2012-10-10 22:53:36.0832	2012-11-08 20:26:44.039521	f	f	f	2012-10-10 22:53:36.120333	approved	100
10	29	1	Test	2012-10-30 21:13:46.133641	2012-11-08 20:42:33.721731	f	f	f	2012-10-30 21:13:46.167556	approved	78
4	28	1	Test	2012-07-01 07:45:10.980149	2012-10-30 14:12:32.680231	t	f	f	2012-07-01 07:45:11.048092	approved	42
6	28	1	Bouse	2012-07-04 21:18:50.364426	2012-10-31 23:09:53.492775	t	t	f	2012-07-04 21:18:50.467575	approved	21
9	36	3	hello	2012-10-30 14:13:39.011432	2012-11-04 12:07:46.640843	f	f	f	2012-10-30 14:13:39.067596	approved	23
11	29	6	Topic from blah updated	2012-11-04 14:30:53.849198	2012-11-04 21:24:33.616959	f	f	f	2012-11-04 14:30:53.879215	approved	7
7	30	1	test	2012-07-14 22:37:09.737546	2012-10-30 21:14:23.35482	t	f	f	2012-07-14 22:37:09.773123	approved	24
\.


--
-- Data for Name: forem_views; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY forem_views (id, user_id, viewable_id, created_at, updated_at, count, viewable_type, current_viewed_at, past_viewed_at) FROM stdin;
45	6	8	2012-11-04 14:47:41.725765	2012-11-04 14:48:03.64198	2	Forem::Topic	2012-11-04 14:47:41.725447	2012-11-04 14:47:41.725447
46	9	29	2012-11-04 21:24:22.691123	2012-11-04 21:24:22.709343	1	Forem::Forum	2012-11-04 21:24:22.690823	2012-11-04 21:24:22.690823
47	9	11	2012-11-04 21:24:24.602701	2012-11-04 21:24:33.605994	2	Forem::Topic	2012-11-04 21:24:24.602371	2012-11-04 21:24:24.602371
4	\N	1	2012-06-29 23:13:51.590025	2012-06-29 23:15:41.44823	2	Forem::Forum	2012-06-29 23:13:51.589721	2012-06-29 23:13:51.589721
11	1	31	2012-07-14 22:04:29.458937	2012-07-14 22:04:29.534036	1	Forem::Forum	2012-07-14 22:04:29.458641	2012-07-14 22:04:29.458641
2	1	1	2012-06-29 22:36:03.541793	2012-06-30 22:57:50.419383	54	Forem::Forum	2012-06-30 22:48:26.231668	2012-06-30 22:20:12.26245
5	1	3	2012-06-30 13:29:20.153287	2012-06-30 22:58:26.433759	45	Forem::Topic	2012-06-30 22:57:52.321902	2012-06-30 22:20:17.120376
33	3	29	2012-10-30 14:04:34.133054	2012-10-30 14:04:34.209112	1	Forem::Forum	2012-10-30 14:04:34.132726	2012-10-30 14:04:34.132726
25	5	28	2012-10-18 22:45:18.269619	2012-10-18 22:45:18.274932	1	Forem::Forum	2012-10-18 22:45:18.269337	2012-10-18 22:45:18.269337
14	2	7	2012-07-15 15:17:03.864013	2012-07-15 15:17:03.883243	1	Forem::Topic	2012-07-15 15:17:03.863711	2012-07-15 15:17:03.863711
26	5	6	2012-10-18 22:45:31.201104	2012-10-18 22:45:31.204995	1	Forem::Topic	2012-10-18 22:45:31.200811	2012-10-18 22:45:31.200811
27	5	37	2012-10-18 22:47:02.907265	2012-10-18 22:47:02.912649	1	Forem::Forum	2012-10-18 22:47:02.906955	2012-10-18 22:47:02.906955
28	5	36	2012-10-18 22:47:31.991305	2012-10-18 22:47:31.995528	1	Forem::Forum	2012-10-18 22:47:31.991011	2012-10-18 22:47:31.991011
29	5	8	2012-10-18 22:47:36.826263	2012-10-18 22:47:36.830553	1	Forem::Topic	2012-10-18 22:47:36.825972	2012-10-18 22:47:36.825972
16	2	32	2012-07-15 15:19:29.832496	2012-07-15 15:22:56.111955	2	Forem::Forum	2012-07-15 15:19:29.832224	2012-07-15 15:19:29.832224
3	1	2	2012-06-29 22:36:35.512922	2012-06-30 17:04:44.679599	2	Forem::Topic	2012-06-30 17:04:44.6789	2012-06-29 22:36:35.512633
17	2	29	2012-07-15 15:19:33.029575	2012-07-15 15:23:03.389555	2	Forem::Forum	2012-07-15 15:19:33.029269	2012-07-15 15:19:33.029269
1	1	1	2012-06-29 22:34:58.311389	2012-06-30 17:05:04.6434	2	Forem::Topic	2012-06-30 17:05:04.6427	2012-06-29 22:34:58.311095
18	2	34	2012-07-15 15:23:07.370799	2012-07-15 15:23:07.37416	1	Forem::Forum	2012-07-15 15:23:07.370483	2012-07-15 15:23:07.370483
15	2	28	2012-07-15 15:19:08.002777	2012-07-15 15:23:14.423057	3	Forem::Forum	2012-07-15 15:19:08.002299	2012-07-15 15:19:08.002299
19	2	4	2012-07-15 15:25:03.724443	2012-07-15 15:25:03.727228	1	Forem::Topic	2012-07-15 15:25:03.72414	2012-07-15 15:25:03.72414
37	3	6	2012-10-30 14:12:21.366912	2012-10-30 14:12:21.370869	1	Forem::Topic	2012-10-30 14:12:21.36663	2012-10-30 14:12:21.36663
20	2	6	2012-07-15 15:25:31.646476	2012-07-15 15:26:19.051202	2	Forem::Topic	2012-07-15 15:25:31.646193	2012-07-15 15:25:31.646193
34	3	5	2012-10-30 14:04:36.610586	2012-10-30 14:12:26.626491	2	Forem::Topic	2012-10-30 14:04:36.610309	2012-10-30 14:04:36.610309
21	1	36	2012-10-10 22:53:09.240008	2012-10-31 22:12:03.785673	8	Forem::Forum	2012-10-31 22:12:03.784185	2012-10-30 17:47:16.593309
24	5	5	2012-10-18 22:30:30.624021	2012-10-18 22:52:08.028772	5	Forem::Topic	2012-10-18 22:50:09.085439	2012-10-18 22:30:30.623739
23	5	29	2012-10-18 22:30:20.143994	2012-10-18 22:52:14.665132	5	Forem::Forum	2012-10-18 22:50:05.318602	2012-10-18 22:30:20.143679
38	3	4	2012-10-30 14:12:32.667044	2012-10-30 14:12:32.671293	1	Forem::Topic	2012-10-30 14:12:32.666728	2012-10-30 14:12:32.666728
30	4	39	2012-10-18 23:28:05.627077	2012-10-18 23:28:05.632578	1	Forem::Forum	2012-10-18 23:28:05.626753	2012-10-18 23:28:05.626753
31	4	8	2012-10-18 23:28:12.08599	2012-10-18 23:28:12.089933	1	Forem::Topic	2012-10-18 23:28:12.0857	2012-10-18 23:28:12.0857
39	3	7	2012-10-30 14:12:39.096279	2012-10-30 14:12:39.100046	1	Forem::Topic	2012-10-30 14:12:39.096008	2012-10-30 14:12:39.096008
22	1	8	2012-10-10 22:53:36.261539	2012-11-08 20:26:44.044614	88	Forem::Topic	2012-11-08 20:26:44.043229	2012-11-04 14:48:35.203976
32	4	37	2012-10-18 23:35:50.029655	2012-10-18 23:35:50.033805	1	Forem::Forum	2012-10-18 23:35:50.02937	2012-10-18 23:35:50.02937
35	3	36	2012-10-30 14:04:51.88756	2012-10-30 14:13:29.945767	3	Forem::Forum	2012-10-30 14:04:51.887271	2012-10-30 14:04:51.887271
42	1	10	2012-10-30 21:13:46.347174	2012-11-08 20:42:33.766547	76	Forem::Topic	2012-11-08 20:42:33.764537	2012-11-08 20:11:26.217393
48	6	10	2012-11-05 23:26:09.108993	2012-11-05 23:26:21.867288	2	Forem::Topic	2012-11-05 23:26:09.108608	2012-11-05 23:26:09.108608
36	3	8	2012-10-30 14:04:53.593102	2012-10-30 14:18:22.863223	8	Forem::Topic	2012-10-30 14:04:53.592819	2012-10-30 14:04:53.592819
40	3	9	2012-10-30 14:13:39.14869	2012-10-30 14:20:14.665346	5	Forem::Topic	2012-10-30 14:13:39.148354	2012-10-30 14:13:39.148354
10	1	6	2012-07-04 21:18:50.611414	2012-10-31 23:09:53.499305	17	Forem::Topic	2012-10-31 23:09:53.497483	2012-10-31 21:52:58.802124
7	1	4	2012-07-01 07:45:11.162293	2012-10-26 11:32:10.566779	40	Forem::Topic	2012-10-26 11:31:49.693123	2012-10-16 22:21:55.210261
41	1	9	2012-10-30 15:24:54.132139	2012-11-04 12:07:46.648254	18	Forem::Topic	2012-11-04 12:07:46.646475	2012-10-31 22:21:41.30695
6	1	28	2012-07-01 07:44:41.225779	2012-10-30 21:09:24.133106	33	Forem::Forum	2012-10-30 21:09:24.131382	2012-10-30 17:26:35.494114
43	6	29	2012-11-04 14:30:26.202808	2012-11-04 14:30:26.234	1	Forem::Forum	2012-11-04 14:30:26.202531	2012-11-04 14:30:26.202531
9	1	5	2012-07-02 21:36:57.81983	2012-10-30 21:13:09.679606	70	Forem::Topic	2012-10-30 21:09:50.123734	2012-10-30 20:48:41.153029
8	1	29	2012-07-02 21:27:34.605377	2012-11-07 23:14:52.561635	18	Forem::Forum	2012-11-07 23:14:52.557816	2012-11-05 23:17:28.831827
44	6	11	2012-11-04 14:30:53.994716	2012-11-04 14:47:32.882492	5	Forem::Topic	2012-11-04 14:46:06.07491	2012-11-04 14:30:53.994419
12	1	30	2012-07-14 22:36:55.295516	2012-10-30 21:14:21.394589	5	Forem::Forum	2012-10-30 21:14:21.393103	2012-10-30 17:28:29.379298
13	1	7	2012-07-14 22:37:10.006574	2012-10-30 21:14:23.359803	22	Forem::Topic	2012-10-30 21:14:23.358417	2012-10-30 15:25:00.386283
\.


--
-- Data for Name: replays; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY replays (id, title, description, protoss, zerg, terran, players, league, category_id, created_at, updated_at, replay_file, user_id, status, expires_at, average_rating) FROM stdin;
2	2		f	f	f	2v2	silver	16	2012-07-11 22:13:16.418855	2012-07-25 22:13:16.420451	Good_zerg_win.SC2Replay	1	new	2012-08-08 21:13:12.936629	0
3	3	3	f	f	f	2v2	bronze	17	2012-07-11 22:13:16.422131	2012-07-25 22:13:16.423216	Good_zerg_win.SC2Replay	1	new	2012-08-08 21:13:25.224131	0
4	4	4	f	f	f	2v2	silver	17	2012-07-25 22:13:45.701214	2012-07-25 22:13:45.701214	Good_zerg_win.SC2Replay	1	new	2012-08-08 22:13:45.697436	0
5	5	5	f	f	f	2v2	silver	16	2012-07-25 22:13:57.040639	2012-07-25 22:13:57.040639	Good_zerg_win.SC2Replay	1	new	2012-08-08 22:13:57.037015	0
6	6	6	f	f	f	1v1	silver	16	2012-07-25 22:14:09.325952	2012-07-25 22:14:09.325952	Good_zerg_win.SC2Replay	1	new	2012-08-08 22:14:09.323386	0
1	Test	test	t	t	f	1v1	bronze	16	2012-07-11 22:13:16.347951	2012-10-14 19:15:46.506668	Good_zerg_win.SC2Replay	1	new	2012-08-05 13:17:57.144005	1.5714285714285714
7	Test	blah	t	f	t	4v4	bronze	16	2012-10-14 21:12:37.458735	2012-10-16 23:27:14.917009	Good_zerg_win.SC2Replay	1	new	2012-10-28 21:12:37.454853	2.5
8	1234	123	t	f	t	FFA	platinum	16	2012-10-17 21:39:13.514698	2012-10-30 14:04:19.992145	Good_zerg_win.SC2Replay	1	new	2012-10-31 21:39:13.510127	1.5
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY schema_migrations (version) FROM stdin;
20120621214240
20120513155729
20120520125056
20120520213352
20120526200533
20120527184341
20120527184534
20120527192552
20120527194408
20120530144142
20120604220211
20120605140015
20120605144636
20120629215039
20120629215040
20120629215041
20120629215042
20120629215043
20120629215044
20120629215045
20120629215046
20120629215047
20120629215048
20120629215049
20120629215050
20120629215051
20120629215052
20120629215053
20120629215054
20120629215055
20120629215056
20120629215057
20120629215058
20120629215059
20120629215060
20120629215061
20120629215062
20120629215063
20120629215064
20120629215065
20120629215066
20121026095459
20121030171508
20121105223648
20121107231041
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: lagtv
--

COPY users (id, name, email, password_digest, created_at, updated_at, role, active, auth_token, password_reset_token, forem_admin, forem_state, last_viewed_all_at, signature, show_signature, hide_others_signatures) FROM stdin;
5	bob	bob3@sc2.com	$2a$10$MCrtJuWo6qWqRVf5ERO4KubenI7Wu83YSqovyU/EqwYEL1CeZ7/ta	2012-10-14 14:47:40.986966	2012-11-02 20:03:59.556742	community_manager	t	bfKKk7gsLLZ9eB4p11dqiQ	\N	t	approved	\N	\N	t	f
2	Andy3	andy.pike.mail@gmail.com	$2a$10$sKGhFTkhKVt11i0i35Q7fulWJ7PdZY9WtMQAC.q5aFOXv5.ukNvx2	2012-07-15 15:16:56.845884	2012-07-25 22:43:44.576217	member	t	Dz_4zBEwTKFCXQD5g6o7Ig	\N	f	approved	\N	\N	t	f
3	hgfdhgfd	bob@sc2.com	$2a$10$SsYFtFoOvkBaLFQYD9ZAK.NZxkwKwapOLtsysJB3lLAbDvRLCyTce	2012-10-14 14:46:07.920651	2012-11-04 13:51:05.070139	analyst	t	vfZTLpWo0DvoiIFoIbz5Vw	\N	f	approved	\N	\N	t	f
9	blackmamba2	blah4@gmail.com	$2a$10$rr6bgaAfZepOvde3QkvqUucZhuk/dD9k9qza0fCSnOxbiRVnw//ke	2012-11-04 12:53:14.153538	2012-11-04 19:41:54.05945	dev_team	t	HgaP7Shey7ECSaTAgtjwlw	\N	t	approved	\N	\N	t	f
7	234	234@34234.com	$2a$10$Qf5CGH6Md6oMubwINTmf3.WB0tBWCxOgwLjvXHPFnCgjRgxwmrYbi	2012-10-24 20:54:34.057051	2012-10-27 21:31:32.33138	member	t	u9YdRAaZDGDeDdq-wDk5dQ	\N	f	approved	\N	\N	t	f
4	bob	bob2@sc2.com	$2a$10$OUODmdxsVOiZSpJJnrjtguGxA5D3zSNrPXHDnjVG9zZDkcfQj8Jgu	2012-10-14 14:46:56.836414	2012-11-02 20:03:53.4686	moderator	t	AHchIAK5QweyPDXTw9rSuA	\N	t	approved	\N	\N	t	f
6	blah_updated	blah_updated@blah.com	$2a$10$RAiyNyWxKEXc0VkFm2TDA.FLBc4nwrCbCMOQKNq2V/sPo5OT7Steq	2012-10-24 20:51:52.45947	2012-11-05 23:26:51.311366	member	t	mUXeaVWEsRrlbZ83XDTDgQ	\N	f	approved	\N	This is a sig :o)	f	f
1	Andy	andy@andypike.com	$2a$10$MkNrBBanyfvO/3gTXO1RBuyKwhxt9.Y3thdamkfw5VkGznGHmRP9W	2012-06-29 21:54:12.393756	2012-11-08 20:18:05.58068	admin	t	IHSIQbnHv_h6yJU6jZ10TA	\N	t	approved	2012-10-31 22:47:31	<img src="http://i.imgur.com/atCRc.gif" alt="" align="left"><br><div><br></div>	t	f
8	blah2	blah2@gmail.com	$2a$10$ui5T3nxWt4wRL10pU1J9AuEeiqmdOyl/jH8k1SQpgeoDbw1KPqyQq	2012-11-04 12:52:36.0669	2012-11-08 23:02:46.939941	member	t	Vthn2u_6YAgmoqHpoxzXOw	\N	f	approved	\N	<br>	t	f
\.


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: forem_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY forem_categories
    ADD CONSTRAINT forem_categories_pkey PRIMARY KEY (id);


--
-- Name: forem_forums_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY forem_forums
    ADD CONSTRAINT forem_forums_pkey PRIMARY KEY (id);


--
-- Name: forem_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY forem_groups
    ADD CONSTRAINT forem_groups_pkey PRIMARY KEY (id);


--
-- Name: forem_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY forem_memberships
    ADD CONSTRAINT forem_memberships_pkey PRIMARY KEY (id);


--
-- Name: forem_moderator_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY forem_moderator_groups
    ADD CONSTRAINT forem_moderator_groups_pkey PRIMARY KEY (id);


--
-- Name: forem_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY forem_posts
    ADD CONSTRAINT forem_posts_pkey PRIMARY KEY (id);


--
-- Name: forem_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY forem_subscriptions
    ADD CONSTRAINT forem_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: forem_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY forem_topics
    ADD CONSTRAINT forem_topics_pkey PRIMARY KEY (id);


--
-- Name: forem_views_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY forem_views
    ADD CONSTRAINT forem_views_pkey PRIMARY KEY (id);


--
-- Name: replays_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY replays
    ADD CONSTRAINT replays_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: lagtv; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_forem_groups_on_name; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_groups_on_name ON forem_groups USING btree (name);


--
-- Name: index_forem_memberships_on_group_id; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_memberships_on_group_id ON forem_memberships USING btree (group_id);


--
-- Name: index_forem_moderator_groups_on_forum_id; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_moderator_groups_on_forum_id ON forem_moderator_groups USING btree (forum_id);


--
-- Name: index_forem_posts_on_reply_to_id; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_posts_on_reply_to_id ON forem_posts USING btree (reply_to_id);


--
-- Name: index_forem_posts_on_state; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_posts_on_state ON forem_posts USING btree (state);


--
-- Name: index_forem_posts_on_topic_id; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_posts_on_topic_id ON forem_posts USING btree (topic_id);


--
-- Name: index_forem_posts_on_user_id; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_posts_on_user_id ON forem_posts USING btree (user_id);


--
-- Name: index_forem_topics_on_forum_id; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_topics_on_forum_id ON forem_topics USING btree (forum_id);


--
-- Name: index_forem_topics_on_state; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_topics_on_state ON forem_topics USING btree (state);


--
-- Name: index_forem_topics_on_user_id; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_topics_on_user_id ON forem_topics USING btree (user_id);


--
-- Name: index_forem_views_on_topic_id; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_views_on_topic_id ON forem_views USING btree (viewable_id);


--
-- Name: index_forem_views_on_updated_at; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_views_on_updated_at ON forem_views USING btree (updated_at);


--
-- Name: index_forem_views_on_user_id; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE INDEX index_forem_views_on_user_id ON forem_views USING btree (user_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: lagtv; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: brewster
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM brewster;
GRANT ALL ON SCHEMA public TO brewster;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

