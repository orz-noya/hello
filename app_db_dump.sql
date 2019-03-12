--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Debian 10.5-1.pgdg90+1)
-- Dumped by pg_dump version 10.5 (Debian 10.5-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: machine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machine (
    id double precision NOT NULL,
    type text,
    name text,
    cost double precision,
    memo text
);


ALTER TABLE public.machine OWNER TO postgres;

--
-- Name: pj_dup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pj_dup (
    id double precision,
    name text,
    pref text,
    work text,
    type text,
    typejp text,
    term double precision,
    quantity double precision,
    area double precision,
    category text,
    worker text,
    workerjp text
);


ALTER TABLE public.pj_dup OWNER TO postgres;

--
-- Name: pj_dup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pj_dup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pj_dup_id_seq OWNER TO postgres;

--
-- Name: pj_dup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pj_dup_id_seq OWNED BY public.pj_dup.id;


--
-- Name: project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project (
    id double precision NOT NULL,
    name text,
    pref text,
    work text,
    type text,
    typejp text,
    term double precision,
    quantity double precision,
    area double precision,
    category text,
    worker text,
    workerjp text
);


ALTER TABLE public.project OWNER TO postgres;

--
-- Name: relma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relma (
    pjid double precision,
    maid double precision
);


ALTER TABLE public.relma OWNER TO postgres;

--
-- Name: pjmachines; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.pjmachines AS
 SELECT DISTINCT project.category,
    project.work,
    machine.id,
    machine.type,
    machine.name,
    machine.cost,
    machine.memo
   FROM ((public.project
     JOIN public.relma ON ((project.id = relma.pjid)))
     JOIN public.machine ON ((machine.id = relma.maid)));


ALTER TABLE public.pjmachines OWNER TO postgres;

--
-- Name: reltr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reltr (
    pjid double precision,
    trid double precision
);


ALTER TABLE public.reltr OWNER TO postgres;

--
-- Name: trouble; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trouble (
    id double precision NOT NULL,
    workjp text,
    operationjp text,
    work text,
    operation text,
    trouble text,
    detailcause text
);


ALTER TABLE public.trouble OWNER TO postgres;

--
-- Name: pjtroubles; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.pjtroubles AS
 SELECT DISTINCT project.name AS project,
    project.category,
    trouble.id,
    trouble.workjp,
    trouble.operationjp,
    trouble.work,
    trouble.operation,
    trouble.trouble,
    trouble.detailcause
   FROM ((public.project
     JOIN public.reltr ON ((project.id = reltr.pjid)))
     JOIN public.trouble ON (((trouble.id = reltr.trid) AND (trouble.work = project.work))));


ALTER TABLE public.pjtroubles OWNER TO postgres;

--
-- Name: postgrest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.postgrest (
    hoge integer,
    piyo integer
);


ALTER TABLE public.postgrest OWNER TO postgres;

--
-- Name: project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_id_seq OWNER TO postgres;

--
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.project_id_seq OWNED BY public.project.id;


--
-- Name: reltr_dup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reltr_dup (
    pjid double precision,
    trid double precision
);


ALTER TABLE public.reltr_dup OWNER TO postgres;

--
-- Name: tablename_colname_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tablename_colname_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tablename_colname_seq OWNER TO postgres;

--
-- Name: test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test (
    hoge integer,
    piyo integer
);


ALTER TABLE public.test OWNER TO postgres;

--
-- Name: w; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.w (
    id integer NOT NULL,
    worker character varying(32),
    operation character varying(32),
    loaddays real,
    unitcost integer
);


ALTER TABLE public.w OWNER TO postgres;

--
-- Name: w2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.w2 (
    id double precision,
    worker text,
    operation text,
    capita double precision,
    volume double precision,
    unitcost double precision
);


ALTER TABLE public.w2 OWNER TO postgres;

--
-- Name: w_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.w_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.w_id_seq OWNER TO postgres;

--
-- Name: w_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.w_id_seq OWNED BY public.w.id;


--
-- Name: work; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.work (
    id double precision,
    workjp text,
    typejp text,
    workerjp text,
    operationjp text,
    work text,
    type text,
    worker text,
    operation text,
    areamin double precision,
    areamax double precision,
    capita double precision,
    volumegrad double precision,
    volumeseg double precision,
    unitcost double precision,
    expensetype text,
    isict boolean
);


ALTER TABLE public.work OWNER TO postgres;

--
-- Name: workers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workers (
    v character varying(64),
    name character varying(64)
);


ALTER TABLE public.workers OWNER TO postgres;

--
-- Name: workfull; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.workfull AS
 SELECT DISTINCT project.id,
    project.name,
    project.pref,
    project.work,
    project.type,
    project.typejp,
    project.term,
    project.quantity,
    project.area,
    project.category,
    project.worker,
    project.workerjp,
    machine.machinetype,
    machine.machinename,
    machine.cost,
    trouble.operation,
    trouble.operationjp,
    trouble.trouble,
    trouble.detailcause
   FROM ((((public.project
     JOIN public.relma ON ((project.id = relma.pjid)))
     JOIN ( SELECT machine_1.id,
            machine_1.type AS machinetype,
            machine_1.name AS machinename,
            machine_1.cost
           FROM public.machine machine_1) machine ON ((relma.maid = machine.id)))
     JOIN public.reltr ON ((project.id = reltr.pjid)))
     JOIN ( SELECT trouble_1.id,
            trouble_1.work,
            trouble_1.operation,
            trouble_1.operationjp,
            trouble_1.trouble,
            trouble_1.detailcause
           FROM public.trouble trouble_1) trouble ON (((reltr.trid = trouble.id) AND (project.work = trouble.work))));


ALTER TABLE public.workfull OWNER TO postgres;

--
-- Name: pj_dup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pj_dup ALTER COLUMN id SET DEFAULT nextval('public.pj_dup_id_seq'::regclass);


--
-- Name: project id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project ALTER COLUMN id SET DEFAULT nextval('public.project_id_seq'::regclass);


--
-- Name: w id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.w ALTER COLUMN id SET DEFAULT nextval('public.w_id_seq'::regclass);


--
-- Data for Name: machine; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.machine (id, type, name, cost, memo) FROM stdin;
1	ドローン	Inspire1	49000	\N
2	ドローン	Inspire2	40000	\N
3	ドローン	Phantorn4Pro	13000	\N
4	ドローン	eBee	45000	固定翼
5	ドローン	QC730	90000	回転翼
6	ドローン	Explore1	159200	\N
7	ドローン	UX5	-1	固定翼
8	基地局	トリンプル	70000	\N
9	MCバックホウ	コマツPC200i	730000	\N
10	MCバックホウ	日立ZX200	-1	\N
11	MCバックホウ	コマツPC120i	324800	\N
12	MCブルドーザ	コマツD61PXi	840000	\N
13	MCブルドーザ	D6	-1	\N
14	バックホウＭＧシステム	トリンプル	30000	\N
15	バックホウＭＧシステム	ＭＯＢＡ	88000	\N
16	ＭＧロードローラ	サカイＳＶ５１３Ｄ	470000	\N
17	ロードローラＭＧシステム(転圧管理)	ジオサーフ ＫＴ－０６０１２ 	162500	\N
18	ロードローラＭＧシステム(転圧管理)	αシステム	-1	\N
19	ロードローラＭＧシステム(転圧管理)	トリンプルSiteCompact	-1	\N
20	点群ソフト	Pix4D	-1	写真測量ソフトの上位版、カメラキャリブレーション不要で高精度なオルソモザイクを作成可能。基準点をより厳密に管理でき、より詳細な品質レポートを作成
21	点群ソフト	ビジネスセンターフォト	-1	\N
22	点群ソフト	Photoscan	13000	\N
23	点群ソフト	EdgeBox	-1	\N
24	点群ソフト	Trendpoint	50000	福井コンピュータの点群処理ソフトウェア　ノイズ処理から縦横断、等高線、体積計算等の基本機能が充実。同社のCADとの連携機能も搭載
\.


--
-- Data for Name: pj_dup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pj_dup (id, name, pref, work, type, typejp, term, quantity, area, category, worker, workerjp) FROM stdin;
1	平底トンネル	宮崎県	measure	setup	起工	-1	0	0.5	A	other	コマツレンタル
2	安中造成	群馬県	measure	setup	起工	-1	0	93	D	other	セクトコンサルタント
3	金沢処分場	石川県	measure	setup	起工	-1	0	72	D	self	作業所
4	甲斐太陽光	山梨県	measure	setup	起工	-1	0	30	B	other	ジオサーフ
5	減容化	福島県	measure	setup	起工	-1	0	5.70000000000000018	A	other	テトラﾄﾞﾛｰﾝ
6	UR双葉	福島県	measure	setup	起工	-1	0	23	B	other	テトラﾄﾞﾛｰﾝ
7	双葉防潮堤	福島県	measure	setup	起工	-1	0	5	A	other	？
8	尾鷲第四トンネル	三重県	measure	setup	起工	-1	0	1	A	other	きんそく
9	新丸山ダム	岐阜県	measure	setup	起工	-1	0	0.75	A	other	？
10	赤磐造成	岡山県	measure	setup	起工	-1	0	26	B	other	宮本組
11	鹿屋大崎	鹿児島県	measure	partial	工事中	-1	0	5.75	E	self	作業所
12	金沢処分場	石川県	measure	partial	工事中	-1	0	72	E	self	作業所
13	内ヶ谷ダム	岐阜県	measure	partial	工事中	-1	0	5.5	E	self	作業所
14	新丸山ダム	岐阜県	measure	partial	工事中	-1	0	0.75	E	self	作業所
15	鵜川ダム	新潟県	measure	check	出来高	-1	0	0.5	F	self	作業所
16	双葉防潮堤	福島県	measure	check	出来高	-1	0	5	E	self	作業所
17	平底トンネル	宮崎県	measure	confirm	出来形	-1	0	0.5	F	other	コマツレンタル
18	南貞山	宮城県	measure	confirm	出来形	-1	0	45	E	other	？
19	新丸山ダム	岐阜県	measure	confirm	出来形	-1	0	0.0350000000000000033	F	other	？
20	秦野西	神奈川県	measure	confirm	出来形	-1	0	7.5	E	other	ジオサーフ
21	平底トンネル	宮崎県	construct	cut	切土	38	400	400	A	other	N/A
22	鹿屋大崎	鹿児島県	construct	cut	切土	24	9290	3000	A	self	作業所
23	南貞山	宮城県	construct	cut	切土	31.5	2634	4676	A	other	N/A
24	安中造成	群馬県	construct	cut	切土	19.5	130000	50000	A	other	N/A
25	鵜川ダム	新潟県	construct	cut	切土	240	20000	800	A	self	作業所
26	金沢処分場	石川県	construct	cut	切土	42	60000	6000	A	self	作業所
27	甲斐太陽光	山梨県	construct	cut	切土	30	100000	0	A	other	N/A
28	内ヶ谷ダム	岐阜県	construct	cut	切土	87	10000	30000	A	self	作業所
29	新丸山ダム	岐阜県	construct	cut	切土	30	8000	1000	A	other	N/A
30	秦野西	神奈川県	construct	cut	切土	77	-1	50	A	other	N/A
31	安中造成	群馬県	construct	heap	盛土	19.5	130000	0	A	other	N/A
32	金沢処分場	石川県	construct	heap	盛土	42	40000	3000	A	other	N/A
33	甲斐太陽光	山梨県	construct	heap	盛土	30	100000	4500	A	self	作業所
34	中間貯蔵	福島県	construct	heap	盛土	33.5	1000	8000	A	other	N/A
35	双葉防潮堤	福島県	construct	heap	盛土	31	12000	12800	A	other	N/A
36	新丸山ダム	岐阜県	construct	heap	盛土	30	15000	45000	A	other	N/A
37	減容化	福島県	construct	heap	盛土	36	30000	15000	A	self	作業所
39	hogetaro	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
40	hogetaro	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
41	hogetaro	都道府県	measure	setup	起工測量	2	0	10	A	self	作業所
42		都道府県	measure	setup	起工測量	\N	0	\N	D	self	作業所
43		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
44		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
45		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
46		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
47		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
48		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
49		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
50		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
51		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
52		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
53		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
54		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
55		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
56		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
57		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
58		都道府県	measure	setup	起工測量	\N	0	0	A	self	作業所
\.


--
-- Data for Name: postgrest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.postgrest (hoge, piyo) FROM stdin;
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project (id, name, pref, work, type, typejp, term, quantity, area, category, worker, workerjp) FROM stdin;
1	平底トンネル	宮崎県	measure	setup	起工	-1	0	0.5	A	other	コマツレンタル
2	安中造成	群馬県	measure	setup	起工	-1	0	93	D	other	セクトコンサルタント
3	金沢処分場	石川県	measure	setup	起工	-1	0	72	D	self	作業所
4	甲斐太陽光	山梨県	measure	setup	起工	-1	0	30	B	other	ジオサーフ
5	減容化	福島県	measure	setup	起工	-1	0	5.70000000000000018	A	other	テトラﾄﾞﾛｰﾝ
6	UR双葉	福島県	measure	setup	起工	-1	0	23	B	other	テトラﾄﾞﾛｰﾝ
7	双葉防潮堤	福島県	measure	setup	起工	-1	0	5	A	other	？
8	尾鷲第四トンネル	三重県	measure	setup	起工	-1	0	1	A	other	きんそく
9	新丸山ダム	岐阜県	measure	setup	起工	-1	0	0.75	A	other	？
10	赤磐造成	岡山県	measure	setup	起工	-1	0	26	B	other	宮本組
11	鹿屋大崎	鹿児島県	measure	partial	工事中	-1	0	5.75	E	self	作業所
12	金沢処分場	石川県	measure	partial	工事中	-1	0	72	E	self	作業所
13	内ヶ谷ダム	岐阜県	measure	partial	工事中	-1	0	5.5	E	self	作業所
14	新丸山ダム	岐阜県	measure	partial	工事中	-1	0	0.75	E	self	作業所
15	鵜川ダム	新潟県	measure	check	出来高	-1	0	0.5	F	self	作業所
16	双葉防潮堤	福島県	measure	check	出来高	-1	0	5	E	self	作業所
17	平底トンネル	宮崎県	measure	confirm	出来形	-1	0	0.5	F	other	コマツレンタル
18	南貞山	宮城県	measure	confirm	出来形	-1	0	45	E	other	？
19	新丸山ダム	岐阜県	measure	confirm	出来形	-1	0	0.0350000000000000033	F	other	？
20	秦野西	神奈川県	measure	confirm	出来形	-1	0	7.5	E	other	ジオサーフ
21	平底トンネル	宮崎県	construct	cut	切土	38	400	400	A	other	N/A
22	鹿屋大崎	鹿児島県	construct	cut	切土	24	9290	3000	A	self	作業所
23	南貞山	宮城県	construct	cut	切土	31.5	2634	4676	A	other	N/A
24	安中造成	群馬県	construct	cut	切土	19.5	130000	50000	A	other	N/A
25	鵜川ダム	新潟県	construct	cut	切土	240	20000	800	A	self	作業所
26	金沢処分場	石川県	construct	cut	切土	42	60000	6000	A	self	作業所
27	甲斐太陽光	山梨県	construct	cut	切土	30	100000	0	A	other	N/A
28	内ヶ谷ダム	岐阜県	construct	cut	切土	87	10000	30000	A	self	作業所
29	新丸山ダム	岐阜県	construct	cut	切土	30	8000	1000	A	other	N/A
30	秦野西	神奈川県	construct	cut	切土	77	-1	50	A	other	N/A
31	安中造成	群馬県	construct	heap	盛土	19.5	130000	0	A	other	N/A
32	金沢処分場	石川県	construct	heap	盛土	42	40000	3000	A	other	N/A
33	甲斐太陽光	山梨県	construct	heap	盛土	30	100000	4500	A	self	作業所
34	中間貯蔵	福島県	construct	heap	盛土	33.5	1000	8000	A	other	N/A
35	双葉防潮堤	福島県	construct	heap	盛土	31	12000	12800	A	other	N/A
36	新丸山ダム	岐阜県	construct	heap	盛土	30	15000	45000	A	other	N/A
37	減容化	福島県	construct	heap	盛土	36	30000	15000	A	self	作業所
40	Project A	都道府県	measure	setup	起工測量	2	0	50	C	self	作業所
41	Project B	東京都	measure	setup	起工測量	2	0	40	C	self	作業所
42		岩手県	construct	setup	起工測量	\N	0	0	A	self	作業所
43		岩手県	construct	setup	起工測量	\N	0	0	A	self	作業所
44			\N	setup	起工測量	\N	0	0	A	\N	
45	テスト		\N	partial	工事中測量	1	\N	\N	F	\N	
46	テスト		\N	partial	工事中測量	1	\N	\N	F	\N	
47	テスト		\N	partial	工事中測量	1	\N	\N	F	\N	
48	テスト		\N	partial	工事中測量	1	\N	\N	F	\N	
49	飯田橋		\N	setup	起工測量	1	1000	100	D	\N	
50	飯田橋		\N	setup	起工測量	1	1000	100	D	\N	
51	飯田橋		\N	setup	起工測量	2	100	100	D	\N	
52	飯田橋		\N	setup	起工測量	2	100	100	D	\N	
53			\N	setup	起工測量	\N	0	0	A	\N	
\.


--
-- Data for Name: relma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.relma (pjid, maid) FROM stdin;
2	4
2	20
3	7
3	21
4	3
5	2
5	22
5	24
6	2
7	6
7	23
8	5
8	22
8	24
9	5
9	22
9	24
10	2
10	22
10	24
11	3
11	22
11	24
12	7
12	21
13	1
13	22
14	1
14	22
14	24
15	2
15	22
16	6
16	23
19	1
19	22
19	24
20	4
40	2
40	20
40	21
41	2
41	18
45	4
45	16
46	4
46	16
47	4
47	16
47	6
47	22
48	4
48	16
48	6
48	22
50	16
51	22
52	22
52	24
\.


--
-- Data for Name: reltr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reltr (pjid, trid) FROM stdin;
1	72
2	72
2	76
3	66
3	72
3	73
3	74
4	78
6	52
7	4
7	35
7	74
7	79
7	82
8	82
10	26
10	33
11	3
11	20
11	30
11	52
11	61
11	76
13	17
13	20
13	26
13	28
13	29
13	30
13	33
13	41
13	53
13	71
13	73
13	77
14	22
14	28
14	35
14	41
14	70
14	72
15	26
15	74
18	68
18	79
20	4
20	70
40	3
40	12
40	19
41	3
45	6
46	6
47	6
47	56
47	82
48	6
48	56
48	82
49	80
50	80
50	77
51	78
52	78
52	76
\.


--
-- Data for Name: reltr_dup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reltr_dup (pjid, trid) FROM stdin;
1	72
2	72
2	76
3	66
3	72
3	73
3	74
4	78
6	52
7	4
7	35
7	74
7	79
7	82
8	82
10	26
10	33
11	3
11	20
11	30
11	52
11	61
11	76
13	17
13	20
13	26
13	28
13	29
13	30
13	33
13	41
13	53
13	71
13	73
13	77
14	22
14	28
14	35
14	41
14	70
14	72
15	26
15	74
18	68
18	79
20	4
20	70
58	18
58	16
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test (hoge, piyo) FROM stdin;
\.


--
-- Data for Name: trouble; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trouble (id, workjp, operationjp, work, operation, trouble, detailcause) FROM stdin;
1	測量	ドローン撮影	measure	photo	ドローンが起動しない	バッテリーの故障
2	測量	ドローン撮影	measure	photo	ドローンが起動しない	ラジオ受信機の故障
3	測量	ドローン撮影	measure	photo	ドローンが起動しない	ドローン本体の故障
4	測量	ドローン撮影	measure	photo	ドローンが起動しない	その他
5	測量	ドローン撮影	measure	photo	ドローンが起動しない	原因不明
6	測量	ドローン撮影	measure	photo	ドローン飛行計画が飛行許可範囲を超えてしまう	飛行許可範囲の事前確認不足
7	測量	ドローン撮影	measure	photo	ドローン飛行計画が飛行許可範囲を超えてしまう	その他
8	測量	ドローン撮影	measure	photo	ドローン飛行計画が飛行許可範囲を超えてしまう	原因不明
9	測量	ドローン撮影	measure	photo	ドローンが飛行計画経路通りに移動しない	GNSS受信機の故障
10	測量	ドローン撮影	measure	photo	ドローンが飛行計画経路通りに移動しない	飛行計画経路のGNSSデータの間違い
11	測量	ドローン撮影	measure	photo	ドローンが飛行計画経路通りに移動しない	地形的問題(GNSSを受信しにくい)
12	測量	ドローン撮影	measure	photo	ドローンが飛行計画経路通りに移動しない	風等天候問題
13	測量	ドローン撮影	measure	photo	ドローンが飛行計画経路通りに移動しない	その他
14	測量	ドローン撮影	measure	photo	ドローンが飛行計画経路通りに移動しない	原因不明
15	測量	ドローン撮影	measure	photo	撮影ができない	メモリディスクの空き不足
16	測量	ドローン撮影	measure	photo	撮影ができない	ラジオ受信機の故障
17	測量	ドローン撮影	measure	photo	撮影ができない	その他
18	測量	ドローン撮影	measure	photo	撮影ができない	原因不明
19	測量	ドローン撮影	measure	photo	ドローンが墜落する	GNSS受信機の故障
20	測量	ドローン撮影	measure	photo	ドローンが墜落する	風等天候問題
21	測量	ドローン撮影	measure	photo	ドローンが墜落する	地形的問題(GNSSを受信しにくい)
22	測量	ドローン撮影	measure	photo	ドローンが墜落する	バッテリー切れ
23	測量	ドローン撮影	measure	photo	ドローンが墜落する	操縦ミス
24	測量	ドローン撮影	measure	photo	ドローンが墜落する	プロペラの故障
25	測量	ドローン撮影	measure	photo	ドローンが墜落する	ラジオ受信機の故障
26	測量	ドローン撮影	measure	photo	ドローンが墜落する	その他
27	測量	ドローン撮影	measure	photo	ドローンが墜落する	原因不明
28	測量	ドローン撮影	measure	photo	その他	（右の回答欄に記入）
29	測量	点群処理	measure	process	点群処理が失敗する	ラップ率が低い
30	測量	点群処理	measure	process	点群処理が失敗する	標定点数が不十分
31	測量	点群処理	measure	process	点群処理が失敗する	高低差が低い
32	測量	点群処理	measure	process	点群処理が失敗する	地表面が露呈していない（地表面が森林や雪などで覆われている等）
33	測量	点群処理	measure	process	点群処理が失敗する	標定点の測量ミス
34	測量	点群処理	measure	process	点群処理が失敗する	写真が鮮明ではない(暗い・ピンぼけ)
35	測量	点群処理	measure	process	点群処理が失敗する	その他
36	測量	点群処理	measure	process	点群処理が失敗する	原因不明
37	測量	点群処理	measure	process	点群処理の結果が現況と一致しない	ラップ率が低い
38	測量	点群処理	measure	process	点群処理の結果が現況と一致しない	標定点数が不十分
39	測量	点群処理	measure	process	点群処理の結果が現況と一致しない	標定点の測量ミス
40	測量	点群処理	measure	process	点群処理の結果が現況と一致しない	地表面が露呈していない（地表面が森林や雪などで覆われている等）
41	測量	点群処理	measure	process	点群処理の結果が現況と一致しない	その他
42	測量	点群処理	measure	process	点群処理の結果が現況と一致しない	原因不明
43	測量	点群処理	measure	process	標定点を設置したい場所に何らかの理由で設置できない	地盤が不安定
44	測量	点群処理	measure	process	標定点を設置したい場所に何らかの理由で設置できない	地表面が露呈していない（地表面が森林や草などで覆われている等）
45	測量	点群処理	measure	process	標定点を設置したい場所に何らかの理由で設置できない	複数視点から撮影することができない
46	測量	点群処理	measure	process	標定点を設置したい場所に何らかの理由で設置できない	設置作業困難区域
47	測量	点群処理	measure	process	標定点を設置したい場所に何らかの理由で設置できない	その他
48	測量	点群処理	measure	process	ラップ率が仕様を満たさない	計画間違い
49	測量	点群処理	measure	process	ラップ率が仕様を満たさない	写真が足りない（メモリ不足等）
50	測量	点群処理	measure	process	ラップ率が仕様を満たさない	その他
51	測量	点群処理	measure	process	ラップ率が仕様を満たさない	原因不明
52	測量	点群処理	measure	process	その他	（右の回答欄に記入）
53	測量	図面データの作成	measure	process	メッシュデータが現況と一致しない	点群処理の結果が現況と一致していない
54	測量	図面データの作成	measure	process	メッシュデータが現況と一致しない	その他
55	測量	図面データの作成	measure	process	メッシュデータが現況と一致しない	原因不明
56	測量	図面データの作成	measure	process	点群からメッシュデータを作成できない	PCスペック不足
57	測量	図面データの作成	measure	process	点群からメッシュデータを作成できない	その他
58	測量	図面データの作成	measure	process	点群からメッシュデータを作成できない	原因不明
59	測量	図面データの作成	measure	process	メッシュデータを図面仕様に加工できない	PCスペック不足
60	測量	図面データの作成	measure	process	メッシュデータを図面仕様に加工できない	その他
61	測量	図面データの作成	measure	process	メッシュデータを図面仕様に加工できない	原因不明
62	測量	図面データの作成	measure	process	その他	（右の回答欄に記入）
63	土工	図面の3D化	construction	3dmodel	3Dデータの作成が切土/盛土作業に間に合わない	３Dデータを確認できる人がいない
64	土工	図面の3D化	construction	3dmodel	3Dデータの作成が切土/盛土作業に間に合わない	その他
65	土工	図面の3D化	construction	3dmodel	3Dデータの作成が切土/盛土作業に間に合わない	原因不明
66	土工	図面の3D化	construction	3dmodel	3Dデータと測量データを比較できず、測量データが正確に3D化できたかどうか確認できない。	その他
67	土工	図面の3D化	construction	3dmodel	3Dデータと測量データを比較できず、測量データが正確に3D化できたかどうか確認できない。	原因不明
68	土工	図面の3D化	construction	3dmodel	3Dデータ中のGNSSデータ(緯度・経度・高度の情報)が現況と一致しない。	その他
69	土工	図面の3D化	construction	3dmodel	3Dデータ中のGNSSデータ(緯度・経度・高度の情報)が現況と一致しない。	原因不明
70	土工	切土作業	construction	cut	GNSSの信号を受信できない	GNSS受信機の故障
71	土工	切土作業	construction	cut	GNSSの信号を受信できない	地形的問題(GNSSを受信しにくい)
72	土工	切土作業	construction	cut	GNSSの信号を受信できない	その他
73	土工	切土作業	construction	cut	GNSSの信号を受信できない	原因不明
74	土工	切土作業	construction	cut	3Dデータ中のGNSSデータ（緯度・経度・高度の情報）は正しいが、作業現場で取得するGNSSデータと一致しない。	GNSS受信機の故障
75	土工	切土作業	construction	cut	3Dデータ中のGNSSデータ（緯度・経度・高度の情報）は正しいが、作業現場で取得するGNSSデータと一致しない。	GNSS標準誤差
76	土工	切土作業	construction	cut	3Dデータ中のGNSSデータ（緯度・経度・高度の情報）は正しいが、作業現場で取得するGNSSデータと一致しない。	その他
77	土工	切土作業	construction	cut	3Dデータ中のGNSSデータ（緯度・経度・高度の情報）は正しいが、作業現場で取得するGNSSデータと一致しない。	原因不明
78	土工	切土作業	construction	cut	従来の出来形の管理値からかい離する	その他
79	土工	切土作業	construction	cut	従来の出来形の管理値からかい離する	原因不明
80	土工	切土作業	construction	cut	転圧管理が現況と一致しない	その他
81	土工	切土作業	construction	cut	転圧管理が現況と一致しない	原因不明
82	土工	切土作業	construction	cut	その他	（右の回答欄に記入）
\.


--
-- Data for Name: w; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.w (id, worker, operation, loaddays, unitcost) FROM stdin;
1	drone_other	 plan 	2	100000
2	drone_other	 photo 	6	100000
3	drone_other	 process 	2	100000
4	drone_self	 plan 	2	100000
5	drone_self	 photo 	8	60000
6	drone_self	 process 	2	60000
7	conventional	 plan 	4	100000
8	conventional	 measure 	8	100000
\.


--
-- Data for Name: w2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.w2 (id, worker, operation, capita, volume, unitcost) FROM stdin;
1	drone_other	計画	2	2	70000
2	drone_other	撮影	2	6	70000
3	drone_other	データ処理	1	10	25000
4	drone_self	計画	2	2	60000
5	drone_self	撮影	2	4	60000
6	drone_self	データ処理	1	4	60000
7	conventional	計画	2	4	100000
8	conventional	測量	4	8	100000
\.


--
-- Data for Name: work; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.work (id, workjp, typejp, workerjp, operationjp, work, type, worker, operation, areamin, areamax, capita, volumegrad, volumeseg, unitcost, expensetype, isict) FROM stdin;
1	測量	起工	協力会社	計画	measure	setup	other	plan	0	9999	2	0	2	70000	労務費	t
2	測量	起工	協力会社	ドローン撮影	measure	setup	other	photo	0	20	2	0	4	70000	労務費	t
3	測量	起工	協力会社	ドローン撮影	measure	setup	other	photo	20	40	2	0	6	50000	労務費	t
4	測量	起工	協力会社	ドローン撮影	measure	setup	other	photo	40	9999	2	0	2	140000	労務費	t
5	測量	起工	協力会社	データ処理	measure	setup	other	process	0	9999	1	0	10	25000	労務費	t
6	測量	起工	作業所職員	計画	measure	setup	self	plan	0	9999	2	0.0570000000000000021	0.277200000000000002	60000	人件費	t
7	測量	起工	作業所職員	ドローン撮影	measure	setup	self	photo	0	20	2	0	1	60000	人件費	t
8	測量	起工	作業所職員	ドローン撮影	measure	setup	self	photo	20	40	2	0	2	60000	人件費	t
9	測量	起工	作業所職員	ドローン撮影	measure	setup	self	photo	40	60	2	0	2.5	60000	人件費	t
10	測量	起工	作業所職員	ドローン撮影	measure	setup	self	photo	60	9999	2	0	4	60000	人件費	t
11	測量	起工	作業所職員	データ処理	measure	setup	self	process	0	9999	1	0	4	60000	人件費	t
12	測量	工事中	協力会社	計画	measure	partial	other	plan	0	9999	2	0	1	40000	労務費	t
13	測量	出来形	協力会社	計画	measure	check	other	plan	0	9999	2	0	1	40000	労務費	t
14	測量	出来高	協力会社	計画	measure	confirm	other	plan	0	9999	2	0	1	40000	労務費	t
15	測量	工事中	協力会社	ドローン撮影	measure	partial	other	photo	0	9999	2	0	2	60000	労務費	t
16	測量	出来形	協力会社	ドローン撮影	measure	check	other	photo	0	9999	2	0	2	60000	労務費	t
17	測量	出来高	協力会社	ドローン撮影	measure	confirm	other	photo	0	9999	2	0	2	60000	労務費	t
18	測量	工事中	協力会社	データ処理	measure	partial	other	process	0	0.5	1	0	1.5	60000	労務費	t
19	測量	出来形	協力会社	データ処理	measure	check	other	process	0	0.5	1	0	1.5	60000	労務費	t
20	測量	出来高	協力会社	データ処理	measure	confirm	other	process	0	0.5	1	0	1.5	60000	労務費	t
21	測量	工事中	協力会社	データ処理	measure	partial	other	process	0.5	9999	1	0	7.5	12000	労務費	t
22	測量	出来形	協力会社	データ処理	measure	check	other	process	0.5	9999	1	0	7.5	12000	労務費	t
23	測量	出来高	協力会社	データ処理	measure	confirm	other	process	0.5	9999	1	0	7.5	12000	労務費	t
24	測量	工事中	作業所職員	ドローン撮影	measure	partial	self	photo	0	20	2	0	1	60000	人件費	t
25	測量	出来形	作業所職員	ドローン撮影	measure	check	self	photo	0	20	2	0	1	60000	人件費	t
26	測量	出来高	作業所職員	ドローン撮影	measure	confirm	self	photo	0	20	2	0	1	60000	人件費	t
27	測量	工事中	作業所職員	ドローン撮影	measure	partial	self	photo	20	40	2	0	2	60000	人件費	t
28	測量	出来形	作業所職員	ドローン撮影	measure	check	self	photo	20	40	2	0	2	60000	人件費	t
29	測量	出来高	作業所職員	ドローン撮影	measure	confirm	self	photo	20	40	2	0	2	60000	人件費	t
30	測量	工事中	作業所職員	ドローン撮影	measure	partial	self	photo	40	60	2	0	3	60000	人件費	t
31	測量	出来形	作業所職員	ドローン撮影	measure	check	self	photo	40	60	2	0	3	60000	人件費	t
32	測量	出来高	作業所職員	ドローン撮影	measure	confirm	self	photo	40	60	2	0	3	60000	人件費	t
33	測量	工事中	作業所職員	ドローン撮影	measure	partial	self	photo	60	9999	2	0	4	60000	人件費	t
34	測量	出来形	作業所職員	ドローン撮影	measure	check	self	photo	60	9999	2	0	4	60000	人件費	t
35	測量	出来高	作業所職員	ドローン撮影	measure	confirm	self	photo	60	9999	2	0	4	60000	人件費	t
36	測量	工事中	作業所職員	データ処理	measure	partial	self	process	0	20	1	0	1.5	60000	人件費	t
37	測量	出来形	作業所職員	データ処理	measure	check	self	process	0	20	1	0	1.5	60000	人件費	t
38	測量	出来高	作業所職員	データ処理	measure	confirm	self	process	0	20	1	0	1.5	60000	人件費	t
39	測量	工事中	作業所職員	データ処理	measure	partial	self	process	20	40	1	0	2	60000	人件費	t
40	測量	出来形	作業所職員	データ処理	measure	check	self	process	20	40	1	0	2	60000	人件費	t
41	測量	出来高	作業所職員	データ処理	measure	confirm	self	process	20	40	1	0	2	60000	人件費	t
42	測量	工事中	作業所職員	データ処理	measure	partial	self	process	40	60	1	0	3	60000	人件費	t
43	測量	出来形	作業所職員	データ処理	measure	check	self	process	40	60	1	0	3	60000	人件費	t
44	測量	出来高	作業所職員	データ処理	measure	confirm	self	process	40	60	1	0	3	60000	人件費	t
45	測量	工事中	作業所職員	データ処理	measure	partial	self	process	60	9999	1	0	4	60000	人件費	t
46	測量	出来形	作業所職員	データ処理	measure	check	self	process	60	9999	1	0	4	60000	人件費	t
47	測量	出来高	作業所職員	データ処理	measure	confirm	self	process	60	9999	1	0	4	60000	人件費	t
48	測量	起工	協力会社	ー	measure	setup	other	none	0	9999	2	0.580500000000000016	15.0489999999999995	40000	労務費	f
49	測量	工事中	協力会社	ー	measure	partial	other	none	0	9999	2	0.580500000000000016	15.0489999999999995	40000	労務費	f
50	測量	出来形	協力会社	ー	measure	check	other	none	0	9999	2	0.580500000000000016	15.0489999999999995	40000	労務費	f
51	測量	出来高	協力会社	ー	measure	confirm	other	none	0	9999	2	0.580500000000000016	15.0489999999999995	40000	労務費	f
52	測量	起工	作業所職員	ー	measure	setup	self	none	0	9999	2	0.580500000000000016	15.0489999999999995	60000	人件費	f
53	測量	工事中	作業所職員	ー	measure	partial	self	none	0	9999	2	0.580500000000000016	15.0489999999999995	60000	人件費	f
54	測量	出来形	作業所職員	ー	measure	check	self	none	0	9999	2	0.580500000000000016	15.0489999999999995	60000	人件費	f
55	測量	出来高	作業所職員	ー	measure	confirm	self	none	0	9999	2	0.580500000000000016	15.0489999999999995	60000	人件費	f
56	土工	ICT	協力会社	図面３D化	construct	ict	other	3dmodel	0	9999	1	0	1	62000	労務費	t
57	土工	ICT	作業所職員	図面３D化	construct	ict	self	3dmodel	0	9999	1	0	1	60000	人件費	t
58	土工	ICT	協力会社	土工作業	construct	ict	other	workcost	0	9999	1	0	22	29000	労務費	t
59	土工	ICT	作業所職員	土工作業	construct	ict	self	workcost	0	9999	1	0	22	29000	労務費	t
60	土工	従来	協力会社	丁張	construct	conventional	other	ruler	0	9999	4	0.00129999999999999994	6.41180000000000039	42000	労務費	f
61	土工	従来	協力会社	土工作業	construct	conventional	other	workcost	0	9999	1	0	22	29000	労務費	f
62	土工	従来	作業所職員	丁張	construct	conventional	self	ruler	0	9999	4	0.00129999999999999994	6.41180000000000039	60000	人件費	f
63	土工	従来	作業所職員	土工作業	construct	conventional	self	workcost	0	9999	1	0	22	60000	労務費	f
\.


--
-- Data for Name: workers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workers (v, name) FROM stdin;
drone_other	ドローン測量（測量協力業者）
drone_self	ドローン測量（作業所職員・本店支援部門） 
conventional	従来測量
\.


--
-- Name: pj_dup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pj_dup_id_seq', 58, true);


--
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_id_seq', 53, true);


--
-- Name: tablename_colname_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tablename_colname_seq', 1, false);


--
-- Name: w_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.w_id_seq', 8, true);


--
-- Name: machine machine_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine
    ADD CONSTRAINT machine_pkey PRIMARY KEY (id);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: trouble trouble_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trouble
    ADD CONSTRAINT trouble_pkey PRIMARY KEY (id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA public TO app_user;


--
-- Name: TABLE machine; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.machine TO app_user;


--
-- Name: TABLE pj_dup; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pj_dup TO app_user;


--
-- Name: SEQUENCE pj_dup_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.pj_dup_id_seq TO app_user;


--
-- Name: TABLE project; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.project TO app_user;


--
-- Name: TABLE relma; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.relma TO app_user;


--
-- Name: TABLE pjmachines; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pjmachines TO app_user;


--
-- Name: TABLE reltr; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reltr TO app_user;


--
-- Name: TABLE trouble; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.trouble TO app_user;


--
-- Name: TABLE pjtroubles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pjtroubles TO app_user;


--
-- Name: TABLE postgrest; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.postgrest TO app_user;


--
-- Name: SEQUENCE project_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.project_id_seq TO app_user;


--
-- Name: TABLE reltr_dup; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reltr_dup TO app_user;


--
-- Name: SEQUENCE tablename_colname_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.tablename_colname_seq TO app_user;


--
-- Name: TABLE test; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.test TO app_user;


--
-- Name: TABLE w; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.w TO app_user;


--
-- Name: TABLE w2; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.w2 TO app_user;


--
-- Name: SEQUENCE w_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.w_id_seq TO app_user;


--
-- Name: TABLE work; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.work TO app_user;


--
-- Name: TABLE workers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.workers TO app_user;


--
-- Name: TABLE workfull; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.workfull TO app_user;


--
-- PostgreSQL database dump complete
--

