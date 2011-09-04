server {
        set $www_root "/home/example.com/www/htdocs";
        server_name www.example.com;
        listen   www.example.com:80;
        #listen [::]:80;

        proxy_intercept_errors on;
        error_page 500 504 /50x.html;
        error_page 503 502 /503.html;
        error_page 404 /404.html;
        location = /50x.html {
                root $www_root;
        }

        location = /503.html {
                root $www_root;
        }

        location = /404.html {
                root $www_root;
        }

        location ~ /\.(ht|svn|git) {
		internal;
        }

	if ($http_user_agent ~ translate.google.com) {
		return 444;
	}

	location /internal {
		internal;
	}

        location ~* \.(jpg|jpeg|gif|png|ico|css|doc|exe|txt|js|swf|cur|tar)$ {
                expires         7d;
                root $www_root;
                if (!-f $request_filename) {
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
		expires max;
                rewrite  ^(.*)$  http://www.example.com$1  permanent;
        }
}
