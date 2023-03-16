# learnjs-database
Спроектирвоать базу для хранения фильмов. База должна давать возможность хранить информацию как на странице: https://www.kinopoisk.ru/film/435/<br>
База данных имеет следующую структуру:

**Таблица фильмов (film)**
* id - pk, bigint с автоинкрементом
* title - название фильма, text
* prod_year - год релиза фильма, numeric
* tagline - слоган фильма, text
* director - режиссёр фильма, fkey со ссылкой на таблицу person, bigint
* scenario - сценарист, fkey со ссылкой на таблицу person, bigint
* producer - продюсер, fkey со ссылкой на таблицу person, bigint
* cam_operator - оператор, fkey со ссылкой на таблицу person, bigint
* composer - композитор, fkey со ссылкой на таблицу person, bigint
* artist - художник, fkey со ссылкой на таблицу person, bigint
* editor - монтажер, fkey со ссылкой на таблицу person, bigint
* budget - бюджет USD, numeric
* marketing - маркетинг, numeric
* dvd_release - дата релиза dvd издания и издатель, text
* bluray_release - дата релиза blue-ray издания и издатель, text
* age_limit - возраст, text
* mpaa_rating - рейтинг MPAA, text
* duration_min - продолжительность фильма в минутах, numeric
* film_description - описание фильма, text

**Таблица  стран (country)**
* id - pk, bigint с автоинкрементом
* country_name - название страны, text

**Таблица  жанров (genre)**
* id - pk, bigint с автоинкрементом
* genre_name - название жанра, text

**Таблица людей, принимающих участие в создании и проката фильмов (person)**
* id - pk, bigint с автоинкрементом
* person_name - имя человека, text

**Таблица актеров, снявшихся в фильме, или "В главных ролях" (film_actor)**
* film_id
* person_id
