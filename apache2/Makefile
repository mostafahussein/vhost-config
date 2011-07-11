HOSTNAME = `hostname -f`

all: modules phpmyadmin

modules:
	a2enmod headers rewrite rpaf
	a2dismod cgi deflate negotiation status

phpmyadmin:
	sed -i s/server.example.com/$(HOSTNAME)/g sites-available/phpmyadmin
	ln -s ../sites-available/phpmyadmin sites-enabled/
