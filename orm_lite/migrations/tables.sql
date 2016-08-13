DROP TABLE IF EXISTS bakeries;
DROP TABLE IF EXISTS desserts;

CREATE TABLE bakeries (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  location VARCHAR(255) NOT NULL,
  img_url VARCHAR(255)
);

CREATE TABLE desserts (
  id INTEGER PRIMARY KEY,
  type VARCHAR(255) NOT NULL,
  img_url VARCHAR(255),
  bakery_id INTEGER,

  FOREIGN KEY(bakery_id) REFERENCES bakery(id)
);
