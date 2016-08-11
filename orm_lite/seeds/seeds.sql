INSERT INTO
  bakeries (id, name, location)
VALUES
  (1, "Tartine", "The Mission"),
  (2, "Arizmendi", "Inner Sunset"),
  (3, "Cheeseboard", "Berkeley"),
  (4, "The Mill", "The Mission"),
  (5, "Twisted Donuts", "Outer Sunset");

INSERT INTO
  desserts (id, type, img_url, bakery_id)
VALUES
  (1, "Sourdough", "http://d1p2lndmkj2nyk.cloudfront.net/wp-content/uploads/2014/02/IMG_6253.jpg", 1),
  (2, "Croissant", "http://d3rsl50p8hwbdu.cloudfront.net/web_large_3344.jpg", 1),
  (3, "Gougere", "https://fromlipstofingers.files.wordpress.com/2013/01/gougeretartine.jpg?w=600&h=450", 1),
  (4, "Pizza", "http://i11.photobucket.com/albums/a154/foodhoe/2008/jun08/ap_pizza1.jpg", 2),
  (5, "Chocolate Snail", "http://www.arizmendi-bakery.org/wp-content/uploads/2011/12/chocolate-things1.jpg", 2),
  (6, "Cheese Rolls", "http://pictures.mightytravels.com/arizmendi_bakery_sf/IMG_7281-big.JPG", 2),
  (7, "Tomato Pizza", "http://www.berkeleyside.com/wp-content/uploads/2011/06/Pizza-from-Cheese-Board.jpg", 3),
  (8, "Chili Lime Pizza", "http://s3-media2.fl.yelpcdn.com/bphoto/5tAtY2oluvF4lw8bInlWAA/o.jpg", 3),
  (9, "Arugula Feta Pizza", "http://slice.seriouseats.com/images/20110218-tt-cbc-01.jpg", 3),
  (10, "Sesame Loaf", "http://farm3.staticflickr.com/2845/11354827123_be1539f398.jpg", 4),
  (11, "Four Dollar Toast", "https://slideshow.starchefs.com/p.php?a=ZnRNa3x5bmpbaGppdnZeaXBvd2NWZnldNTY4Ny8qMSUjPGtjbScnNzgyLis0MSc0PiMrOSczMis3JTQyPjIlPiItIyY%2BPzE6&m=1460058649", 4),
  (12, "Rustic Sourdough", "http://static1.squarespace.com/static/55c54161e4b05dcc99eb0115/t/564e518ee4b05ec02d494bd9/1447973684902/", 4),
  (13, "Seeded Loaf", "http://davidlebovitz.com.s3.amazonaws.com/wp-content/uploads/2014/05/13958114767_78fb5a2632_b.jpg", 4),
  (14, "Oreo Donut", "https://rebeccawhitesfrealtor.files.wordpress.com/2015/10/the-best-donuts-in-san-francisco.jpeg", 5),
  (15, "Butterscotch Donut", "https://media.timeout.com/images/102784340/617/347/image.jpg", 5),
  (16, "Bacon Maple Donut", "http://s3-media4.fl.yelpcdn.com/bphoto/bsfJQcy2bl0dgdbHica6Og/o.jpg", 5);
