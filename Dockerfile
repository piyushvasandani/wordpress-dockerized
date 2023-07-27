FROM wordpress:latest
ENV MY_DB_HOST=db
ENV MY_DB_USER=my_custom_db_user
ENV MY_DB_PASSWORD=My-custom-db-password
ENV MY_DB_NAME=my_custom_db_name
COPY ./wordpress/ /var/www/html/wordpress
COPY wordpress.conf /etc/apache2/sites-available/
RUN cd /etc/apache2/sites-available/
RUN a2dissite 000-default.conf
RUN a2ensite wordpress.conf
RUN service apache2 restart
