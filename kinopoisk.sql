-- Database: kinopoisk

-- DROP DATABASE IF EXISTS kinopoisk;

CREATE DATABASE kinopoisk
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE kinopoisk
    IS 'База для хранения фильмов.
База должна давать возможность хранить информацию как на странице:
https://www.kinopoisk.ru/film/435/
- Для хранения художников, композиторов, монтажеров и пр. используем одну таблицу person.
- Упрощаем, и, чтобы не плодить кучу таблиц, только в главных ролях и роли дублировали будут иметь (film-person) связь многие ко многим.
- Для остальных ставим связь один ко многим (поэтому в графе сценарий у нас для фильма будет всего один сценарист [например, только Фрэнк Дарабонт], аналогично и по другим полям person).
- Жанры также хранятся в отдельной таблице и связываются далее с фильмами.
- Зрители по странам тоже в отдельной таблице (флажки можно не хранить).';

-- Table: public.country

-- DROP TABLE IF EXISTS public.country;

CREATE TABLE IF NOT EXISTS public.country
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    country_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT country_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.country
    OWNER to postgres;

COMMENT ON TABLE public.country
    IS 'страны, в которых были прокаты фильмов';
	
-- Table: public.film

-- DROP TABLE IF EXISTS public.film;

CREATE TABLE IF NOT EXISTS public.film
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    title text COLLATE pg_catalog."default" NOT NULL,
    prod_year numeric NOT NULL,
    tagline text COLLATE pg_catalog."default",
    director bigint,
    scenario bigint,
    producer bigint,
    cam_operator bigint,
    composer bigint,
    artist bigint,
    editor bigint,
    budget numeric,
    marketing numeric,
    dvd_release text COLLATE pg_catalog."default",
    bluray_release text COLLATE pg_catalog."default",
    age_limit text COLLATE pg_catalog."default",
    mpaa_rating text COLLATE pg_catalog."default",
    duration_min numeric,
    film_description text COLLATE pg_catalog."default",
    CONSTRAINT film_pkey PRIMARY KEY (id),
    CONSTRAINT artist_fkey FOREIGN KEY (artist)
        REFERENCES public.person (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT cam_operator_fkey FOREIGN KEY (cam_operator)
        REFERENCES public.person (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT composer_fkey FOREIGN KEY (composer)
        REFERENCES public.person (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT director_fkey FOREIGN KEY (director)
        REFERENCES public.person (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT editor_fkey FOREIGN KEY (editor)
        REFERENCES public.person (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT producer_fkey FOREIGN KEY (producer)
        REFERENCES public.person (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT scenario_fkey FOREIGN KEY (scenario)
        REFERENCES public.person (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.film
    OWNER to postgres;

COMMENT ON TABLE public.film
    IS 'информация о фильме';
	
-- Table: public.film_actor

-- DROP TABLE IF EXISTS public.film_actor;

CREATE TABLE IF NOT EXISTS public.film_actor
(
    film_id bigint NOT NULL,
    person_id bigint NOT NULL,
    CONSTRAINT film_actor_pkey PRIMARY KEY (film_id, person_id),
    CONSTRAINT film_fkey FOREIGN KEY (film_id)
        REFERENCES public.film (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT person_fkey FOREIGN KEY (person_id)
        REFERENCES public.person (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.film_actor
    OWNER to postgres;

COMMENT ON TABLE public.film_actor
    IS 'в главных ролях';
	
-- Table: public.film_country_rental

-- DROP TABLE IF EXISTS public.film_country_rental;

CREATE TABLE IF NOT EXISTS public.film_country_rental
(
    film_id bigint NOT NULL,
    country_id bigint NOT NULL,
    viewers numeric,
    fees numeric,
    premiere_date text COLLATE pg_catalog."default",
    CONSTRAINT film_country_rental_pkey PRIMARY KEY (film_id, country_id),
    CONSTRAINT country_id FOREIGN KEY (country_id)
        REFERENCES public.country (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT film_fkey FOREIGN KEY (film_id)
        REFERENCES public.film (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.film_country_rental
    OWNER to postgres;

COMMENT ON TABLE public.film_country_rental
    IS 'статистика проката фильмов по странам';
	
-- Table: public.film_dubbing

-- DROP TABLE IF EXISTS public.film_dubbing;

CREATE TABLE IF NOT EXISTS public.film_dubbing
(
    film_id bigint NOT NULL,
    person_id bigint NOT NULL,
    CONSTRAINT film_dubbing_pkey PRIMARY KEY (film_id, person_id),
    CONSTRAINT film_fkey FOREIGN KEY (film_id)
        REFERENCES public.film (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT person_id FOREIGN KEY (person_id)
        REFERENCES public.person (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.film_dubbing
    OWNER to postgres;

COMMENT ON TABLE public.film_dubbing
    IS 'роли дублировали';
	
-- Table: public.film_genre

-- DROP TABLE IF EXISTS public.film_genre;

CREATE TABLE IF NOT EXISTS public.film_genre
(
    film_id bigint NOT NULL,
    genre_id bigint NOT NULL,
    CONSTRAINT film_genre_pkey PRIMARY KEY (film_id, genre_id),
    CONSTRAINT film_fkey FOREIGN KEY (film_id)
        REFERENCES public.film (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT genre_fkey FOREIGN KEY (genre_id)
        REFERENCES public.genre (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.film_genre
    OWNER to postgres;

COMMENT ON TABLE public.film_genre
    IS 'связь фильма и его жанров';
	
-- Table: public.genre

-- DROP TABLE IF EXISTS public.genre;

CREATE TABLE IF NOT EXISTS public.genre
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    genre_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT genre_pkey PRIMARY KEY (id),
    CONSTRAINT genre_name_unique UNIQUE (genre_name)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.genre
    OWNER to postgres;

COMMENT ON TABLE public.genre
    IS 'жанры фильмов';
	
-- Table: public.person

-- DROP TABLE IF EXISTS public.person;

CREATE TABLE IF NOT EXISTS public.person
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    person_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT person_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.person
    OWNER to postgres;

COMMENT ON TABLE public.person
    IS 'люди, принимающие участие в создании фильмов';
