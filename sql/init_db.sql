--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-05-29 16:56:36

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4945 (class 1262 OID 24576)
-- Name: bodegabd; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE bodegabd WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Chile.1252';


ALTER DATABASE bodegabd OWNER TO postgres;

\connect bodegabd

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 218 (class 1259 OID 24578)
-- Name: bodegas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bodegas (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.bodegas OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24577)
-- Name: bodegas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bodegas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bodegas_id_seq OWNER TO postgres;

--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 217
-- Name: bodegas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bodegas_id_seq OWNED BY public.bodegas.id;


--
-- TOC entry 226 (class 1259 OID 24634)
-- Name: materiales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materiales (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.materiales OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24633)
-- Name: materiales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.materiales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.materiales_id_seq OWNER TO postgres;

--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 225
-- Name: materiales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.materiales_id_seq OWNED BY public.materiales.id;


--
-- TOC entry 222 (class 1259 OID 24597)
-- Name: monedas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.monedas (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.monedas OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24596)
-- Name: monedas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.monedas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.monedas_id_seq OWNER TO postgres;

--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 221
-- Name: monedas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.monedas_id_seq OWNED BY public.monedas.id;


--
-- TOC entry 227 (class 1259 OID 24640)
-- Name: producto_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto_material (
    producto_id integer NOT NULL,
    material_id integer NOT NULL
);


ALTER TABLE public.producto_material OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24604)
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id integer NOT NULL,
    codigo character varying(15) NOT NULL,
    nombre character varying(50) NOT NULL,
    bodega_id integer,
    sucursal_id integer,
    moneda_id integer,
    precio numeric(10,2),
    descripcion text NOT NULL,
    CONSTRAINT productos_codigo_check CHECK (((length((codigo)::text) >= 5) AND (length((codigo)::text) <= 15))),
    CONSTRAINT productos_descripcion_check CHECK (((length(descripcion) >= 10) AND (length(descripcion) <= 1000))),
    CONSTRAINT productos_nombre_check CHECK (((length((nombre)::text) >= 2) AND (length((nombre)::text) <= 50))),
    CONSTRAINT productos_precio_check CHECK ((precio > (0)::numeric))
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24603)
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_id_seq OWNER TO postgres;

--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 223
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- TOC entry 220 (class 1259 OID 24585)
-- Name: sucursales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sucursales (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    bodega_id integer
);


ALTER TABLE public.sucursales OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24584)
-- Name: sucursales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sucursales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sucursales_id_seq OWNER TO postgres;

--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 219
-- Name: sucursales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sucursales_id_seq OWNED BY public.sucursales.id;


--
-- TOC entry 4766 (class 2604 OID 24581)
-- Name: bodegas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodegas ALTER COLUMN id SET DEFAULT nextval('public.bodegas_id_seq'::regclass);


--
-- TOC entry 4770 (class 2604 OID 24637)
-- Name: materiales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materiales ALTER COLUMN id SET DEFAULT nextval('public.materiales_id_seq'::regclass);


--
-- TOC entry 4768 (class 2604 OID 24600)
-- Name: monedas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monedas ALTER COLUMN id SET DEFAULT nextval('public.monedas_id_seq'::regclass);


--
-- TOC entry 4769 (class 2604 OID 24607)
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 24588)
-- Name: sucursales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursales ALTER COLUMN id SET DEFAULT nextval('public.sucursales_id_seq'::regclass);


--
-- TOC entry 4776 (class 2606 OID 24583)
-- Name: bodegas bodegas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodegas
    ADD CONSTRAINT bodegas_pkey PRIMARY KEY (id);


--
-- TOC entry 4786 (class 2606 OID 24639)
-- Name: materiales materiales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materiales
    ADD CONSTRAINT materiales_pkey PRIMARY KEY (id);


--
-- TOC entry 4780 (class 2606 OID 24602)
-- Name: monedas monedas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monedas
    ADD CONSTRAINT monedas_pkey PRIMARY KEY (id);


--
-- TOC entry 4788 (class 2606 OID 24644)
-- Name: producto_material producto_material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_material
    ADD CONSTRAINT producto_material_pkey PRIMARY KEY (producto_id, material_id);


--
-- TOC entry 4782 (class 2606 OID 24617)
-- Name: productos productos_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_codigo_key UNIQUE (codigo);


--
-- TOC entry 4784 (class 2606 OID 24615)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4778 (class 2606 OID 24590)
-- Name: sucursales sucursales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursales
    ADD CONSTRAINT sucursales_pkey PRIMARY KEY (id);


--
-- TOC entry 4793 (class 2606 OID 24650)
-- Name: producto_material producto_material_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_material
    ADD CONSTRAINT producto_material_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.materiales(id) ON DELETE CASCADE;


--
-- TOC entry 4794 (class 2606 OID 24645)
-- Name: producto_material producto_material_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_material
    ADD CONSTRAINT producto_material_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;


--
-- TOC entry 4790 (class 2606 OID 24618)
-- Name: productos productos_bodega_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_bodega_id_fkey FOREIGN KEY (bodega_id) REFERENCES public.bodegas(id);


--
-- TOC entry 4791 (class 2606 OID 24628)
-- Name: productos productos_moneda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_moneda_id_fkey FOREIGN KEY (moneda_id) REFERENCES public.monedas(id);


--
-- TOC entry 4792 (class 2606 OID 24623)
-- Name: productos productos_sucursal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_sucursal_id_fkey FOREIGN KEY (sucursal_id) REFERENCES public.sucursales(id);


--
-- TOC entry 4789 (class 2606 OID 24591)
-- Name: sucursales sucursales_bodega_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursales
    ADD CONSTRAINT sucursales_bodega_id_fkey FOREIGN KEY (bodega_id) REFERENCES public.bodegas(id) ON DELETE CASCADE;


-- Completed on 2025-05-29 16:56:36

--
-- PostgreSQL database dump complete
--

