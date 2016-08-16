INSERT INTO bakeries
  (name, location, img_url)
VALUES
  ('Tartine', 'The Mission', 'https://static01.nyt.com/images/2014/04/23/dining/23TARTINE2/23TARTINE2-superJumbo.jpg'),
  ('Arizmendi', 'Inner Sunset', 'http://slice.seriouseats.com/images/2012/02/20120227-arizmendi-pasilla-pepper-queso-fresco-pizza-cc.jpg.jpg'),
  ('Cheeseboard', 'Berkeley', 'http://www.berkeleyside.com/wp-content/uploads/2011/06/side.06.03.11.jpg'),
  ('The Mill', 'The Mission', 'http://ericherrmann.com/news/wp-content/uploads/2013/02/ericherrmann_themillsf_23.jpg'),
  ('Twisted Donuts', 'Outer Sunset', 'https://cdn0.vox-cdn.com/thumbor/dGv_5B6i6H06AsJvqea8wZTA6Gg=/0x0:599x337/1310x737/cdn0.vox-cdn.com/uploads/chorus_image/image/39688076/twisted_donuts.0.0.jpg');

INSERT INTO desserts
  (type, img_url, bakery_id)
VALUES
  ('Sourdough', 'http://d1p2lndmkj2nyk.cloudfront.net/wp-content/uploads/2014/02/IMG_6253.jpg', 1),
  ('Croissant', 'http://d3rsl50p8hwbdu.cloudfront.net/web_large_3344.jpg', 1),
  ('Gougere', 'https://fromlipstofingers.files.wordpress.com/2013/01/gougeretartine.jpg?w=600&h=450', 1),
  ('Pizza', 'http://i11.photobucket.com/albums/a154/foodhoe/2008/jun08/ap_pizza1.jpg', 2),
  ('Chocolate Snail', 'http://www.arizmendi-bakery.org/wp-content/uploads/2011/12/chocolate-things1.jpg', 2),
  ('Cheese Rolls', 'http://pictures.mightytravels.com/arizmendi_bakery_sf/IMG_7281-big.JPG', 2),
  ('Tomato Pizza', 'http://www.berkeleyside.com/wp-content/uploads/2011/06/Pizza-from-Cheese-Board.jpg', 3),
  ('Chili Lime Pizza', 'http://s3-media2.fl.yelpcdn.com/bphoto/5tAtY2oluvF4lw8bInlWAA/o.jpg', 3),
  ('Arugula Feta Pizza', 'http://slice.seriouseats.com/images/20110218-tt-cbc-01.jpg', 3),
  ('Sesame Loaf', 'http://farm3.staticflickr.com/2845/11354827123_be1539f398.jpg', 4),
  ('Four Dollar Toast', 'https://slideshow.starchefs.com/p.php?a=ZnRNa3x5bmpbaGppdnZeaXBvd2NWZnldNTY4Ny8qMSUjPGtjbScnNzgyLis0MSc0PiMrOSczMis3JTQyPjIlPiItIyY%2BPzE6&m=1460058649', 4),
  ('Rustic Sourdough', 'http://static1.squarespace.com/static/55c54161e4b05dcc99eb0115/t/564e518ee4b05ec02d494bd9/1447973684902/', 4),
  ('Seeded Loaf', 'http://davidlebovitz.com.s3.amazonaws.com/wp-content/uploads/2014/05/13958114767_78fb5a2632_b.jpg', 4),
  ('Oreo Donut', 'https://rebeccawhitesfrealtor.files.wordpress.com/2015/10/the-best-donuts-in-san-francisco.jpeg', 5),
  ('Butterscotch Donut', 'https://media.timeout.com/images/102784340/617/347/image.jpg', 5),
  ('Bacon Maple Donut', 'http://s3-media4.fl.yelpcdn.com/bphoto/bsfJQcy2bl0dgdbHica6Og/o.jpg', 5);
