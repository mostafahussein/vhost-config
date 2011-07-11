HOSTNAME = `hostname -f`

all: phpmyadmin

phpmyadmin:
	sed -i s/server.example.com/$(HOSTNAME)/g sites-available/phpmyadmin
	ln -s ../sites-available/phpmyadmin sites-enabled/
