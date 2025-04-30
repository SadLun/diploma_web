--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: equipment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.equipment (
    id integer NOT NULL,
    name text NOT NULL,
    warranty_years integer,
    min_temperature double precision,
    max_temperature double precision,
    link text,
    category_id integer NOT NULL,
    mtbf_hours double precision
);


--
-- Name: equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.equipment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.equipment_id_seq OWNED BY public.equipment.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: equipment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment ALTER COLUMN id SET DEFAULT nextval('public.equipment_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, name) FROM stdin;
5	Аудио/Видео оборудование
6	Вентиляторы
7	Видеонаблюдение
8	Видеопереферия
9	Датчики и сенсоры
10	Источники питания
11	Кабели и разъемы
12	Коммутаторы
13	Компьютерное оборудование
14	Контроллеры и интерфейсы
15	Логические блоки
16	Накопители и память
17	Оборудование
18	Освещение
19	Периферийные устройства
20	Печатающие устройства
21	Прочее
22	Сетевое оборудование
23	Стойки и шкафы
24	Трубы
\.


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.equipment (id, name, warranty_years, min_temperature, max_temperature, link, category_id, mtbf_hours) FROM stdin;
3	Телевизор Sony KD65XD7505	1	0	40	https://devicebeast.com/display/sony-kd-65xd7505-645	5	14
4	Видеомонитор Dell U2412M	1	0	40	https://www.dns-shop.kz/product/characteristics/20ae734eea4e526f/monitor-dell-24-ultrasharp-u2412m-black-ips-led-1920x1200-2m1-178gor178ver-8ms-dvidpd-sub-usbx4/	5	14
5	Дополнительный вентилятор Арт. № DK 7980.000	1	-20	80	https://rittaler.ru/catalog/product/7980000/	6	35
6	Вентиляторная панель Арт. № DK 7988.035	1	-20	80	https://rittaler.ru/catalog/product/7988035/	6	35
7	Вентилятор	1	-20	80	нет данных	6	35
8	Вентиляторная панель ДНТВ.651511.002	\N	\N	\N	нет данных	6	35
9	Сетевая камера AXIS P1365 Mk II ф. "AXIS"	\N	\N	\N	нет данных	7	200
10	Камера оптическая трубопроводная КОТ-2-ССД ТУ 2248-001-705792-00	1	-40	60	https://www.ssd.ru/kamera-opticheskaya-truboprovodnaya-kot-2-ssd-new/	7	200
11	Сетевая камера AXIS P1365 MkII	3	-20	60	https://www.vtkt.ru/catalog/security/0897_014_axis_p1365_mk_ii_ip_kamera_korpusnaya_poe_1920x1080_f_2_8_8mm_n112_39/?srsltid=AfmBOop6SLOz3ue9N1DRyg15yvr2P6TGLRBQ0gflx4SgrJL5XpyUUXRf	7	200
12	Телекамера сетевая AXIS P1365 Mk II	3	0	50	https://www.group-sb.ru/catalog/korpusnye-ip/axis-p1365-mk-ii-bareb/	7	200
13	Кожух AXIS T93F10	3	-20	60	https://www.group-sb.ru/catalog/kozhukhi-i-termokozhukhi/axis-t93f10-outdoor-housing-24vac-12-24vdc/	7	200
14	Видеоманитор Dell U2412M	1	0	40	https://www.dns-shop.kz/product/characteristics/20ae734eea4e526f/monitor-dell-24-ultrasharp-u2412m-black-ips-led-1920x1200-2m1-178gor178ver-8ms-dvidpd-sub-usbx4/	8	20
15	Датчик дыма CMC III Арт. №DK 7030.400	1	5	45	https://rittaler.ru/catalog/product/7030400/	9	75
16	Датчик вандализма Арт. №DK 7030.130	1	0	55	https://armatron.ru/datchik-vandalizma-cmc-iii-dk-7030-130-rittal	9	75
17	Датчик температуры/влажности CMC III Арт. №DK 7030.111	1	0	55	https://rittaler.ru/catalog/product/7030111/	9	75
18	Датчик температуры Арт. №DK 7030.110	1	0	55	https://rittaler.ru/catalog/product/7030110/	9	75
19	Датчики CA-Bus CMC III Арт. №DK 7030.100	1	0	55	https://rittal-parts.ru/product/rittal-7030100-datchiki-dlja-bloka-can-bus-iii/	9	75
20	Инфракрасный датчик доступа CMC III Арт. №DK 7030.120	1	0	55	https://rittaler.ru/catalog/product/7030120/	9	75
21	Датчик движения CMC III Арт. №DK 7320.570	1	5	45	https://rittaler.ru/catalog/product/7320570/	9	75
22	Блок питания PS-1200A	1	-25	55	https://manometr-rsc.ru/catalog/ps1200-1/#:~:text=1%20%D0%B1%D0%BB%D0%BE%D0%BA%20%D0%BF%D0%B8%D1%82%D0%B0%D0%BD%D0%B8%D1%8F%2024%D0%92%20(20%20%D0%90),-0&text=%D0%BF%D1%80%D0%B5%D0%B4%D0%BD%D0%B0%D0%B7%D0%BD%D0%B0%D1%87%D0%B5%D0%BD%D1%8B%20%D0%B4%D0%BB%D1%8F%20%D0%BF%D1%80%D0%B5%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20%D1%81%D0%B5%D1%82%D0%B5%D0%B2%D0%BE%D0%B3%D0%BE%20%D0%BF%D0%B5%D1%80%D0%B5%D0%BC%D0%B5%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE,%D0%BE%D1%82%20%D0%BA%D0%BE%D1%80%D0%BE%D1%82%D0%BA%D0%BE%D0%B3%D0%BE%20%D0%B7%D0%B0%D0%BC%D1%8B%D0%BA%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%B8%20%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D1%80%D1%83%D0%B7%D0%BE%D0%BA.	10	120
23	Блок питания SD-150C-24	5	-10	60	https://www.mean-well.ru/store/SD-150C-24/	10	120
24	Блок питания PS-1600D	\N	\N	\N	https://3logic.ru/products/blok-pitaniya-dps-1600cb-b-psu-1600w-oem-6-43695/	10	120
25	Блок питания AXIS	3	-40	55	https://www.axis.com/dam/public/5e/ff/6b/datasheet-ecp081208-ps-24-v-ru-RU-287294.pdf	10	120
26	Блок питания БП-3А	1	-25	40	https://www.grion.ru/blok-pitaniya-bp-3a-stabilizirovannyiy.html	10	120
27	Источник питания AC/DC (Power supply)	5	-40	60	https://www.mean-well.ru/store/HRP-100-5/	10	120
28	Блок питания СМС III Арт. №DK 7030.060	1	0	40	https://rittaler.ru/catalog/product/7030060/	10	120
29	Комбинированный источник бесперебойного питания Guardian Central GDN.M29, -48 В и \n~ 220 В 50 Гц	\N	\N	\N	нет данных	10	120
30	Кабель ДНТВ.685633.011 (Провод ПуГВ 10,0 кВ 14 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-10	11	150
31	Кабель ДНТВ.685633.001-11 (ВВГ нг 3х2,5ок (N, PE)-0,66кВ 36 м)	\N	\N	\N	нет данных	11	150
32	Кабель ДНТВ.685633.001-12 (ВВГ нг 3х2,5ок (N, PE)-0,66кВ 36 м)	\N	\N	\N	нет данных	11	150
33	Кабель ДНТВ.685633.003 (силовой медный ВШбШв 4х35х0,66 6 м)	20	-50	50	https://e-kc.ru/cena/cable-vbbshv-4-6	11	150
34	Кабель ДНТВ.685633.005 (силовой медный КГВВнг (A)-LS 4х6 (N)-0,66 10 м)	20	-50	50	https://e-kc.ru/cena/cable-kgvvng-ls-4-6	11	150
35	Провод ДНТВ.685633.008 (ПуГВ 10,0 кв. мм, \nL=8 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
36	Провод ДНТВ.685633.013 (Провод ПуГВ 6,0 кв.мм 10 м	20	-50	50	https://e-kc.ru/cena/provod-pugv-6	11	150
37	Кабель ДНТВ.685633.001 (ВВГ нг 3х2,5ок (N, PE)-0,66кВ 32 м)	10	-50	50	https://www.tinko.ru/catalog/product/294211/	11	150
38	Кабель ДНТВ.685633.001 (ВВГ нг 3х2,5ок (N, PE)-0,66кв.мм 36 м)	2	-50	50	https://www.vseinstrumenti.ru/product/kabel-vvg-ng-a-ls-3x2-5ok-n-pe-0-66-buhta-100m-uglichkabel-plls1030205140000000-7890938/	11	150
78	Волоконно-оптический кабель OCC-SC530(4FP), двубронный	\N	\N	\N	нет данных	11	150
39	Кабель питающий (на 220В)	1	-15	60	https://robot-kit.ru/Power-220V-cable/#:~:text=%D0%A1%D0%B5%D1%82%D0%B5%D0%B2%D0%BE%D0%B9%20%D0%BA%D0%B0%D0%B1%D0%B5%D0%BB%D1%8C%20Power%2D220V%2Dcable,%D0%B4%D1%80%D1%83%D0%B3%D0%B8%D1%85%20%D0%BF%D1%80%D0%B8%D0%B1%D0%BE%D1%80%D0%BE%D0%B2%2C%20%D0%B8%D0%BC%D0%B5%D1%8E%D1%89%D0%B8%D1%85%20%D1%81%D0%BE%D0%BE%D1%82%D0%B2%D0%B5%D1%82%D1%81%D1%82%D0%B2%D1%83%D1%8E%D1%89%D0%B8%D0%B9%20%D1%80%D0%B0%D0%B7%D1%8A%D0%B5%D0%BC.	11	150
40	Кабель ДНТВ.685633.002 (силовой медный ВШбШв 4х35х0,66кв.мм 31 м)	20	-50	50	https://e-kc.ru/cena/cable-vbbshv-4-35	11	150
41	Кабель ДНТВ.685633.005 (ВВГ нг-LS 4х6-0,66 кв.мм 42м)	30	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-4-6	11	150
42	Провод ДНТВ.685633.007 (ПуГВ 6,0кв. мм 3м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-6	11	150
43	Провод ДНТВ.685633.010 (ПуГВ 10,0кв. мм 50м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
44	Провод ДНТВ.685633.018 (ПуГВ 25,0кв. мм 6м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-25	11	150
45	Волоконно-оптический кабель ДКН-7-6z-6/48	1	-20	70	https://cable.ru/cable/marka-dkn.php	11	150
46	Лента сигнальная «Оптика» с логотипом «Осторожно оптический кабель» 40мм, \n500 п.м.	1	-20	70	https://www.ssd.ru/lso-40-lenta-signalnaya-40mm-500m-100mkm-ya-quot-ostorozhno-opticheskiy-kabel-quot/	11	150
47	Провод ПуГВ 1х4	20	-50	50	https://e-kc.ru/cena/provod-pugv-4	11	150
48	Кабель ДНТВ.685633.023 (Кабель силовой медный ВВГнг(A)-LS 3х2,5(N,PE)-0,66 10 м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-3-2_5	11	150
49	Кабель ДНТВ.685633.025 (провод ПуГВ 1х25 11 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-25	11	150
50	Кабель ДНТВ.685633.026 (провод ПуГВ 1х16 14 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-16	11	150
51	Кабель ДНТВ.685633.028 (провод ПуГВ 1х16(N) 14 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-16	11	150
52	Кабель ДНТВ.685633.029 (провод ПуГВ 1х10(N) 14 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
53	Кабель ДНТВ.685633.030 (провод ПуГВ 1х25(N) 11 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-25	11	150
54	Кабель ДНТВ.685633.031 (провод ПуГВ 1х10(РЕ) 10 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
55	Лента сигнальная "Оптика" с логотипом "Осторожнокабель" ЛСЭ 450 300мкм 450мм х 100м.пог.	\N	\N	\N	нет данных	11	150
56	Провода ПуГВнг (А)-LS 1х2,5	20	-40	65	https://e-kc.ru/cena/provod-pugvng-ls-1-2_5	11	150
57	Провода ПуГВ 1х2,5ок(PE)	20	-50	65	https://e-kc.ru/cena/provod-pugv-2_5	11	150
58	Кабель ВВГ нг 3х2,5ок (N, PE)-0,66 692 м	10	-50	50	https://www.tinko.ru/catalog/product/294211/	11	150
59	Кабель ПвПу2г 1х35/16-6	1	-50	70	https://k-ps.ru/spravochnik/kabeli-silovyie/s-izolyacziej-iz-sshitogo-polietilena-(6kv)/pvpu2g-6kv/kabel-pvpu2g-1x35-16.html	11	150
60	Кабель ДНТВ.685633.012 (Провод ПуГВ 16,0 кВ 10 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-16	11	150
61	Кабель ДНТВ.685633.014 (Провод ПуГВ 25,0 кВ 11 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-25	11	150
62	Кабель ДНТВ.685633.015 (Провод ПуГВ 16,0 кВ 10 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-16	11	150
63	Кабель ДНТВ.685633.016 (Провод ПуГВ 25,0 кВ 11 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-25	11	150
64	Кабель ДНТВ.685633.017 Провод ПуГВ 10,0 кВ 14 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-10	11	150
65	Кабель ДНТВ.685633.035 (ВВГ нг-LS 3х1,5-0,66 кВ 43м)	5	-50	50	https://www.etm.ru/cat/nn/7200644?srsltid=AfmBOope_3Ln2HFAAjIPmnyrpDGr1cwsqBh_iFQrbuaR9wRZeLSHB4l6	11	150
66	Волоконно-оптический кабель ДКНа-20-9z-4/8 ТУ 3587-007-51702873-2015	\N	\N	\N	нет данных	11	150
67	Кабель ДНТВ.685633.006 (ВВГ нг-LS 3х1,5-0,66 кВ 43м)	5	-50	50	https://www.etm.ru/cat/nn/7200644?srsltid=AfmBOoqrOWfZ_Qe6rnVpQaiiyRGXQFCTckcX3fyAkyCY5YpBL61HdImk	11	150
68	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 135 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
69	Кабель ДНТВ.685633.004(силовой медный ВШбШв 4х35х0,66 43 м)	\N	\N	\N	нет данных 	11	150
70	Кабель ДНТВ.685633.002 (силовой медный ВШбШв 4х35х0,66 32 м)	1	-50	50	http://roomelectro.ru/kabel_silovoj_mednyj_bronirovannyj_vbbshv_4h35/	11	150
71	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 115 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
72	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 89 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
73	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 67 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
74	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 153 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
75	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 67 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
76	Кабель питания ДНТВ.685621.001 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE, ветвь кабеля 2х1,5 PE. 0,2 м)	20	-60	79	нет данных	11	150
77	Кабель ДНТВ.685633.001-04 (ВВГ нг 3х2,5ок (N, PE)-0,66кв.мм 10 м)	1	-50	50	https://www.vseinstrumenti.ru/product/kabel-vvg-ng-a-ls-3x2-5ok-n-pe-0-66-buhta-50m-uglichkabel-plls1030205140000000-05-7890944/#description	11	150
79	Провод ПВ3 1х10	1	-20	60	https://electro-shop24.ru/catalog/provod-kabel/provod-pugvv-pv-3/provod-pv-3-1kh10-gost/	11	150
80	Провод ПуГВнг(А)-LS 1х2,5	1	-40	65	https://www.etm.ru/cat/nn/1817072?srsltid=AfmBOorgbOTIHUmQRkEEHlofnsiHYztluGQ-xlCwgqOhgB8w_uX8rfHQ	11	150
81	Волоконно-оптический кабель OCC-SC530(4FP), однобронный	1	-50	70	https://www.ssd.ru/kabel-okk-12khg-652d-2-7kn/	11	150
82	Подводный волоконно-оптический репитер,\nс защищенным кабельным вводом Т-Т, 4FP	\N	\N	\N	нет данных	11	150
83	Подводный электрический кабель	1	-60	50	https://cable.ru/cable/marka-vp_2x0_7.php#attributes	11	150
84	Кабель ВВГ нг 2х2,5ок (N)-0,66 330 м	\N	\N	\N	https://nes.spb.ru/product/vvgng-a-ls-2x2-5ok-n-0-66/	11	150
85	Кабель ДНТВ.685633.009 (провод ПуГВ 6,0 кВ 10м)	3	-50	50	https://www.vseinstrumenti.ru/product/elektricheskij-provod-pugv-provodnik-1x6-mm2-belyj-10m-oz250757l10-7929608/#description	11	150
86	Кабель ДНТВ.685633.033 (провод ПуГВ 1х10 15 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
87	Столбик замерный кабельный	1	-40	60	https://www.ssd.ru/stolbik-zamernyy-kabelnyy-polimernyy-szk-1-seryy/	11	150
88	Кабель ДНТВ.685633.023 (Кабель силовой медный ВВГнг(А)-LS 3x25(NPE)-0,66 32 м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-4-6	11	150
89	ДНТВ.685662.001 (Кабель UTP кат. 5e) L=10 м	3	-15	60	ссылок на информацию нет ()	11	150
90	Кабель комбинированный ДНТВ.685662.155 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 46 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
91	Колодец кабельный ККС	1	-50	60	https://europlast-ltd.ru/kolodec/kolodtsy-kabelnoj-svjazi/kabelnyj-kolodets-ks-mikro-h290-tsvet-chernyj-15338	11	150
92	Ввод кабельный распорный JM-SIM-122S070SB 40мм, диаметр кабеля (9-14,5) мм	1	-40	60	http://www.ot-k.ru/materialy-dlya-zaduvki/vvody-kabelnye-raspornye/vvod-kabelnyy-raspornyy-k-tvr-40-9-14-5-1	11	150
93	Ввод кабельный распорный К-ТВР-40/611/1	1	-40	60	нет ссылки	11	150
94	Ввод кабельный распорный \nК-ТВР-40/9-14,5/1, диаметр трубы 40 мм, диаметр кабеля (9-14,5) мм	1	-40	60	http://www.ot-k.ru/materialy-dlya-zaduvki/vvody-kabelnye-raspornye/vvod-kabelnyy-raspornyy-k-tvr-40-9-14-5-1	11	150
95	Кабель ДНТВ.685633.020 (Кабель силовой медный ВВГнг(А)-LS 4x6ок(N)-0,66 22м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-4-6	11	150
96	Кабель ДНТВ.685633.022 (Кабель силовой медный ВВГнг(А)-LS 4x6ок(N)-0,66 44 м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-4-6	11	150
97	Провод ДНТВ.685633.024 (провод ПуГВ 1х25(РЕ) 6м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-25	11	150
98	Провод ДНТВ.685633.034 (провод ПуГВ 1х10(РЕ) 22м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
99	Кабель ВВГнг(А)-LS 3x2,5ок(N, РЕ)-0,66	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-3-2_5	11	150
100	Контейнер проводов заземления КПЗ-М ГК-У248.00.000ЭТ	1	-40	60	https://www.ssd.ru/konteyner-provodov-zazemleniya-kpz-m/	11	150
101	Кабель оптический LC/LC-SM-3MM-duplex-5м L = 5 м	1	-20	70	https://fibertool.by/catalog/pasive/patch_kordy_opticheskie/lasercords_lc_sc_sm_duplex_3mm_patch_kord_5m/	11	150
102	Кабель PC-LPM-SFTP-RJ45-C5e-3M-LSZH-BK F/UTP, экранированный, Cat.5e, LSZH, L = 3 м\n	1	-10	60	https://www.vseinstrumenti.ru/product/patch-kord-hyperline-pc-lpm-sftp-rj45-rj45-c5e-3m-lszh-bk-sf-utp-ekranirovannyj-cat-5e-100-fluke-component-tested-lszh-3-m-chernyj-264366-7288111/	11	150
103	Кабель HAMA H-83073 HDMI (m)- HDMI (m), 10m L = 10 м	5	-10	60	https://www.citilink.ru/product/kabel-audio-video-hama-h-83073-hdmi-m-hdmi-m-10m-gold-chernyi-00083073-823862/	11	150
104	Кабель для программирования СМСIII арт. № DK 7030.080 RJ45 L = 3 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030480/	11	150
105	Cоединительный кабель CAN-Bus CMCIII. Арт. №DK 7030.095 Слаботочный RJ45 L = 10 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030095/	11	150
106	Cоединительный кабель CAN-Bus CMCIII. Арт. №DK 7030.094 Слаботочный RJ45 L = 5 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030094/	11	150
107	Cоединительный кабель CAN-Bus CMCIII. Арт. №DK 7030.093 Слаботочный RJ45 L = 2 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030093/	11	150
108	Cоединительный кабель CAN-Bus CMCIII Арт. №DK 7030.091 Слаботочный RJ45 L = 1 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030091/	11	150
109	Cоединительный кабель CAN-Bus CMCIII Арт. №DK 7030.090. Слаботочный RJ45 L = 0,5 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030090/	11	150
110	Кабель подключения CMC III Арт. №DK 7200.210 L = 1,8 м	2	0	55	https://rittaler.ru/catalog/product/7200210/	11	150
111	Кабель оптический FC/LC-SM-3mm-duplex-5м L = 5 м	1	-20	70	https://componentltd.ru/catalog/patch-kordy-opticheskie/patch-kord-opticheskiy-fc-lc-upc-sm-9-125mkm-duplex-3-0mm-5m/	11	150
112	Кабель ДНТВ.685633.019 (Кабель силовой медный ВБШв 4х35мк(N)-0,66 22 м)	20	-50	50	https://e-kc.ru/cena/cable-vbshv-4-35	11	150
113	Кабель ВВГнг(А)-LS 2x2,5ок(N)-0,66	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-2-2_5	11	150
114	Столбик замерный кабельный	1	-40	60	https://www.ssd.ru/stolbik-zamernyy-kabelnyy-polimernyy-szk-1-seryy/	11	150
115	Провод ПуГВ 1х4	1	-50	65	https://e-kc.ru/cena/provod-pugv-4	11	150
116	Кабель ДНТВ.685633.001 (Кабель ВВГнг-LS 3х2,5-0,66кВ 32 м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-3-2_5	11	150
117	Лента сигнальная «Оптика» с логотипом «Осторожно оптический кабель» 40 мм, 500 п.м. (ж/ч) (желто-черный)	1	-10	52	https://www.vseinstrumenti.ru/product/signalnaya-lenta-s-logotipom-ostorozhno-opticheskij-kabel-protekt-40mm-500-p-m-lso-40-500-zh-ch-1081673/#description	11	150
118	Кабель ДНТВ.685633.003 (Кабель силовой медный ВБбШв 4х35-0,66 6 м)	20	-50	50	https://e-kc.ru/cena/cable-vbbshv-4-35	11	150
119	Кабель ДНТВ.685633.005 (кабель силовой медный ВВГнг-LS 4х6-0,66 10 м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-4-6	11	150
120	Волоконно-оптический кабель ДКН-7-9z-4/8 ТУ 3587-007-51702873-2015	1	-20	70	нет ссылок	11	150
121	Провод ПуГВ 1х2,5 (РЕ)	20	-50	50	https://e-kc.ru/cena/provod-pugv-2_5	11	150
122	Волоконно-оптический кабель ДПа-2,7-9z-6/8 ТУ 3587-007-51702873-2015	1	-20	70	нет ссылок	11	150
123	Волоконно-оптический кабель ДКПа-20-9z-4/8 ТУ 3587-007-51702873-2015	1	-20	70	нет ссылок	11	150
124	Волоконно-оптический кабель ДНа-2,7-9z-6/8 ТУ 3587-007-51702873-2015	1	-20	70	нет ссылок	11	150
125	Кабель ДНТВ.685633.008 (Провод ПуГВ 10,0 кв. мм 8м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
126	Кабель ДНТВ.685633.013 (Провод ПуГВ 6,0 кв.мм 10м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-6	11	150
127	Кабель ДНТВ.685633.009 (Провод ПуГВ 6,0 кв. мм 10 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-6	11	150
128	Шнур оптический соединительный (ШОС)\nsimplex FC/UPC-SC/UPC-SM-3мм-simplex	1	-20	70	https://www.ssd.ru/shnur-shos-sm-3-0-mm-fc-upc-fc-upc-1-0-m-/	11	150
129	Шнур оптический соединительный (ШОС)\nsimplex SC/UPC-SC/UPC SM-3мм-simplex	1	-20	70	https://www.ssd.ru/shnur-shos-sm-3-0-mm-sc-upc-sc-upc-1-0-m-/	11	150
130	Муфта соединительная ТСЦР.687113.004	1	-40	60	https://gf-shop.ru/mufta-soedinitelnaya-jeelex-20x20?srsltid=AfmBOop8dnRFgO66o84Qu6bCcC8mxTkMkH3BsM6Vad3c9HoKC2iYDehR	11	150
131	Муфта разветвительная FOSC-500AA-S24-LT-NN	1	-40	60	https://stc-energy.ru/catalog/komponenty_opticheskikh_kabelnykh_sistem_vols/mufty_dlya_vols/mufty_te_connectivity/prokhodnye_mufty/mufty_fosc_350_fosc_500/mufta_opticheskaya_prokhodnaya_fosc_500aa_s24_lt_nn/	11	150
132	Подводная муфта для кабеля OCC-SC530	1	-40	60	https://pondsystem.ru/unterwasser-kabelverbinder-gr-1-unverpackt-168-3321-kabel-naya-mufta-podvodnaya-5x2-5-mm2-6-13-mm-bez-upakovki.html	11	150
133	Муфта соединительная для кабеля морского\nзаземления типа POLJ 12/1x25-70	1	-40	60	https://raychem.su/mufty-raychem/soedinitelnye/polj/polj-121x25-70	11	150
134	Блок разветвления\nкабеля (CTB)	\N	\N	\N	https://snk-s.ru/ru/ctb-12p	11	150
135	Муфта разветвительная RAYCHEM FOSC-500AA-S24-LT-NN	\N	\N	\N	https://sunnet-omsk.ru/cgi-bin/katalog_new.cgi?dir1&28&dir2&454&dir3&&podr&3046	11	150
136	Муфта соединительная для кабеля морского\nзаземления типа POLJ 12/1x25-70-CЕЕ01	1	-40	60	https://raychem.su/mufty-raychem/soedinitelnye/polj/polj-121x25-70-cee01	11	150
137	Главная шина заземления ГШВ	\N	\N	\N	https://www.dkc.ru/ru/catalog/1130/NE2020/	11	150
138	Волоконно-оптический соединитель ШОС-LC-FC-SM-3мм-Duplex-10м	1	-20	70	https://componentltd.ru/catalog/patch-kordy-opticheskie/patch-kord-opticheskiy-fc-lc-upc-sm-9-125mkm-duplex-3-0mm-10m/	11	150
139	Устройство морского заземлителя	\N	\N	\N	нет данных 	11	150
140	Распределительный блокРБ-125 1П 125А 1 шина8 присоединений	\N	\N	\N	https://www.electro-mpo.ru/catalog/shiny_izolyatory_peremychki/e21_raspredelitelnye_bloki/e1571-raspredelitelnyy-blok-rb-125-1-polyus-125a-1/	11	150
141	Оптический приемо- передающий модуль XFP-MR-10	\N	\N	\N	нет данных	11	150
142	Соединительный шнур RJ45	1	-20	60	https://www.dns-shop.ru/product/6de285e58335526f/prohodnoj-soedinitelnyj-adapter-rj45-5bites-8p8c-rj-45/?utm_medium=organic&utm_source=google&utm_referrer=https%3A%2F%2Fwww.google.com%2F	11	150
143	Шнур оптический Duplex \nLC/APC-FC/APC-SM- 20m-3mm	1	-40	70	https://www.vseinstrumenti.ru/product/opticheskij-dvojnoj-shnur-fops-patch-kord-dupleks-dx-lc-apc-fc-upc-9-125-2-0-lszh-3m-138-3297488/	11	150
144	Шнур оптический Duplex \nSMLC/UPC-FC/UPC-SM-20m-3mm	1	-40	70	https://componentltd.ru/catalog/patch-kordy-opticheskie/patch-kord-opticheskiy-fc-sc-upc-sm-9-125mkm-duplex-3-0mm-20m/	11	150
145	Шнур оптический Simplex \nLC/APC-LC/UPC-SM-05m-2mm	1	-40	70	https://shop.nag.ru/catalog/01898.patch-kordy-opticheskie/12425.patchkord-opticheskij-sm-lc-lc/15491.snr-pc-lcupc-lcapc-dpx-05m	11	150
146	Шнур оптический Simplex \nLC/APC-LC/APC-SM-05m-2mm	1	-40	70	https://bestcable.ru/catalog/volokonno_opticheskie_linii_svyazi_vols/passivnye_komponenty/pigteyly_opticheskie/shnur_opticheskiy_lc_upc_lc_apc_simplex_sm_2mm_0_5m/	11	150
147	Ethernet-коммутатор\nMES3316F AC	1	-10	45	https://eltexcm.ru/catalog/ethernet-kommutatory/kommutatory-agregacii-1g10g/mes3316f.html?srsltid=AfmBOopIWflkoDzrTJ5eUNcllHB5jTgc6k5V7-8I8H2wUH80oqxzYWNq	11	150
148	Соединительный шнур\nEthernet UTPCat5е, RJ45 2м	1	-20	60	https://www.ozon.ru/product/kabel-dlya-podklyucheniya-interneta-2-m-lan-provod-internet-patch-kord-vitaya-para-utpcat5e-rj45-918231197/?abt_att=1&origin_referer=www.google.com	11	150
149	Оптический приемо- передающий модуль SFP+MR-10	\N	\N	\N	нет данных	11	150
150	Ethernet-коммутатор MES3316F DC	1	-10	45	https://eltex-co.ru/catalog/mes3316f/#compatibility	11	150
151	FG-750ST-DCOR-aa-bb-ccdd- ff-gg EXFO Fiber\nguardian-OTDR	1	-5	50	http://www.exforus.ru/products/index.php?id=164	11	150
152	Шнур оптическийсоединительный (ШОС)\nLC/UPC-LC/UPC-SM-3mm-duplex, 5м	1	-20	70	https://www.ssd.ru/shnur-shos-sm-3-0-mm-lc-upc-lc-upc-3-0-m/	11	150
153	Шнур оптический соединительный (ШОС)\nLC/UPC-LC/UPC-SM-3mm-duplex, 10м	1	-20	70	https://componentltd.ru/catalog/patch-kordy-opticheskie/patch-kord-opticheskiy-sc-lc-upc-sm-9-125mkm-duplex-3-0mm-10m/	11	150
154	NS-Gate R214-A2 Корзина 2u на 14 устройств\nnf-W02L, nf-SFP, nfg-SFP nft-SFP, 2x220VAC	\N	\N	\N	https://www.nsgate.ru/nsgate_chassis_phaseout.shtml	11	150
155	Оптический шнур 2LC/UPC-2LC/UPC-SM	1	-20	70	https://componentltd.ru/catalog/kabelnye-sborki-na-vnutrennem-i-vneshnem-kabele-co-ts-otts/opticheskaya-kabelnaya-sborka-2lc-upc-2lc-upc-sm-20m-na-kabele-otts-2a-1-5/	11	150
156	NS-Gate NF-SFP конвертер: 155 Mbps sfp слот, 1 порт Ethernet 10/100Base-TX	1	\N	\N	https://nsgate.ru/nsgate_nfgsfp_phaseout.shtml	11	150
157	Ethernet-коммутатор MES3124AC	1	-10	45	https://eltex-co.ru/catalog/mes3124/	11	150
158	Оптический приемо- передающий модуль SFPD-MR-80-F	\N	\N	\N	нет данных	11	150
159	Оптический приемо- передающий модуль\nSFP-GE-10	\N	\N	\N	нет данных	11	150
160	Муфта разветвительная RAYCHEM FOSC-350C-24-1-000\n	1	-40	60	https://www.kross-kontakt.ru/opticheskie-mufty/fosc-350c	11	150
161	Комплект для ввода ОК FOSC-350С-CABLE-KIT	1	-40	60	https://kross-kontakt.ru/opticheskie-mufty/prinadlezhnosti-dlya-opticheskikh-muft/fosc-350c-cable-kit	11	150
162	Муфта разветвительная RAYCHEMFOSC-500AA-S24-LT-NN	1	-40	60	https://stc-energy.ru/catalog/komponenty_opticheskikh_kabelnykh_sistem_vols/mufty_dlya_vols/mufty_te_connectivity/prokhodnye_mufty/mufty_fosc_350_fosc_500/mufta_opticheskaya_prokhodnaya_fosc_500aa_s24_lt_nn/	11	150
163	Муфта соединительная компрессионная 040 мм ГПП	1	-40	60	https://komsis.su/product/mufta-soedinit-kompressionnaia-040kh040-mm-sab-gppfitingi-pe-kompressionnye/	11	150
164	Волоконно-оптический соединитель ШОС-FC/APC-FC-SM-3мм-Simplex-10м	1	-20	50	https://cabeus.ru/product/6885/	11	150
165	Волоконно-оптический соединитель ШОС-L-FC-SM-3мм-Duplex-5м	1	-20	70	https://fibertool.ru/catalog/pasive/patch_kordy_opticheskie/lasercords_fc_sc_sm_duplex_3mm_patch_kord_5m/	11	150
166	Фиксированный аттенюатор LC/APC-SM-05dB	1	-40	85	https://shop.nag.ru/catalog/02653.attenyuatory-opticheskie/07139.attenyuatory-opticheskie-sc/08418.snr-att-mf-scapc-05db#properties	12	180
167	Фиксированный аттенюатор LC/APC-SM-10dB	1	-40	85	https://cabeus.ru/product/7559/	12	180
168	Фиксированный аттенюатор LC/UPC-SM-10dB	1	-40	85	https://fibotelecom.ru/catalog/passivnye_komponenty_1/attenyuatory/attenyuator_lc_upc_10db	12	180
169	TS8 Комфортная ручка Арт. №DK 7320.721	1	0	55	https://rittaler.ru/catalog/product/7320794/	12	180
170	Коммутатор доступа Eltex MES2324B	1	-20	50	https://eltex-co.ru/catalog/mes2324b/	12	180
171	Коммутатор доступа Eltex MES2348B	1	-20	50	https://eltex-co.ru/catalog/mes2348b/	12	180
172	Сервер HPE Proliant D160 Gen9	1	10	35	https://www.expresscomputersystems.com/products/hpe-proliant-dl160-gen9?srsltid=AfmBOoo38TZ1D3hd-2zD0uRRzomcQ8Yiv_8g0H88s78fxgCsDJEKyy6V	13	70
173	Компьютер Dell Optiplex 7050 MT i5 6500(3.2)/1Tb+1000Gb 7.2k/R5 430 2Gb/DVDRW/ Windows7 Professional 64+W10Pro/GbitEth/240W/	31	0	35	https://icecat.biz/en/p/dell/n141so7050sff02/optiplex-pcs-workstations-7050-51318364.html	13	70
174	Серверный аппаратный комплект 7: кластерное решение, АС	\N	\N	\N	нет данных	13	70
175	Компьютер Dell Optiplex 7050 MT i5 6500(3.2)/1Tb+1000Gb 7.2k/R5 430 2Gb/DVDRW/ Windows7 Professional 64+W10Pro/GbitEth/240W/	31	0	35	https://icecat.biz/en/p/dell/n141so7050sff02/optiplex-pcs-workstations-7050-51318364.html	13	70
176	Консоль управления KVM на один сервер (USB)	3	-40	60	https://www.kvm-s.ru/catalog/kvm_oborudovanie/kvm_konsoli/kvm_konsol_s_pereklyuchatelem_aten_cl5708m_cl5708m_ata_rg/#props	13	70
177	Сервер HPE Proliant D160 Gen9	1	10	35	https://www.expresscomputersystems.com/products/hpe-proliant-dl160-gen9?srsltid=AfmBOoo38TZ1D3hd-2zD0uRRzomcQ8Yiv_8g0H88s78fxgCsDJEKyy6V	13	70
178	Компьютер Dell Optiplex 7050 MT i5 6500(3.2)/1Tb+1000Gb 7.2k/R5 430 2Gb/DVDRW/ Windows7 Professional 64+W10Pro/GbitEth/240W/	31	0	35	https://icecat.biz/en/p/dell/n141so7050sff02/optiplex-pcs-workstations-7050-51318364.html	13	70
179	Блок ввода-вывода СМС III Арт. №DK 7030.040	2	0	55	https://www.rittal.com/pdf-creator/variant/au-en/7030040	14	20
180	Блок обработки сигналов\nуправления (OPE)	\N	\N	\N	https://www.eternis.ru/catalog/besprovodnaya-sistema-upravleniya-garant-r/blok-bos-aup/	15	75
181	Блок интерфейса (SCIF)	\N	\N	\N	нет данных	15	75
182	Блок сбора и обработки\nхарактеристик\nэлектропитания (MON)	2	5	40	https://interunis-it.ru/ru/products/monitoring/SHM/#characteristics	15	75
183	Блок разряда остаточного\nтока (DISCHARGE)	\N	\N	\N	нет данных	15	75
184	Блок переключения в\nтестовый режим\n(LOAD TRF)	\N	\N	\N	нет данных	15	75
185	Блок обработки\nхарактеристик\nэлектропитания (SV)	\N	\N	\N	нет данных	15	75
186	Блок измерения\nнапряжения (CSVS)\nБлок измерения\nхарактеристик\nэлектропитания (SMON)	\N	\N	\N	нет данных	15	75
187	Блок измерения силы\nтока (S-CONT)	\N	\N	\N	нет данных	15	75
188	Блок контроля заземления\n(EARTH TST)	5	-10	50	https://www.technoac.ru/upload/manuals/rukovodstvo_mi_3290_earth_analyzer.pdf?srsltid=AfmBOorFjFCIf5c13MSUCgnq26GSSX0rGWKBECihXswghsbXoP2_zZgc	15	75
189	Блок управления\nэлектропитанием (DISP)	2	0	50	https://www.atenpro.ru/catalog/intellektualnoe_raspredelenie_pitaniya/ustroystvo_monitoringa_elektropitaniya/blok_upravleniya_pitaniem_po_ip_aten_pe4104g_pe4104g_at_g/?srsltid=AfmBOopXEDSPFQemGNxOSYCfFRPnPk_23b7cZF0FioPFzgsHA5o2Hj4y#props	15	75
190	Автомат ввода резезва ШК 150-3/2 У500	3	1	40	https://keaz.ru/catalog/product/248956	15	75
191	Блок аварийного\nоповещения (ACM)	\N	\N	\N	нет данных	15	75
192	Модульный распределительный блок 0 048 80	\N	\N	\N	http://roomelectro.ru/modulnyj_raspredelitelnyj_blok_legrand_2h7_14_kontaktov_100a/	15	75
193	Двухклавишный переключатель на два направления Plexo 695 25	\N	\N	\N	https://legrand-on.ru/legrand-plexo-legrand-plekso-vyklyuchatel-dvuhklavishnyy-prohodnoy-dvuhklavishnyy-pereklyuchatel-na-dva-napravleniya-10-ax-250-v-seryy-69525?srsltid=AfmBOoplZqrWluMyrXhG6hjrgQfF6-8aQ993EN36AqVtpKJM5mkFiLd1	15	75
194	Модульный контактор ESB 24-22 GHE 329 1302 R 0003	\N	\N	\N	http://roomelectro.ru/620220/	15	75
195	Блок распределения\nнапряжения (PWR)	2	-30	50	https://termoshkaf.com/product/ustrojstvo-netping-2-pwr-220-v12-eth/	15	75
196	Блок распределения напряжения (PWR), тип D	1	-40	50	https://argoivanovo.ru/oborudovanie/prochee/blok-pitaniya-pwr-d20/	15	75
197	Блок усилителя EA-16V/23	1	-40	60	https://www.newnets.ru/catalog/aktivnoe_oborudovanie_wdm/t8/blok_usilitelya_ea_16v_23/	15	75
198	Блок доступа CAN-Bus CMC III Арт. №DK 7030.200 \n\n	1	0	55	https://rittaler.ru/catalog/product/7030100/	15	75
199	Цифровой кодовый замок CMC III Арт. №DK 7030.220	1	0	55	https://rittaler.ru/catalog/product/7030222/	15	75
200	Процессорный блок СМС III Арт. №DK 7030.000	1	0	45	https://rittaler.ru/catalog/product/7030000/	15	75
201	Блок управления CM-2G-3F	\N	\N	\N	нет данных	15	75
202	Блок агрегирующего\nтранспондера MS-100E-T10	1	-40	60	https://trinity.ru/products/netsys/t8/multiservisnaya-platforma-volga/mukspondery-i-transpondery/aggregating-transponder-ms-100e-t10-lh/	15	75
203	Блок агрегатора MS-DC10FX-Q3F/01	1	-40	60	https://tnvst.ru/catalog/oadm-odnovolokonnykh-cwdm-multipleksor-add-drop/blok-agregatora-ms-dc10ep-q3f-o1/	15	75
204	Активный мультиплексор ввода/вывода OADM-4/4-AV-PM	\N	\N	\N	нет данных	15	75
205	Блок интерфейса (SC IF)	\N	\N	\N	нет данных	15	75
206	Блок управления аварийными сигналами (ACM)	\N	\N	\N	https://smtrading.ru/category/moduli-upravleniya-acm-r	15	75
207	Блок усиления отпического сигнала HA [HA(HG)]	1	-5	55	https://www.tvbs.ru/id/opticheskiy-usilitel-24dbm-edfa1550hq-24-tvbs-5007.html	15	75
208	Блок разряда остаточного\nтока (DISCHARGE)	\N	\N	\N	нет данных	15	75
209	Блок контроля\nзаземления (EARTH TST)	\N	\N	\N	нет данных	15	75
210	Блок разветвления\nкабеля (CTB)	\N	\N	\N	нет данных	15	75
211	Блок распределения тока\n(PWR), тип D	2	-30	50	https://plcontroller.ru/product/tp-std-d-18a06b-16l3-blok-rozetok-s-funktsiyami-izmeren/	15	75
212	Блок управления\nаварийными сигналами (ACM)	2	-30	50	нет данных	15	75
213	Блок интерфейса (SC IF)	1	-20	60	https://www.deltronic.ru/node/1623?utm_source=chatgpt.com	15	75
214	Блок генератора длины\nволны (DGW)	\N	\N	\N	нет данных	15	75
215	Блок оптического\nусиления HA [HA(HG)]	\N	\N	\N	нет данных	15	75
216	Блок генератора длины волны (DGW)	\N	\N	\N	нет данных	15	75
217	Блок распределения\nконтрольного сигнала\n(BRC 2)	\N	\N	\N	нет данных	15	75
218	Блок канального\nдемультиплексора\nBDMUX(4BC)	\N	\N	\N	нет данных	15	75
219	Блок контроля\nоптических каналов (OCM)	\N	\N	\N	нет данных	15	75
220	Блок частотного\nразнесения каналов\nMLDX_40GHz [WB401]	\N	\N	\N	нет данных	15	75
221	Блок распределения\nберегового\nэлектропитания (PDP)	\N	\N	\N	нет данных	15	75
222	Блок частотного\nразнесения каналов\nMLDX_40GHz [WB401]	\N	\N	\N	нет данных	15	75
223	Блок смешения каналов\nMLDXIL_40GHz [WB402]	\N	\N	\N	нет данных 	15	75
224	Блок управления\nаварийными сигналами (ACMT)	\N	\N	\N	нет данных	15	75
225	Блок транспондера ST100X\nTPND (2nd Gen) без SFP+	\N	\N	\N	нет данных	15	75
226	Блок резервирования (DCOM)	\N	\N	\N	нет данных	15	75
227	Блок конвертера (CONV)	10	-30	80	https://tdspribor.ru/preobrazovatel-conv-1/	15	75
228	Блок вентиляторный (FAN)	2	0	60	https://www.cmo.ru/catalog/rem/termoregulyatory_gigrostaty/moduli_ventilyatornye/modul_ventilyatornyy_3_ventilyatora_s_termoregulyatorom/	15	75
229	Блок канального\nмультиплексора BMUX(4BC)	\N	\N	\N	https://bouz.ru/catalog/multipleksory_cwdm_odnovolokonnye/multipleksor_cwdm_odnovolokonnyy_4_kanalnyy/?srsltid=AfmBOoqqkwxs5I5eTdRMY-2vEAsLJVU3oGmg1kHM_UTtVbS9JqQmNmy6	15	75
230	Блок обработки\nхарактеристик\nэлектропитания (SV)	\N	\N	\N	https://rittaler.ru/catalog/product/9343370/	15	75
231	Блок переключения в\nтестовый режим\n(LOAD TRF)	\N	\N	\N	нет данных	15	75
232	Блок измерения\nхарактеристик\nэлектропитания (SMON)	\N	\N	\N	нет данных	15	75
233	Блок контроля оптических каналов (ОСМ)	\N	\N	\N	https://stproject.ru/production/sdh-oborudovanie/osm-k-sinhronnyj-multipleksor/	15	75
234	Блок управления аварийными сигналами\n(ACMT)	\N	\N	\N	нет данных 	15	75
235	Блок транспондера ST100X\nTPND (2nd Gen) без SFP+	\N	\N	\N	нет данных 	15	75
236	Блок канального демультиплексора BDMUX(4BC)	\N	\N	\N	нет данных	15	75
237	Блок резервирования (DCOM	\N	\N	\N	нет данных	15	75
238	Блок конвертора (CONV)	\N	\N	\N	нет данных	15	75
239	Блок вентиляторный (FAN)	2	0	60	https://www.cmo.ru/catalog/rem/termoregulyatory_gigrostaty/moduli_ventilyatornye/modul_ventilyatornyy_3_ventilyatora_s_termoregulyatorom/	15	75
240	Блок частотного разнесения каналов MLDX_40GHz [WB401]	\N	\N	\N	нет данных	15	75
241	Блок аварийного\nоповещения (ACM	1	-5	55	https://armtel.com/ru/product/modul-analogovyh-podsistem-asm-ip2-1/	15	75
242	Блок интерфейса (SCIF)	\N	\N	\N	нет данных	15	75
243	Блок обработки сигналов\nуправления (OPE)	\N	\N	\N	https://www.eternis.ru/catalog/besprovodnaya-sistema-upravleniya-garant-r/blok-bos-aup/	15	75
244	Блок канального мультиплексора BMUX(4BC)	2	-20	70	https://bouz.ru/catalog/multipleksory_cwdm_dvukhvolokonnye/multipleksor_cwdm_dvukhvolokonnyy_4_kanalnyy/?srsltid=AfmBOopRLA3cD4AYiV8U0wi_d-ji8fg1_7NVbI0vSTnkqlfLL8eMvr7u	15	75
245	Блок сбора и обработки\nхарактеристик электропитания (MON)	2	5	40	https://interunis-it.ru/ru/products/monitoring/SHM/#characteristics	15	75
246	Блок управления\nэлектропитанием (DISP)	2	0	50	https://www.atenpro.ru/catalog/intellektualnoe_raspredelenie_pitaniya/ustroystvo_monitoringa_elektropitaniya/blok_upravleniya_pitaniem_po_ip_aten_pe4104g_pe4104g_at_g/?srsltid=AfmBOopXEDSPFQemGNxOSYCfFRPnPk_23b7cZF0FioPFzgsHA5o2Hj4y#props	15	75
247	Блок измерения силы\nтока (S-CONT)	\N	\N	\N	нет данных	15	75
248	Блок измерения напряжения\n(CSVS)	\N	\N	\N	нет данных	15	75
249	Блок распределения контрольного сигнала\n(BRC 1)	1	-40	105	https://gbo-world.ru/katalog/elektronnye-komponenty/blok-upravleniya-brc-sequent-plug-drive-6-tsil	15	75
250	Блок распределения\nнапряжения (PWR)	1	-30	50	https://termoshkaf.com/product/ustrojstvo-netping-2-pwr-220-v12-eth/	15	75
251	Жесткий диск HPE 781516-B21	1	5	65	https://www.hp-pro.net/Netshop/Options-Servers-HP/HDD/SAS-SFF/781516-B21.html?srsltid=AfmBOoq9gDRdG5Gjguc99baY6fxG9WBHbIVIE87VsAqftnPvKCchycHK	16	150
252	Жесткий диск HPE 781516-B21	1	5	65	https://www.hp-pro.net/Netshop/Options-Servers-HP/HDD/SAS-SFF/781516-B21.html?srsltid=AfmBOoq9gDRdG5Gjguc99baY6fxG9WBHbIVIE87VsAqftnPvKCchycHK	16	150
253	Оборудование системы\nуправления сетью\nWebNSV EMS (со\nвстроенным ПО)	\N	\N	\N	нет данных	17	\N
254	Оборудование канала\nуправления	\N	\N	\N	нет данных	17	\N
255	Оборудование дистанционного\nконтроля оптического\nволокна M640SW	\N	\N	\N	нет данных	17	\N
256	Оборудование системы\nуправления сетью WebNSV\nEMS (со встроенным ПО)	\N	\N	\N	нет данных	17	\N
257	Оборудование системы\nуправления\nтерминальными станциями	\N	\N	\N	нет данных	17	\N
258	Оборудование канала\nуправления	\N	\N	\N	нет данных	17	\N
259	Светильник «Победа» ШБ1/К50	12	-60	40	https://galad.ru/catalog/outdoor/street/pobeda/galad-pobeda-led-100-shb1-k50/	18	75
260	Осветитель AXIS T90В20 с ИК-ветодиодами	5	-50	50	https://videoglaz.ru/led-podsvetka/axis/axis-t90d20-ir-led-01210-001	18	75
261	Светильник Победа LED-100-ШБ1/К50	12	-60	40	https://galad.ru/catalog/outdoor/street/pobeda/galad-pobeda-led-100-shb1-k50/	18	75
262	Осветитель AXIS T90B20 с ИК-светодиодами	3	-50	50	https://www.axis.com/dam/public/90/f1/86/%D0%BE%D1%81%D0%B2%D0%B5%D1%82%D0%B8%D1%82%D0%B5%D0%BB%D1%8C-axis-t90b20-%D1%81-%D0%B8%D0%BA-%D1%81%D0%B2%D0%B5%D1%82%D0%BE%D0%B4%D0%B8%D0%BE%D0%B4%D0%B0%D0%BC%D0%B8-ru-RU-205620.pdf	18	75
263	Осветитель TIREX ПИК 22F	1	-50	50	https://satro-paladin.com/catalog/product/187725/?srsltid=AfmBOorcRqJB5udEXXpoIXnv7BKRKTEnlE-nMbrdNdYIyLeDlD9Qk08f	18	75
264	Клавиатура/мышь	2	0	30	https://www.logitech.com/en-gb/shop/p/mx-keys-s-combo.920-011613	19	35
265	Клавиатура/мышь	2	0	30	https://www.logitech.com/en-gb/shop/p/mx-keys-s-combo.920-011613	19	35
266	Клавиатура/мышь	2	0	30	https://www.logitech.com/en-gb/shop/p/mx-keys-s-combo.920-011613	19	35
267	Принтер МФУНР LaserJet Pro M227fdn	1	\N	\N	https://www.dns-shop.ru/product/3a939cf318143330/mfu-hp-laserjet-pro-m227fdn--printerkopirskanerfaks-a4-1200x1200dpi-28ppm-800mhz-256mb-duplex-adf-lan-usb20/?utm_medium=organic&utm_source=google&utm_referrer=https%3A%2F%2Fwww.google.com%2F	20	45
268	Телевизор Sony KD65XD7505	1	0	40	https://devicebeast.com/display/sony-kd-65xd7505-645	5	14
269	Видеомонитор Dell U2412M	1	0	40	https://www.dns-shop.kz/product/characteristics/20ae734eea4e526f/monitor-dell-24-ultrasharp-u2412m-black-ips-led-1920x1200-2m1-178gor178ver-8ms-dvidpd-sub-usbx4/	5	14
270	Дополнительный вентилятор Арт. № DK 7980.000	1	-20	80	https://rittaler.ru/catalog/product/7980000/	6	35
271	Вентиляторная панель Арт. № DK 7988.035	1	-20	80	https://rittaler.ru/catalog/product/7988035/	6	35
272	Вентилятор	1	-20	80	нет данных	6	35
273	Вентиляторная панель ДНТВ.651511.002	\N	\N	\N	нет данных	6	35
274	Сетевая камера AXIS P1365 Mk II ф. "AXIS"	\N	\N	\N	нет данных	7	200
275	Камера оптическая трубопроводная КОТ-2-ССД ТУ 2248-001-705792-00	1	-40	60	https://www.ssd.ru/kamera-opticheskaya-truboprovodnaya-kot-2-ssd-new/	7	200
313	Кабель ДНТВ.685633.023 (Кабель силовой медный ВВГнг(A)-LS 3х2,5(N,PE)-0,66 10 м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-3-2_5	11	150
276	Сетевая камера AXIS P1365 MkII	3	-20	60	https://www.vtkt.ru/catalog/security/0897_014_axis_p1365_mk_ii_ip_kamera_korpusnaya_poe_1920x1080_f_2_8_8mm_n112_39/?srsltid=AfmBOop6SLOz3ue9N1DRyg15yvr2P6TGLRBQ0gflx4SgrJL5XpyUUXRf	7	200
277	Телекамера сетевая AXIS P1365 Mk II	3	0	50	https://www.group-sb.ru/catalog/korpusnye-ip/axis-p1365-mk-ii-bareb/	7	200
278	Кожух AXIS T93F10	3	-20	60	https://www.group-sb.ru/catalog/kozhukhi-i-termokozhukhi/axis-t93f10-outdoor-housing-24vac-12-24vdc/	7	200
279	Видеоманитор Dell U2412M	1	0	40	https://www.dns-shop.kz/product/characteristics/20ae734eea4e526f/monitor-dell-24-ultrasharp-u2412m-black-ips-led-1920x1200-2m1-178gor178ver-8ms-dvidpd-sub-usbx4/	8	20
280	Датчик дыма CMC III Арт. №DK 7030.400	1	5	45	https://rittaler.ru/catalog/product/7030400/	9	75
281	Датчик вандализма Арт. №DK 7030.130	1	0	55	https://armatron.ru/datchik-vandalizma-cmc-iii-dk-7030-130-rittal	9	75
282	Датчик температуры/влажности CMC III Арт. №DK 7030.111	1	0	55	https://rittaler.ru/catalog/product/7030111/	9	75
283	Датчик температуры Арт. №DK 7030.110	1	0	55	https://rittaler.ru/catalog/product/7030110/	9	75
284	Датчики CA-Bus CMC III Арт. №DK 7030.100	1	0	55	https://rittal-parts.ru/product/rittal-7030100-datchiki-dlja-bloka-can-bus-iii/	9	75
285	Инфракрасный датчик доступа CMC III Арт. №DK 7030.120	1	0	55	https://rittaler.ru/catalog/product/7030120/	9	75
286	Датчик движения CMC III Арт. №DK 7320.570	1	5	45	https://rittaler.ru/catalog/product/7320570/	9	75
287	Блок питания PS-1200A	1	-25	55	https://manometr-rsc.ru/catalog/ps1200-1/#:~:text=1%20%D0%B1%D0%BB%D0%BE%D0%BA%20%D0%BF%D0%B8%D1%82%D0%B0%D0%BD%D0%B8%D1%8F%2024%D0%92%20(20%20%D0%90),-0&text=%D0%BF%D1%80%D0%B5%D0%B4%D0%BD%D0%B0%D0%B7%D0%BD%D0%B0%D1%87%D0%B5%D0%BD%D1%8B%20%D0%B4%D0%BB%D1%8F%20%D0%BF%D1%80%D0%B5%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20%D1%81%D0%B5%D1%82%D0%B5%D0%B2%D0%BE%D0%B3%D0%BE%20%D0%BF%D0%B5%D1%80%D0%B5%D0%BC%D0%B5%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE,%D0%BE%D1%82%20%D0%BA%D0%BE%D1%80%D0%BE%D1%82%D0%BA%D0%BE%D0%B3%D0%BE%20%D0%B7%D0%B0%D0%BC%D1%8B%D0%BA%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%B8%20%D0%BF%D0%B5%D1%80%D0%B5%D0%B3%D1%80%D1%83%D0%B7%D0%BE%D0%BA.	10	120
288	Блок питания SD-150C-24	5	-10	60	https://www.mean-well.ru/store/SD-150C-24/	10	120
289	Блок питания PS-1600D	\N	\N	\N	https://3logic.ru/products/blok-pitaniya-dps-1600cb-b-psu-1600w-oem-6-43695/	10	120
290	Блок питания AXIS	3	-40	55	https://www.axis.com/dam/public/5e/ff/6b/datasheet-ecp081208-ps-24-v-ru-RU-287294.pdf	10	120
291	Блок питания БП-3А	1	-25	40	https://www.grion.ru/blok-pitaniya-bp-3a-stabilizirovannyiy.html	10	120
292	Источник питания AC/DC (Power supply)	5	-40	60	https://www.mean-well.ru/store/HRP-100-5/	10	120
293	Блок питания СМС III Арт. №DK 7030.060	1	0	40	https://rittaler.ru/catalog/product/7030060/	10	120
294	Комбинированный источник бесперебойного питания Guardian Central GDN.M29, -48 В и \n~ 220 В 50 Гц	\N	\N	\N	нет данных	10	120
295	Кабель ДНТВ.685633.011 (Провод ПуГВ 10,0 кВ 14 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-10	11	150
296	Кабель ДНТВ.685633.001-11 (ВВГ нг 3х2,5ок (N, PE)-0,66кВ 36 м)	\N	\N	\N	нет данных	11	150
297	Кабель ДНТВ.685633.001-12 (ВВГ нг 3х2,5ок (N, PE)-0,66кВ 36 м)	\N	\N	\N	нет данных	11	150
298	Кабель ДНТВ.685633.003 (силовой медный ВШбШв 4х35х0,66 6 м)	20	-50	50	https://e-kc.ru/cena/cable-vbbshv-4-6	11	150
299	Кабель ДНТВ.685633.005 (силовой медный КГВВнг (A)-LS 4х6 (N)-0,66 10 м)	20	-50	50	https://e-kc.ru/cena/cable-kgvvng-ls-4-6	11	150
300	Провод ДНТВ.685633.008 (ПуГВ 10,0 кв. мм, \nL=8 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
301	Провод ДНТВ.685633.013 (Провод ПуГВ 6,0 кв.мм 10 м	20	-50	50	https://e-kc.ru/cena/provod-pugv-6	11	150
302	Кабель ДНТВ.685633.001 (ВВГ нг 3х2,5ок (N, PE)-0,66кВ 32 м)	10	-50	50	https://www.tinko.ru/catalog/product/294211/	11	150
303	Кабель ДНТВ.685633.001 (ВВГ нг 3х2,5ок (N, PE)-0,66кв.мм 36 м)	2	-50	50	https://www.vseinstrumenti.ru/product/kabel-vvg-ng-a-ls-3x2-5ok-n-pe-0-66-buhta-100m-uglichkabel-plls1030205140000000-7890938/	11	150
304	Кабель питающий (на 220В)	1	-15	60	https://robot-kit.ru/Power-220V-cable/#:~:text=%D0%A1%D0%B5%D1%82%D0%B5%D0%B2%D0%BE%D0%B9%20%D0%BA%D0%B0%D0%B1%D0%B5%D0%BB%D1%8C%20Power%2D220V%2Dcable,%D0%B4%D1%80%D1%83%D0%B3%D0%B8%D1%85%20%D0%BF%D1%80%D0%B8%D0%B1%D0%BE%D1%80%D0%BE%D0%B2%2C%20%D0%B8%D0%BC%D0%B5%D1%8E%D1%89%D0%B8%D1%85%20%D1%81%D0%BE%D0%BE%D1%82%D0%B2%D0%B5%D1%82%D1%81%D1%82%D0%B2%D1%83%D1%8E%D1%89%D0%B8%D0%B9%20%D1%80%D0%B0%D0%B7%D1%8A%D0%B5%D0%BC.	11	150
305	Кабель ДНТВ.685633.002 (силовой медный ВШбШв 4х35х0,66кв.мм 31 м)	20	-50	50	https://e-kc.ru/cena/cable-vbbshv-4-35	11	150
306	Кабель ДНТВ.685633.005 (ВВГ нг-LS 4х6-0,66 кв.мм 42м)	30	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-4-6	11	150
307	Провод ДНТВ.685633.007 (ПуГВ 6,0кв. мм 3м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-6	11	150
308	Провод ДНТВ.685633.010 (ПуГВ 10,0кв. мм 50м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
309	Провод ДНТВ.685633.018 (ПуГВ 25,0кв. мм 6м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-25	11	150
310	Волоконно-оптический кабель ДКН-7-6z-6/48	1	-20	70	https://cable.ru/cable/marka-dkn.php	11	150
311	Лента сигнальная «Оптика» с логотипом «Осторожно оптический кабель» 40мм, \n500 п.м.	1	-20	70	https://www.ssd.ru/lso-40-lenta-signalnaya-40mm-500m-100mkm-ya-quot-ostorozhno-opticheskiy-kabel-quot/	11	150
312	Провод ПуГВ 1х4	20	-50	50	https://e-kc.ru/cena/provod-pugv-4	11	150
314	Кабель ДНТВ.685633.025 (провод ПуГВ 1х25 11 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-25	11	150
315	Кабель ДНТВ.685633.026 (провод ПуГВ 1х16 14 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-16	11	150
316	Кабель ДНТВ.685633.028 (провод ПуГВ 1х16(N) 14 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-16	11	150
317	Кабель ДНТВ.685633.029 (провод ПуГВ 1х10(N) 14 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
318	Кабель ДНТВ.685633.030 (провод ПуГВ 1х25(N) 11 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-25	11	150
319	Кабель ДНТВ.685633.031 (провод ПуГВ 1х10(РЕ) 10 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
320	Лента сигнальная "Оптика" с логотипом "Осторожнокабель" ЛСЭ 450 300мкм 450мм х 100м.пог.	\N	\N	\N	нет данных	11	150
321	Провода ПуГВнг (А)-LS 1х2,5	20	-40	65	https://e-kc.ru/cena/provod-pugvng-ls-1-2_5	11	150
322	Провода ПуГВ 1х2,5ок(PE)	20	-50	65	https://e-kc.ru/cena/provod-pugv-2_5	11	150
323	Кабель ВВГ нг 3х2,5ок (N, PE)-0,66 692 м	10	-50	50	https://www.tinko.ru/catalog/product/294211/	11	150
324	Кабель ПвПу2г 1х35/16-6	1	-50	70	https://k-ps.ru/spravochnik/kabeli-silovyie/s-izolyacziej-iz-sshitogo-polietilena-(6kv)/pvpu2g-6kv/kabel-pvpu2g-1x35-16.html	11	150
325	Кабель ДНТВ.685633.012 (Провод ПуГВ 16,0 кВ 10 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-16	11	150
326	Кабель ДНТВ.685633.014 (Провод ПуГВ 25,0 кВ 11 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-25	11	150
327	Кабель ДНТВ.685633.015 (Провод ПуГВ 16,0 кВ 10 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-16	11	150
328	Кабель ДНТВ.685633.016 (Провод ПуГВ 25,0 кВ 11 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-25	11	150
329	Кабель ДНТВ.685633.017 Провод ПуГВ 10,0 кВ 14 м)	20	-50	65	https://e-kc.ru/cena/provod-pugv-10	11	150
330	Кабель ДНТВ.685633.035 (ВВГ нг-LS 3х1,5-0,66 кВ 43м)	5	-50	50	https://www.etm.ru/cat/nn/7200644?srsltid=AfmBOope_3Ln2HFAAjIPmnyrpDGr1cwsqBh_iFQrbuaR9wRZeLSHB4l6	11	150
331	Волоконно-оптический кабель ДКНа-20-9z-4/8 ТУ 3587-007-51702873-2015	\N	\N	\N	нет данных	11	150
332	Кабель ДНТВ.685633.006 (ВВГ нг-LS 3х1,5-0,66 кВ 43м)	5	-50	50	https://www.etm.ru/cat/nn/7200644?srsltid=AfmBOoqrOWfZ_Qe6rnVpQaiiyRGXQFCTckcX3fyAkyCY5YpBL61HdImk	11	150
333	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 135 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
334	Кабель ДНТВ.685633.004(силовой медный ВШбШв 4х35х0,66 43 м)	\N	\N	\N	нет данных 	11	150
335	Кабель ДНТВ.685633.002 (силовой медный ВШбШв 4х35х0,66 32 м)	1	-50	50	http://roomelectro.ru/kabel_silovoj_mednyj_bronirovannyj_vbbshv_4h35/	11	150
336	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 115 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
337	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 89 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
338	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 67 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
339	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 153 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
340	Кабель комбинированный ДНТВ.685662.154 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 67 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
341	Кабель питания ДНТВ.685621.001 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE, ветвь кабеля 2х1,5 PE. 0,2 м)	20	-60	79	нет данных	11	150
342	Кабель ДНТВ.685633.001-04 (ВВГ нг 3х2,5ок (N, PE)-0,66кв.мм 10 м)	1	-50	50	https://www.vseinstrumenti.ru/product/kabel-vvg-ng-a-ls-3x2-5ok-n-pe-0-66-buhta-50m-uglichkabel-plls1030205140000000-05-7890944/#description	11	150
343	Волоконно-оптический кабель OCC-SC530(4FP), двубронный	\N	\N	\N	нет данных	11	150
344	Провод ПВ3 1х10	1	-20	60	https://electro-shop24.ru/catalog/provod-kabel/provod-pugvv-pv-3/provod-pv-3-1kh10-gost/	11	150
345	Провод ПуГВнг(А)-LS 1х2,5	1	-40	65	https://www.etm.ru/cat/nn/1817072?srsltid=AfmBOorgbOTIHUmQRkEEHlofnsiHYztluGQ-xlCwgqOhgB8w_uX8rfHQ	11	150
346	Волоконно-оптический кабель OCC-SC530(4FP), однобронный	1	-50	70	https://www.ssd.ru/kabel-okk-12khg-652d-2-7kn/	11	150
347	Подводный волоконно-оптический репитер,\nс защищенным кабельным вводом Т-Т, 4FP	\N	\N	\N	нет данных	11	150
348	Подводный электрический кабель	1	-60	50	https://cable.ru/cable/marka-vp_2x0_7.php#attributes	11	150
349	Кабель ВВГ нг 2х2,5ок (N)-0,66 330 м	\N	\N	\N	https://nes.spb.ru/product/vvgng-a-ls-2x2-5ok-n-0-66/	11	150
350	Кабель ДНТВ.685633.009 (провод ПуГВ 6,0 кВ 10м)	3	-50	50	https://www.vseinstrumenti.ru/product/elektricheskij-provod-pugv-provodnik-1x6-mm2-belyj-10m-oz250757l10-7929608/#description	11	150
351	Кабель ДНТВ.685633.033 (провод ПуГВ 1х10 15 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
352	Столбик замерный кабельный	1	-40	60	https://www.ssd.ru/stolbik-zamernyy-kabelnyy-polimernyy-szk-1-seryy/	11	150
353	Кабель ДНТВ.685633.023 (Кабель силовой медный ВВГнг(А)-LS 3x25(NPE)-0,66 32 м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-4-6	11	150
354	ДНТВ.685662.001 (Кабель UTP кат. 5e) L=10 м	3	-15	60	ссылок на информацию нет ()	11	150
355	Кабель комбинированный ДНТВ.685662.155 (ParLan combi F/UTP2 Cat5e + 2х1,5 PE 46 м)	20	-60	79	https://www.tinko.ru/catalog/product/228481/	11	150
356	Колодец кабельный ККС	1	-50	60	https://europlast-ltd.ru/kolodec/kolodtsy-kabelnoj-svjazi/kabelnyj-kolodets-ks-mikro-h290-tsvet-chernyj-15338	11	150
357	Ввод кабельный распорный JM-SIM-122S070SB 40мм, диаметр кабеля (9-14,5) мм	1	-40	60	http://www.ot-k.ru/materialy-dlya-zaduvki/vvody-kabelnye-raspornye/vvod-kabelnyy-raspornyy-k-tvr-40-9-14-5-1	11	150
358	Ввод кабельный распорный К-ТВР-40/611/1	1	-40	60	нет ссылки	11	150
359	Ввод кабельный распорный \nК-ТВР-40/9-14,5/1, диаметр трубы 40 мм, диаметр кабеля (9-14,5) мм	1	-40	60	http://www.ot-k.ru/materialy-dlya-zaduvki/vvody-kabelnye-raspornye/vvod-kabelnyy-raspornyy-k-tvr-40-9-14-5-1	11	150
360	Кабель ДНТВ.685633.020 (Кабель силовой медный ВВГнг(А)-LS 4x6ок(N)-0,66 22м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-4-6	11	150
361	Кабель ДНТВ.685633.022 (Кабель силовой медный ВВГнг(А)-LS 4x6ок(N)-0,66 44 м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-4-6	11	150
362	Провод ДНТВ.685633.024 (провод ПуГВ 1х25(РЕ) 6м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-25	11	150
363	Провод ДНТВ.685633.034 (провод ПуГВ 1х10(РЕ) 22м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
364	Кабель ВВГнг(А)-LS 3x2,5ок(N, РЕ)-0,66	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-3-2_5	11	150
365	Контейнер проводов заземления КПЗ-М ГК-У248.00.000ЭТ	1	-40	60	https://www.ssd.ru/konteyner-provodov-zazemleniya-kpz-m/	11	150
366	Кабель оптический LC/LC-SM-3MM-duplex-5м L = 5 м	1	-20	70	https://fibertool.by/catalog/pasive/patch_kordy_opticheskie/lasercords_lc_sc_sm_duplex_3mm_patch_kord_5m/	11	150
367	Кабель PC-LPM-SFTP-RJ45-C5e-3M-LSZH-BK F/UTP, экранированный, Cat.5e, LSZH, L = 3 м\n	1	-10	60	https://www.vseinstrumenti.ru/product/patch-kord-hyperline-pc-lpm-sftp-rj45-rj45-c5e-3m-lszh-bk-sf-utp-ekranirovannyj-cat-5e-100-fluke-component-tested-lszh-3-m-chernyj-264366-7288111/	11	150
368	Кабель HAMA H-83073 HDMI (m)- HDMI (m), 10m L = 10 м	5	-10	60	https://www.citilink.ru/product/kabel-audio-video-hama-h-83073-hdmi-m-hdmi-m-10m-gold-chernyi-00083073-823862/	11	150
369	Кабель для программирования СМСIII арт. № DK 7030.080 RJ45 L = 3 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030480/	11	150
370	Cоединительный кабель CAN-Bus CMCIII. Арт. №DK 7030.095 Слаботочный RJ45 L = 10 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030095/	11	150
371	Cоединительный кабель CAN-Bus CMCIII. Арт. №DK 7030.094 Слаботочный RJ45 L = 5 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030094/	11	150
372	Cоединительный кабель CAN-Bus CMCIII. Арт. №DK 7030.093 Слаботочный RJ45 L = 2 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030093/	11	150
373	Cоединительный кабель CAN-Bus CMCIII Арт. №DK 7030.091 Слаботочный RJ45 L = 1 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030091/	11	150
374	Cоединительный кабель CAN-Bus CMCIII Арт. №DK 7030.090. Слаботочный RJ45 L = 0,5 м	2	0	55	https://simatix.ru/product/SOEDINITELNYJKABELCANBUSCMCIIIDK7030090/	11	150
375	Кабель подключения CMC III Арт. №DK 7200.210 L = 1,8 м	2	0	55	https://rittaler.ru/catalog/product/7200210/	11	150
376	Кабель оптический FC/LC-SM-3mm-duplex-5м L = 5 м	1	-20	70	https://componentltd.ru/catalog/patch-kordy-opticheskie/patch-kord-opticheskiy-fc-lc-upc-sm-9-125mkm-duplex-3-0mm-5m/	11	150
377	Кабель ДНТВ.685633.019 (Кабель силовой медный ВБШв 4х35мк(N)-0,66 22 м)	20	-50	50	https://e-kc.ru/cena/cable-vbshv-4-35	11	150
378	Кабель ВВГнг(А)-LS 2x2,5ок(N)-0,66	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-2-2_5	11	150
379	Столбик замерный кабельный	1	-40	60	https://www.ssd.ru/stolbik-zamernyy-kabelnyy-polimernyy-szk-1-seryy/	11	150
380	Провод ПуГВ 1х4	1	-50	65	https://e-kc.ru/cena/provod-pugv-4	11	150
381	Кабель ДНТВ.685633.001 (Кабель ВВГнг-LS 3х2,5-0,66кВ 32 м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-3-2_5	11	150
382	Лента сигнальная «Оптика» с логотипом «Осторожно оптический кабель» 40 мм, 500 п.м. (ж/ч) (желто-черный)	1	-10	52	https://www.vseinstrumenti.ru/product/signalnaya-lenta-s-logotipom-ostorozhno-opticheskij-kabel-protekt-40mm-500-p-m-lso-40-500-zh-ch-1081673/#description	11	150
383	Кабель ДНТВ.685633.003 (Кабель силовой медный ВБбШв 4х35-0,66 6 м)	20	-50	50	https://e-kc.ru/cena/cable-vbbshv-4-35	11	150
384	Кабель ДНТВ.685633.005 (кабель силовой медный ВВГнг-LS 4х6-0,66 10 м)	20	-50	50	https://e-kc.ru/cena/cable-vvgng-ls-4-6	11	150
385	Волоконно-оптический кабель ДКН-7-9z-4/8 ТУ 3587-007-51702873-2015	1	-20	70	нет ссылок	11	150
386	Провод ПуГВ 1х2,5 (РЕ)	20	-50	50	https://e-kc.ru/cena/provod-pugv-2_5	11	150
387	Волоконно-оптический кабель ДПа-2,7-9z-6/8 ТУ 3587-007-51702873-2015	1	-20	70	нет ссылок	11	150
388	Волоконно-оптический кабель ДКПа-20-9z-4/8 ТУ 3587-007-51702873-2015	1	-20	70	нет ссылок	11	150
389	Волоконно-оптический кабель ДНа-2,7-9z-6/8 ТУ 3587-007-51702873-2015	1	-20	70	нет ссылок	11	150
390	Кабель ДНТВ.685633.008 (Провод ПуГВ 10,0 кв. мм 8м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-10	11	150
391	Кабель ДНТВ.685633.013 (Провод ПуГВ 6,0 кв.мм 10м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-6	11	150
392	Кабель ДНТВ.685633.009 (Провод ПуГВ 6,0 кв. мм 10 м)	20	-50	50	https://e-kc.ru/cena/provod-pugv-6	11	150
393	Шнур оптический соединительный (ШОС)\nsimplex FC/UPC-SC/UPC-SM-3мм-simplex	1	-20	70	https://www.ssd.ru/shnur-shos-sm-3-0-mm-fc-upc-fc-upc-1-0-m-/	11	150
394	Шнур оптический соединительный (ШОС)\nsimplex SC/UPC-SC/UPC SM-3мм-simplex	1	-20	70	https://www.ssd.ru/shnur-shos-sm-3-0-mm-sc-upc-sc-upc-1-0-m-/	11	150
395	Муфта соединительная ТСЦР.687113.004	1	-40	60	https://gf-shop.ru/mufta-soedinitelnaya-jeelex-20x20?srsltid=AfmBOop8dnRFgO66o84Qu6bCcC8mxTkMkH3BsM6Vad3c9HoKC2iYDehR	11	150
396	Муфта разветвительная FOSC-500AA-S24-LT-NN	1	-40	60	https://stc-energy.ru/catalog/komponenty_opticheskikh_kabelnykh_sistem_vols/mufty_dlya_vols/mufty_te_connectivity/prokhodnye_mufty/mufty_fosc_350_fosc_500/mufta_opticheskaya_prokhodnaya_fosc_500aa_s24_lt_nn/	11	150
397	Подводная муфта для кабеля OCC-SC530	1	-40	60	https://pondsystem.ru/unterwasser-kabelverbinder-gr-1-unverpackt-168-3321-kabel-naya-mufta-podvodnaya-5x2-5-mm2-6-13-mm-bez-upakovki.html	11	150
398	Муфта соединительная для кабеля морского\nзаземления типа POLJ 12/1x25-70	1	-40	60	https://raychem.su/mufty-raychem/soedinitelnye/polj/polj-121x25-70	11	150
399	Блок разветвления\nкабеля (CTB)	\N	\N	\N	https://snk-s.ru/ru/ctb-12p	11	150
400	Муфта разветвительная RAYCHEM FOSC-500AA-S24-LT-NN	\N	\N	\N	https://sunnet-omsk.ru/cgi-bin/katalog_new.cgi?dir1&28&dir2&454&dir3&&podr&3046	11	150
401	Муфта соединительная для кабеля морского\nзаземления типа POLJ 12/1x25-70-CЕЕ01	1	-40	60	https://raychem.su/mufty-raychem/soedinitelnye/polj/polj-121x25-70-cee01	11	150
402	Главная шина заземления ГШВ	\N	\N	\N	https://www.dkc.ru/ru/catalog/1130/NE2020/	11	150
403	Волоконно-оптический соединитель ШОС-LC-FC-SM-3мм-Duplex-10м	1	-20	70	https://componentltd.ru/catalog/patch-kordy-opticheskie/patch-kord-opticheskiy-fc-lc-upc-sm-9-125mkm-duplex-3-0mm-10m/	11	150
404	Устройство морского заземлителя	\N	\N	\N	нет данных 	11	150
405	Распределительный блокРБ-125 1П 125А 1 шина8 присоединений	\N	\N	\N	https://www.electro-mpo.ru/catalog/shiny_izolyatory_peremychki/e21_raspredelitelnye_bloki/e1571-raspredelitelnyy-blok-rb-125-1-polyus-125a-1/	11	150
406	Оптический приемо- передающий модуль XFP-MR-10	\N	\N	\N	нет данных	11	150
407	Соединительный шнур RJ45	1	-20	60	https://www.dns-shop.ru/product/6de285e58335526f/prohodnoj-soedinitelnyj-adapter-rj45-5bites-8p8c-rj-45/?utm_medium=organic&utm_source=google&utm_referrer=https%3A%2F%2Fwww.google.com%2F	11	150
408	Шнур оптический Duplex \nLC/APC-FC/APC-SM- 20m-3mm	1	-40	70	https://www.vseinstrumenti.ru/product/opticheskij-dvojnoj-shnur-fops-patch-kord-dupleks-dx-lc-apc-fc-upc-9-125-2-0-lszh-3m-138-3297488/	11	150
409	Шнур оптический Duplex \nSMLC/UPC-FC/UPC-SM-20m-3mm	1	-40	70	https://componentltd.ru/catalog/patch-kordy-opticheskie/patch-kord-opticheskiy-fc-sc-upc-sm-9-125mkm-duplex-3-0mm-20m/	11	150
410	Шнур оптический Simplex \nLC/APC-LC/UPC-SM-05m-2mm	1	-40	70	https://shop.nag.ru/catalog/01898.patch-kordy-opticheskie/12425.patchkord-opticheskij-sm-lc-lc/15491.snr-pc-lcupc-lcapc-dpx-05m	11	150
411	Шнур оптический Simplex \nLC/APC-LC/APC-SM-05m-2mm	1	-40	70	https://bestcable.ru/catalog/volokonno_opticheskie_linii_svyazi_vols/passivnye_komponenty/pigteyly_opticheskie/shnur_opticheskiy_lc_upc_lc_apc_simplex_sm_2mm_0_5m/	11	150
412	Ethernet-коммутатор\nMES3316F AC	1	-10	45	https://eltexcm.ru/catalog/ethernet-kommutatory/kommutatory-agregacii-1g10g/mes3316f.html?srsltid=AfmBOopIWflkoDzrTJ5eUNcllHB5jTgc6k5V7-8I8H2wUH80oqxzYWNq	11	150
413	Соединительный шнур\nEthernet UTPCat5е, RJ45 2м	1	-20	60	https://www.ozon.ru/product/kabel-dlya-podklyucheniya-interneta-2-m-lan-provod-internet-patch-kord-vitaya-para-utpcat5e-rj45-918231197/?abt_att=1&origin_referer=www.google.com	11	150
414	Оптический приемо- передающий модуль SFP+MR-10	\N	\N	\N	нет данных	11	150
415	Ethernet-коммутатор MES3316F DC	1	-10	45	https://eltex-co.ru/catalog/mes3316f/#compatibility	11	150
416	FG-750ST-DCOR-aa-bb-ccdd- ff-gg EXFO Fiber\nguardian-OTDR	1	-5	50	http://www.exforus.ru/products/index.php?id=164	11	150
417	Шнур оптическийсоединительный (ШОС)\nLC/UPC-LC/UPC-SM-3mm-duplex, 5м	1	-20	70	https://www.ssd.ru/shnur-shos-sm-3-0-mm-lc-upc-lc-upc-3-0-m/	11	150
418	Шнур оптический соединительный (ШОС)\nLC/UPC-LC/UPC-SM-3mm-duplex, 10м	1	-20	70	https://componentltd.ru/catalog/patch-kordy-opticheskie/patch-kord-opticheskiy-sc-lc-upc-sm-9-125mkm-duplex-3-0mm-10m/	11	150
419	NS-Gate R214-A2 Корзина 2u на 14 устройств\nnf-W02L, nf-SFP, nfg-SFP nft-SFP, 2x220VAC	\N	\N	\N	https://www.nsgate.ru/nsgate_chassis_phaseout.shtml	11	150
420	Оптический шнур 2LC/UPC-2LC/UPC-SM	1	-20	70	https://componentltd.ru/catalog/kabelnye-sborki-na-vnutrennem-i-vneshnem-kabele-co-ts-otts/opticheskaya-kabelnaya-sborka-2lc-upc-2lc-upc-sm-20m-na-kabele-otts-2a-1-5/	11	150
421	NS-Gate NF-SFP конвертер: 155 Mbps sfp слот, 1 порт Ethernet 10/100Base-TX	1	\N	\N	https://nsgate.ru/nsgate_nfgsfp_phaseout.shtml	11	150
422	Ethernet-коммутатор MES3124AC	1	-10	45	https://eltex-co.ru/catalog/mes3124/	11	150
423	Оптический приемо- передающий модуль SFPD-MR-80-F	\N	\N	\N	нет данных	11	150
424	Оптический приемо- передающий модуль\nSFP-GE-10	\N	\N	\N	нет данных	11	150
425	Муфта разветвительная RAYCHEM FOSC-350C-24-1-000\n	1	-40	60	https://www.kross-kontakt.ru/opticheskie-mufty/fosc-350c	11	150
426	Комплект для ввода ОК FOSC-350С-CABLE-KIT	1	-40	60	https://kross-kontakt.ru/opticheskie-mufty/prinadlezhnosti-dlya-opticheskikh-muft/fosc-350c-cable-kit	11	150
427	Муфта разветвительная RAYCHEMFOSC-500AA-S24-LT-NN	1	-40	60	https://stc-energy.ru/catalog/komponenty_opticheskikh_kabelnykh_sistem_vols/mufty_dlya_vols/mufty_te_connectivity/prokhodnye_mufty/mufty_fosc_350_fosc_500/mufta_opticheskaya_prokhodnaya_fosc_500aa_s24_lt_nn/	11	150
428	Муфта соединительная компрессионная 040 мм ГПП	1	-40	60	https://komsis.su/product/mufta-soedinit-kompressionnaia-040kh040-mm-sab-gppfitingi-pe-kompressionnye/	11	150
429	Волоконно-оптический соединитель ШОС-FC/APC-FC-SM-3мм-Simplex-10м	1	-20	50	https://cabeus.ru/product/6885/	11	150
430	Волоконно-оптический соединитель ШОС-L-FC-SM-3мм-Duplex-5м	1	-20	70	https://fibertool.ru/catalog/pasive/patch_kordy_opticheskie/lasercords_fc_sc_sm_duplex_3mm_patch_kord_5m/	11	150
431	Фиксированный аттенюатор LC/APC-SM-05dB	1	-40	85	https://shop.nag.ru/catalog/02653.attenyuatory-opticheskie/07139.attenyuatory-opticheskie-sc/08418.snr-att-mf-scapc-05db#properties	12	180
432	Фиксированный аттенюатор LC/APC-SM-10dB	1	-40	85	https://cabeus.ru/product/7559/	12	180
433	Фиксированный аттенюатор LC/UPC-SM-10dB	1	-40	85	https://fibotelecom.ru/catalog/passivnye_komponenty_1/attenyuatory/attenyuator_lc_upc_10db	12	180
434	TS8 Комфортная ручка Арт. №DK 7320.721	1	0	55	https://rittaler.ru/catalog/product/7320794/	12	180
435	Коммутатор доступа Eltex MES2324B	1	-20	50	https://eltex-co.ru/catalog/mes2324b/	12	180
436	Коммутатор доступа Eltex MES2348B	1	-20	50	https://eltex-co.ru/catalog/mes2348b/	12	180
437	Сервер HPE Proliant D160 Gen9	1	10	35	https://www.expresscomputersystems.com/products/hpe-proliant-dl160-gen9?srsltid=AfmBOoo38TZ1D3hd-2zD0uRRzomcQ8Yiv_8g0H88s78fxgCsDJEKyy6V	13	70
438	Компьютер Dell Optiplex 7050 MT i5 6500(3.2)/1Tb+1000Gb 7.2k/R5 430 2Gb/DVDRW/ Windows7 Professional 64+W10Pro/GbitEth/240W/	31	0	35	https://icecat.biz/en/p/dell/n141so7050sff02/optiplex-pcs-workstations-7050-51318364.html	13	70
439	Серверный аппаратный комплект 7: кластерное решение, АС	\N	\N	\N	нет данных	13	70
440	Компьютер Dell Optiplex 7050 MT i5 6500(3.2)/1Tb+1000Gb 7.2k/R5 430 2Gb/DVDRW/ Windows7 Professional 64+W10Pro/GbitEth/240W/	31	0	35	https://icecat.biz/en/p/dell/n141so7050sff02/optiplex-pcs-workstations-7050-51318364.html	13	70
441	Консоль управления KVM на один сервер (USB)	3	-40	60	https://www.kvm-s.ru/catalog/kvm_oborudovanie/kvm_konsoli/kvm_konsol_s_pereklyuchatelem_aten_cl5708m_cl5708m_ata_rg/#props	13	70
442	Сервер HPE Proliant D160 Gen9	1	10	35	https://www.expresscomputersystems.com/products/hpe-proliant-dl160-gen9?srsltid=AfmBOoo38TZ1D3hd-2zD0uRRzomcQ8Yiv_8g0H88s78fxgCsDJEKyy6V	13	70
443	Компьютер Dell Optiplex 7050 MT i5 6500(3.2)/1Tb+1000Gb 7.2k/R5 430 2Gb/DVDRW/ Windows7 Professional 64+W10Pro/GbitEth/240W/	31	0	35	https://icecat.biz/en/p/dell/n141so7050sff02/optiplex-pcs-workstations-7050-51318364.html	13	70
444	Блок ввода-вывода СМС III Арт. №DK 7030.040	2	0	55	https://www.rittal.com/pdf-creator/variant/au-en/7030040	14	20
445	Блок обработки сигналов\nуправления (OPE)	\N	\N	\N	https://www.eternis.ru/catalog/besprovodnaya-sistema-upravleniya-garant-r/blok-bos-aup/	15	75
446	Блок интерфейса (SCIF)	\N	\N	\N	нет данных	15	75
447	Блок сбора и обработки\nхарактеристик\nэлектропитания (MON)	2	5	40	https://interunis-it.ru/ru/products/monitoring/SHM/#characteristics	15	75
448	Блок разряда остаточного\nтока (DISCHARGE)	\N	\N	\N	нет данных	15	75
449	Блок переключения в\nтестовый режим\n(LOAD TRF)	\N	\N	\N	нет данных	15	75
450	Блок обработки\nхарактеристик\nэлектропитания (SV)	\N	\N	\N	нет данных	15	75
451	Блок измерения\nнапряжения (CSVS)\nБлок измерения\nхарактеристик\nэлектропитания (SMON)	\N	\N	\N	нет данных	15	75
452	Блок измерения силы\nтока (S-CONT)	\N	\N	\N	нет данных	15	75
453	Блок контроля заземления\n(EARTH TST)	5	-10	50	https://www.technoac.ru/upload/manuals/rukovodstvo_mi_3290_earth_analyzer.pdf?srsltid=AfmBOorFjFCIf5c13MSUCgnq26GSSX0rGWKBECihXswghsbXoP2_zZgc	15	75
454	Блок управления\nэлектропитанием (DISP)	2	0	50	https://www.atenpro.ru/catalog/intellektualnoe_raspredelenie_pitaniya/ustroystvo_monitoringa_elektropitaniya/blok_upravleniya_pitaniem_po_ip_aten_pe4104g_pe4104g_at_g/?srsltid=AfmBOopXEDSPFQemGNxOSYCfFRPnPk_23b7cZF0FioPFzgsHA5o2Hj4y#props	15	75
455	Автомат ввода резезва ШК 150-3/2 У500	3	1	40	https://keaz.ru/catalog/product/248956	15	75
456	Блок аварийного\nоповещения (ACM)	\N	\N	\N	нет данных	15	75
457	Модульный распределительный блок 0 048 80	\N	\N	\N	http://roomelectro.ru/modulnyj_raspredelitelnyj_blok_legrand_2h7_14_kontaktov_100a/	15	75
458	Двухклавишный переключатель на два направления Plexo 695 25	\N	\N	\N	https://legrand-on.ru/legrand-plexo-legrand-plekso-vyklyuchatel-dvuhklavishnyy-prohodnoy-dvuhklavishnyy-pereklyuchatel-na-dva-napravleniya-10-ax-250-v-seryy-69525?srsltid=AfmBOoplZqrWluMyrXhG6hjrgQfF6-8aQ993EN36AqVtpKJM5mkFiLd1	15	75
459	Модульный контактор ESB 24-22 GHE 329 1302 R 0003	\N	\N	\N	http://roomelectro.ru/620220/	15	75
460	Блок распределения\nнапряжения (PWR)	2	-30	50	https://termoshkaf.com/product/ustrojstvo-netping-2-pwr-220-v12-eth/	15	75
461	Блок распределения напряжения (PWR), тип D	1	-40	50	https://argoivanovo.ru/oborudovanie/prochee/blok-pitaniya-pwr-d20/	15	75
462	Блок усилителя EA-16V/23	1	-40	60	https://www.newnets.ru/catalog/aktivnoe_oborudovanie_wdm/t8/blok_usilitelya_ea_16v_23/	15	75
463	Блок доступа CAN-Bus CMC III Арт. №DK 7030.200 \n\n	1	0	55	https://rittaler.ru/catalog/product/7030100/	15	75
464	Цифровой кодовый замок CMC III Арт. №DK 7030.220	1	0	55	https://rittaler.ru/catalog/product/7030222/	15	75
465	Процессорный блок СМС III Арт. №DK 7030.000	1	0	45	https://rittaler.ru/catalog/product/7030000/	15	75
466	Блок управления CM-2G-3F	\N	\N	\N	нет данных	15	75
467	Блок агрегирующего\nтранспондера MS-100E-T10	1	-40	60	https://trinity.ru/products/netsys/t8/multiservisnaya-platforma-volga/mukspondery-i-transpondery/aggregating-transponder-ms-100e-t10-lh/	15	75
468	Блок агрегатора MS-DC10FX-Q3F/01	1	-40	60	https://tnvst.ru/catalog/oadm-odnovolokonnykh-cwdm-multipleksor-add-drop/blok-agregatora-ms-dc10ep-q3f-o1/	15	75
469	Активный мультиплексор ввода/вывода OADM-4/4-AV-PM	\N	\N	\N	нет данных	15	75
470	Блок интерфейса (SC IF)	\N	\N	\N	нет данных	15	75
471	Блок управления аварийными сигналами (ACM)	\N	\N	\N	https://smtrading.ru/category/moduli-upravleniya-acm-r	15	75
472	Блок усиления отпического сигнала HA [HA(HG)]	1	-5	55	https://www.tvbs.ru/id/opticheskiy-usilitel-24dbm-edfa1550hq-24-tvbs-5007.html	15	75
473	Блок разряда остаточного\nтока (DISCHARGE)	\N	\N	\N	нет данных	15	75
474	Блок контроля\nзаземления (EARTH TST)	\N	\N	\N	нет данных	15	75
475	Блок разветвления\nкабеля (CTB)	\N	\N	\N	нет данных	15	75
476	Блок распределения тока\n(PWR), тип D	2	-30	50	https://plcontroller.ru/product/tp-std-d-18a06b-16l3-blok-rozetok-s-funktsiyami-izmeren/	15	75
477	Блок управления\nаварийными сигналами (ACM)	2	-30	50	нет данных	15	75
478	Блок интерфейса (SC IF)	1	-20	60	https://www.deltronic.ru/node/1623?utm_source=chatgpt.com	15	75
479	Блок генератора длины\nволны (DGW)	\N	\N	\N	нет данных	15	75
480	Блок оптического\nусиления HA [HA(HG)]	\N	\N	\N	нет данных	15	75
481	Блок генератора длины волны (DGW)	\N	\N	\N	нет данных	15	75
482	Блок распределения\nконтрольного сигнала\n(BRC 2)	\N	\N	\N	нет данных	15	75
483	Блок канального\nдемультиплексора\nBDMUX(4BC)	\N	\N	\N	нет данных	15	75
484	Блок контроля\nоптических каналов (OCM)	\N	\N	\N	нет данных	15	75
485	Блок частотного\nразнесения каналов\nMLDX_40GHz [WB401]	\N	\N	\N	нет данных	15	75
486	Блок распределения\nберегового\nэлектропитания (PDP)	\N	\N	\N	нет данных	15	75
487	Блок частотного\nразнесения каналов\nMLDX_40GHz [WB401]	\N	\N	\N	нет данных	15	75
488	Блок смешения каналов\nMLDXIL_40GHz [WB402]	\N	\N	\N	нет данных 	15	75
489	Блок управления\nаварийными сигналами (ACMT)	\N	\N	\N	нет данных	15	75
490	Блок транспондера ST100X\nTPND (2nd Gen) без SFP+	\N	\N	\N	нет данных	15	75
491	Блок резервирования (DCOM)	\N	\N	\N	нет данных	15	75
492	Блок конвертера (CONV)	10	-30	80	https://tdspribor.ru/preobrazovatel-conv-1/	15	75
493	Блок вентиляторный (FAN)	2	0	60	https://www.cmo.ru/catalog/rem/termoregulyatory_gigrostaty/moduli_ventilyatornye/modul_ventilyatornyy_3_ventilyatora_s_termoregulyatorom/	15	75
494	Блок канального\nмультиплексора BMUX(4BC)	\N	\N	\N	https://bouz.ru/catalog/multipleksory_cwdm_odnovolokonnye/multipleksor_cwdm_odnovolokonnyy_4_kanalnyy/?srsltid=AfmBOoqqkwxs5I5eTdRMY-2vEAsLJVU3oGmg1kHM_UTtVbS9JqQmNmy6	15	75
495	Блок обработки\nхарактеристик\nэлектропитания (SV)	\N	\N	\N	https://rittaler.ru/catalog/product/9343370/	15	75
496	Блок переключения в\nтестовый режим\n(LOAD TRF)	\N	\N	\N	нет данных	15	75
497	Блок измерения\nхарактеристик\nэлектропитания (SMON)	\N	\N	\N	нет данных	15	75
498	Блок контроля оптических каналов (ОСМ)	\N	\N	\N	https://stproject.ru/production/sdh-oborudovanie/osm-k-sinhronnyj-multipleksor/	15	75
499	Блок управления аварийными сигналами\n(ACMT)	\N	\N	\N	нет данных 	15	75
500	Блок транспондера ST100X\nTPND (2nd Gen) без SFP+	\N	\N	\N	нет данных 	15	75
501	Блок канального демультиплексора BDMUX(4BC)	\N	\N	\N	нет данных	15	75
502	Блок резервирования (DCOM	\N	\N	\N	нет данных	15	75
503	Блок конвертора (CONV)	\N	\N	\N	нет данных	15	75
504	Блок вентиляторный (FAN)	2	0	60	https://www.cmo.ru/catalog/rem/termoregulyatory_gigrostaty/moduli_ventilyatornye/modul_ventilyatornyy_3_ventilyatora_s_termoregulyatorom/	15	75
505	Блок частотного разнесения каналов MLDX_40GHz [WB401]	\N	\N	\N	нет данных	15	75
506	Блок аварийного\nоповещения (ACM	1	-5	55	https://armtel.com/ru/product/modul-analogovyh-podsistem-asm-ip2-1/	15	75
507	Блок интерфейса (SCIF)	\N	\N	\N	нет данных	15	75
508	Блок обработки сигналов\nуправления (OPE)	\N	\N	\N	https://www.eternis.ru/catalog/besprovodnaya-sistema-upravleniya-garant-r/blok-bos-aup/	15	75
509	Блок канального мультиплексора BMUX(4BC)	2	-20	70	https://bouz.ru/catalog/multipleksory_cwdm_dvukhvolokonnye/multipleksor_cwdm_dvukhvolokonnyy_4_kanalnyy/?srsltid=AfmBOopRLA3cD4AYiV8U0wi_d-ji8fg1_7NVbI0vSTnkqlfLL8eMvr7u	15	75
510	Блок сбора и обработки\nхарактеристик электропитания (MON)	2	5	40	https://interunis-it.ru/ru/products/monitoring/SHM/#characteristics	15	75
557	Оптический трансиверSFP 1310/1550нм \n155 Мбит/с 10км LC	1	0	70	https://prointech.ru/catalog/transivery/opticheskie-moduli-sfp/opticheskij-dvuhvolokonnyj-modul-sfp-1310-nm-155-mbit-s-10-km-lc/	22	300
511	Блок управления\nэлектропитанием (DISP)	2	0	50	https://www.atenpro.ru/catalog/intellektualnoe_raspredelenie_pitaniya/ustroystvo_monitoringa_elektropitaniya/blok_upravleniya_pitaniem_po_ip_aten_pe4104g_pe4104g_at_g/?srsltid=AfmBOopXEDSPFQemGNxOSYCfFRPnPk_23b7cZF0FioPFzgsHA5o2Hj4y#props	15	75
512	Блок измерения силы\nтока (S-CONT)	\N	\N	\N	нет данных	15	75
513	Блок измерения напряжения\n(CSVS)	\N	\N	\N	нет данных	15	75
514	Блок распределения контрольного сигнала\n(BRC 1)	1	-40	105	https://gbo-world.ru/katalog/elektronnye-komponenty/blok-upravleniya-brc-sequent-plug-drive-6-tsil	15	75
515	Блок распределения\nнапряжения (PWR)	1	-30	50	https://termoshkaf.com/product/ustrojstvo-netping-2-pwr-220-v12-eth/	15	75
516	Жесткий диск HPE 781516-B21	1	5	65	https://www.hp-pro.net/Netshop/Options-Servers-HP/HDD/SAS-SFF/781516-B21.html?srsltid=AfmBOoq9gDRdG5Gjguc99baY6fxG9WBHbIVIE87VsAqftnPvKCchycHK	16	150
517	Жесткий диск HPE 781516-B21	1	5	65	https://www.hp-pro.net/Netshop/Options-Servers-HP/HDD/SAS-SFF/781516-B21.html?srsltid=AfmBOoq9gDRdG5Gjguc99baY6fxG9WBHbIVIE87VsAqftnPvKCchycHK	16	150
518	Оборудование системы\nуправления сетью\nWebNSV EMS (со\nвстроенным ПО)	\N	\N	\N	нет данных	17	\N
519	Оборудование канала\nуправления	\N	\N	\N	нет данных	17	\N
520	Оборудование дистанционного\nконтроля оптического\nволокна M640SW	\N	\N	\N	нет данных	17	\N
521	Оборудование системы\nуправления сетью WebNSV\nEMS (со встроенным ПО)	\N	\N	\N	нет данных	17	\N
522	Оборудование системы\nуправления\nтерминальными станциями	\N	\N	\N	нет данных	17	\N
523	Оборудование канала\nуправления	\N	\N	\N	нет данных	17	\N
524	Светильник «Победа» ШБ1/К50	12	-60	40	https://galad.ru/catalog/outdoor/street/pobeda/galad-pobeda-led-100-shb1-k50/	18	75
525	Осветитель AXIS T90В20 с ИК-ветодиодами	5	-50	50	https://videoglaz.ru/led-podsvetka/axis/axis-t90d20-ir-led-01210-001	18	75
526	Светильник Победа LED-100-ШБ1/К50	12	-60	40	https://galad.ru/catalog/outdoor/street/pobeda/galad-pobeda-led-100-shb1-k50/	18	75
527	Осветитель AXIS T90B20 с ИК-светодиодами	3	-50	50	https://www.axis.com/dam/public/90/f1/86/%D0%BE%D1%81%D0%B2%D0%B5%D1%82%D0%B8%D1%82%D0%B5%D0%BB%D1%8C-axis-t90b20-%D1%81-%D0%B8%D0%BA-%D1%81%D0%B2%D0%B5%D1%82%D0%BE%D0%B4%D0%B8%D0%BE%D0%B4%D0%B0%D0%BC%D0%B8-ru-RU-205620.pdf	18	75
528	Осветитель TIREX ПИК 22F	1	-50	50	https://satro-paladin.com/catalog/product/187725/?srsltid=AfmBOorcRqJB5udEXXpoIXnv7BKRKTEnlE-nMbrdNdYIyLeDlD9Qk08f	18	75
529	Клавиатура/мышь	2	0	30	https://www.logitech.com/en-gb/shop/p/mx-keys-s-combo.920-011613	19	35
530	Клавиатура/мышь	2	0	30	https://www.logitech.com/en-gb/shop/p/mx-keys-s-combo.920-011613	19	35
531	Клавиатура/мышь	2	0	30	https://www.logitech.com/en-gb/shop/p/mx-keys-s-combo.920-011613	19	35
532	Принтер МФУНР LaserJet Pro M227fdn	1	\N	\N	https://www.dns-shop.ru/product/3a939cf318143330/mfu-hp-laserjet-pro-m227fdn--printerkopirskanerfaks-a4-1200x1200dpi-28ppm-800mhz-256mb-duplex-adf-lan-usb20/?utm_medium=organic&utm_source=google&utm_referrer=https%3A%2F%2Fwww.google.com%2F	20	45
533	Предупредительные знаки	\N	\N	\N	нет данных 	21	\N
534	Кросс ШКОС-Л1U/2-8-FC/ST~8-FC/D/SM~8-FC/\nUPC	\N	\N	\N	нет данных	21	\N
535	Модуль оборудования тип 5 ДНТВ.469479.005	\N	\N	\N	нет данных	21	\N
536	Модуль оборудования тип 4 ДНТВ.469479.004	\N	\N	\N	нет данных	21	\N
537	Модуль оборудования тип 3 ДНТВ.469479.003	\N	\N	\N	нет данных	21	\N
538	Модуль оборудования тип 2 ДНТВ.469479.002	\N	\N	\N	нет данных	21	\N
539	Генераторная установка J88K-IIF (J88K/D500/AUTO/AFFK/SG)	\N	\N	\N	нет данных	21	\N
540	Модуль оборудования тип 1 ДНТВ.469479.001	\N	\N	\N	нет данных	21	\N
541	Кросс оптический стоечный ШКОС-Л-2U/4-48-FC/ST-48-FC/D/SM-48-FC/UPC	\N	\N	\N	https://www.ssd.ru/kross-shkos-l-2u-4-48-fc-st-48-fc-d-sm-48-fc-upc-/	21	\N
542	Модуль оборудования тип 1.2	\N	\N	\N	нет данных	21	\N
543	Модуль оборудования тип 5	\N	\N	\N	нет данных	21	\N
544	Модуль оборудования тип 4	\N	\N	\N	нет данных	21	\N
545	Модуль оборудования тип 3	\N	\N	\N	нет данных	21	\N
546	Модуль оборудования тип 2	\N	\N	\N	нет данных	21	\N
547	Щит освещения ДНТВ.468349.007	\N	\N	\N	укр сайт	21	\N
548	Трансформаторная подстанция КТП 63	30	\N	\N	https://tszi.ru/catalog/kioskovy-ktp/transformatornaya-podstantsiya-ktp-63.html	21	\N
549	Модуль оборудования тип 1.3	\N	\N	\N	нет данных	21	\N
550	Термоусаживаемые гильзы для защиты сварных сростков ОВ SMOUV-112-02-PK 45 мм \n(упаковка 100шт)	1	-40	60	укр сайты	21	\N
551	Соединитель экрана 4460-D	1	-40	60	https://www.ssd.ru/7000031492-skotchlok-4460-d-soedinitel-ekrana-kabelya-do-100-par/	21	\N
552	Шаровой маркер для линии связи \n1401-XREMSII (30 штук упаковка)	1	-20	50	https://www.ssd.ru/7000031654-scotchmark-1401-xr-sharovoy-passivnyy-marker-dlya-liniy-svyazi/	21	\N
553	Лента-плетенка заземления ЛПЗ-12х7,5 м, S=10 мм²	\N	\N	\N	https://www.ssd.ru/lenta-pletenka-zazemleniya-lpz-12kh7-5m-s-10mm2/	21	\N
554	MLDXIL_40GHz [WB402]	\N	\N	\N	нет данных 	21	\N
555	Трансивер оптический\nSFP+ (I64.1/10GBASE-LR)	\N	\N	\N	нет данных	22	300
556	Трансивер оптический\nSFP+ (I64.1/10GBASE-LR)	3	-5	70	https://modultech.ru/goods/modul-sfp-dvuhvolokonnyj-10-gbit-s-tx-1310-nm-do-10-km-smf-lc/?srsltid=AfmBOoqmY-tyKz2xnonhJ-X-k3I47tOIAjdSqyV16bILFWxjla5JBbqz	22	300
558	оптического трансивера Prointech SFP 1310нм 1.25Гбит/с 10км LC (DDM)	3	0	70	https://prointech.ru/catalog/transivery/opticheskie-moduli-sfp/opticheskij-dvuhvolokonnyj-modul-sfp-1310-nm-1-25-gbit-s-10-km-lc/	22	300
559	Береговой колодец БК	\N	\N	\N	нет данных	23	750
560	Полка управления\nнапряжением (SENS)	\N	\N	\N	нет данных	23	750
561	Устройство анкерного крепления брони	\N	\N	\N	нет данных	23	750
562	DIN-рейка металлческая7,535х1000 мм	2	-20	50	https://www.dkc.ru/ru/catalog/314/02140-RET10/	23	750
563	Полка общего\nраспределения сигнала (CXA)	\N	\N	\N	нет данных	23	750
564	Полка тестовой нагрузки\n(TEST LOAD)	\N	\N	\N	нет данных	23	750
565	Полка консольная 19" 2RU	\N	\N	\N	https://www.cmo.ru/catalog/cmo/aksessuary_k_telekommunikatsionnym_shkafam_i_stoykam/polki/polka_perforirovannaya_konsolnaya_2u_glubina_300_mm_tsvet_chernyy_/	23	750
566	Шасси V3	\N	\N	\N	нет данных	23	750
567	Шасси V6	\N	\N	\N	нет данных	23	750
568	Полка общего распределения (COM)	\N	\N	\N	https://linesv.ru/polka-frontalnaya-konsolnaya-19-1u-g280-mm-cvet-seryy	23	750
569	Полка канального расширения (CXA)	\N	\N	\N	нет данных	23	750
570	Кросс оптический стоечный ШКОС-Л-1U/2-8 –FC/ST ~8 –FC/D/SM ~8 –FC/UPC	1	-10	60	https://www.ssd.ru/kross-shkos-l-1u-2-8-fc-st-8-fc-d-sm-8-fc-upc-/	23	750
571	Столбик информационный	5	-60	80	https://www.ssd.ru/stolbik-opoznavatelnyy-dlya-podzemnykh-kabelnykh-liniy-svyazi-sos-l-2500/	23	750
572	Полка управления\nэлектропитанием (COM)	\N	\N	\N	нет данных	23	750
573	Полка общего\nраспределения (COM)	\N	\N	\N	https://www.servers-net.ru/catalog/polki_elektropitaniya_hp_apollo	23	750
574	Полка компенсации\nоптической дисперсии (POM)	\N	\N	\N	нет данных 	23	750
575	Полка транспондерная\n(TPND), 5x100G 2nd Gen TPND	\N	\N	\N	нет данных	23	750
576	Полка транспондерная (TPND), \n5x100G 2nd Gen TPND	\N	\N	\N	нет данных 	23	750
577	Полка тестовой нагрузки\n(TEST LOAD)	\N	\N	\N	нет данных	23	750
578	Полка управления\nэлектропитанием (COM)	\N	\N	\N	https://www.servers-net.ru/catalog/polki_elektropitaniya_hp_apollo	23	750
579	Полка управления\nнапряжением (SENS)	\N	\N	\N	нет данных	23	750
580	Полка компенсации оптической дисперсии (POM)	\N	\N	\N	нет данных 	23	750
581	Стойка\nэлектропитания (ST)	\N	\N	\N	https://www.ssd.ru/stoyka-odnoramnaya-telekommunikatsionnaya-st-24u-1m-k-komplektnaya/	23	750
582	Блок распределения электропитания (PDP), стойка WME	\N	\N	\N	нет данных 	23	750
583	Блок распределения электропитания (PDP), стойка TPND	\N	\N	\N	нет данных 	23	750
584	Шкаф ЩМП02 250х300х155 мм с монтажной платой, IP54	\N	\N	\N	https://www.vseinstrumenti.ru/product/schit-s-montazhnoj-panelyu-schmp-02-ip54-250h300h155-rucelf-00002229-689335/	23	750
585	Стойка телекоммуникационная\n(RM), с блоком PDP	\N	\N	\N	https://ratep-inn.ru/en/products/telecom/floor-racks	23	750
586	Стойка электропитания (RM), с блоком PDP	\N	\N	\N	https://www.tinko.ru/catalog/product/200158/	23	750
587	Шкаф ЩСН-1	\N	\N	\N	https://meselectro.ru/schitovoe-oborudovanie/schsn-schit-sobstvennykh-nuzhd-katalog/novyy-tovar	23	750
588	Стойка электропитания\n(ST)	\N	\N	\N	https://www.ssd.ru/stoyka-odnoramnaya-telekommunikatsionnaya-st-24u-1m-k-komplektnaya/	23	750
589	Блок распределения\nэлектропитания (PDP),\nстойка TPND	\N	\N	\N	нет данных	23	750
590	Труба полиэтиленоваяПЭ 100 SDR-9 Д-125х14,0мм ГОСТ 18599-2001	2	0	40	https://www.prombase.ru/water/truby-pe-100/sdr-9/125	24	1500
591	Труба асбоцементная 100мм	\N	\N	\N	https://vosalyans.ru/catalog/asbestotsementnye-materialy/asbestotsementnye-truby/100-mm/	24	1500
592	Труба электросварная 114х4,5 ГОСТ 10704-91	\N	\N	\N	https://gremir.ru/truby/truby-elektrosvarnye-gost-10704-91/truby-elektrosvarnye-gost-10704-91-ocinkovannye/54729/	24	1500
593	Труба ПЭ100 SDR9 125x14 \nГОСТ 18599-2001	5	20	40	https://www.prombase.ru/water/truby-pe-100/sdr-9/125	24	1500
594	Защитная полиэтиленовая труба HDPE 40x26 ТУ 2248-004-54703206-11	5	-20	60	https://steelborgs.pulscen.ru/goods/299821948-truba_pe_tekhnicheskaya_d_n_40_mm_s_11_mm_tu_2248_004_54703206_11	24	1500
595	Кольцо уплотнительное для двухстенных труб, d=110мм	1	-25	90	https://www.ssd.ru/016110-koltso-uplotnitelnoe-d-dvustennykh-trub-d-110mm-120911/	24	1500
596	Муфта для двухстенных труб, d=110мм	1	-40	60	https://www.dkc.ru/ru/catalog/84/015110/	24	1500
597	Труба электросварная 57х3,5 ГОСТ 10704-91	\N	\N	\N	https://gremir.ru/truby/truby-elektrosvarnye-gost-10704-91/truby-elektrosvarnye-gost-10704-91-stalnye/54734/	24	1500
598	NMS "Фрактал". версия 3.0 Экземпляр ПО	\N	\N	\N	\N	21	\N
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 25, true);


--
-- Name: equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_id_seq', 603, true);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (id);


--
-- Name: ix_categories_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_categories_id ON public.categories USING btree (id);


--
-- Name: ix_equipment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_equipment_id ON public.equipment USING btree (id);


--
-- Name: equipment equipment_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- PostgreSQL database dump complete
--

