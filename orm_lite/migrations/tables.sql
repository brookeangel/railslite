DROP TABLE IF EXISTS bakeries CASCADE;
DROP TABLE IF EXISTS desserts CASCADE;
DROP SEQUENCE IF EXISTS bakery_id_seq;
DROP SEQUENCE IF EXISTS dessert_id_seq;

CREATE SEQUENCE bakery_id_seq;
CREATE SEQUENCE dessert_id_seq;


CREATE TABLE bakeries (
  id INTEGER PRIMARY KEY default nextval('bakery_id_seq'),
  name VARCHAR(255) NOT NULL,
  location VARCHAR(255) NOT NULL,
  img_url VARCHAR(511)
);

CREATE TABLE desserts (
  id INTEGER PRIMARY KEY default nextval('dessert_id_seq'),
  type VARCHAR(255) NOT NULL,
  img_url VARCHAR(511),
  bakery_id INTEGER,

  FOREIGN KEY(bakery_id) REFERENCES bakeries(id)
);
