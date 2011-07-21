HOSTNAME = `hostname -f`

all: phpmyadmin default

phpmyadmin:
	sed -i s/server.example.com/$(HOSTNAME)/g sites-available/phpmyadmin
	ln -s ../sites-available/phpmyadmin sites-enabled/

default:
	sed -i s/server.example.com/$(HOSTNAME)/g conf.d/default.conf
	rm sites-enabled/default
