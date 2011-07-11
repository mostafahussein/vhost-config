server {
        set $www_root "/home/example.com/www/htdocs";
        server_name www.example.com;
        listen   www.example.com:80;

        proxy_intercept_errors on;
        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
                root $www_root;
        }

        error_page 404 /404.html;
        location = /404.html {
                root $www_root;
        }

        location ~ /\.(ht|svn|git) {
                return 404;
        }

	if ($http_user_agent ~ translate.google.com) {
		return 444;
	}

        location ~* \.(jpg|jpeg|gif|png|ico|css|doc|exe|txt|js|swf|cur|tar)$ {
                expires         7d;
                root $www_root;
                if (!-f ) {
                        proxy_pass        http://apache;
                }
        }

        location / {
                proxy_pass        http://apache;
        }
}

server {
        server_name .example.com;
        listen      www.example.com:80;
        location / {
                rewrite  ^(.*)$  http://www.example.com$1  permanent;
        }
}
