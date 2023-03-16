# learnjs-database
Спроектирвоать базу для хранения фильмов. База должна давать возможность хранить информацию как на странице: https://www.kinopoisk.ru/film/435/<br>
База данных имеет следующую структуру:

**Таблица фильмов (film)**
* id - pk: bigint с автоинкрементом
* title - название фильма: text
* prod_year - год релиза фильма: numeric
* tagline - слоган фильма: text
* director - режиссёр фильма: fkey со ссылкой на поле id таблицы **person**, bigint
* scenario - сценарист: fkey со ссылкой на поле id таблицы **person**, bigint
* producer - продюсер: fkey со ссылкой на поле id таблицы **person**, bigint
* cam_operator - оператор: fkey со ссылкой на поле id таблицы **person**, bigint
* composer - композитор: fkey со ссылкой на поле id таблицы **person**, bigint
* artist - художник: fkey со ссылкой на поле id таблицы **person**, bigint
* editor - монтажер: fkey со ссылкой на поле id таблицы **person**, bigint
* budget - бюджет (USD): numeric
* marketing - маркетинг (USD): numeric
* dvd_release - дата релиза dvd издания и издатель: text
* bluray_release - дата релиза blue-ray издания и издатель: text
* age_limit - возраст: text
* mpaa_rating - рейтинг MPAA: text
* duration_min - продолжительность фильма в минутах: numeric
* film_description - описание фильма: text

**Таблица  стран (country)**
* id - pk: bigint с автоинкрементом
* country_name - название страны: text

**Таблица  жанров (genre)**
* id - pk: bigint с автоинкрементом
* genre_name - название жанра: text

**Таблица людей, принимающих участие в создании и прокате фильмов (person)**
* id - pk: bigint с автоинкрементом
* person_name - имя человека: text

**Таблица актеров, снявшихся в фильме, или "В главных ролях" (film_actor)**
* film_id - фильм, в котором снялся тот или иной актёр: fkey со ссылкой на поле id таблицы **film**, bigint
* person_id - актёр, который снялся в том или ином фильме: fkey со ссылкой на поле id таблицы **person**, bigint

*поля film_id и person_id образуют pk таблицы **film_actor***

**Таблица со статистикой прокатов фильмов по странам (film_country_rental)**
* film_id - фильм, у которого состоялся прокат в той или иной стране: fkey со ссылкой на поле id таблицы **film**, bigint
* country_id - страна, в которой состоялся прокат того или иного фильма: fkey со ссылкой на поле id таблицы **country**, bigint
* viewers - размер зрительской аудитории того или иного фильма по странам: numeric
* fees - сборы фильмов по странам (USD): numeric
* premiere_date - дата выхода фильма в прокат в той или иной стране и прокатчик: text

*поля film_id и country_id образуют pk таблицы **film_country_rental***

**Таблица со странами, которые принимали участие в создании того или иного фильма (film_country_creation)**
* film_id - фильм: fkey со ссылкой на поле id таблицы **film**, bigint
* country_id - страна: fkey со ссылкой на поле id таблицы **country**, bigint

*поля film_id и country_id образуют pk таблицы **film_country_creation***

**Таблица с актёрами дубляжа фильмов, или "Роли дублировали" (film_dubbing)**
* film_id - фильм, который дублировался: fkey со ссылкой на поле id таблицы **film**, bigint
* person_id - актёр дубляжа: fkey со ссылкой на поле id таблицы **person**, bigint

*поля person_id и film_id образуют pk таблицы **film_dubbing***

**Таблица с жанрами того или иного фильма (film_genre)**
* film_id - фильм: fkey со ссылкой на поле id таблицы **film**, bigint
* genre_id - жанр фильма: fkey со ссылкой на поле id таблицы **genre**, bigint

*поля film_id и genre_id образуют pk таблицы **film_genre***

* **Поля pk имеют свойство NOT NULL.**
* **Это же касается и внешних ключей, за исключением таблицы film.**
* **Все fkey имеют свойства ON UPDATE CASCADE и ON DELETE CASCADE (в таблице film ON DELETE SET NULL).**
* **Также свойство NOT NULL имеют неключевые поля: title, prod_year, country_name, genre_name, person_name.**
* **Свойство UNIQUE имеют поля genre_name и country_name**
