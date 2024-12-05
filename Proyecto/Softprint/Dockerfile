# Usar una imagen base oficial de PHP
FROM php:8.1-apache

# Instalar dependencias necesarias (extensiones de PHP y herramientas para SQL Server)
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libmariadb-dev-compat \
    gnupg2 \
    unixodbc-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql

# Descargar e instalar Microsoft ODBC Driver para SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && ACCEPT_EULA=Y apt-get install -y \
    msodbcsql17 \
    unixodbc-dev

# Instalar extensiones PHP para SQL Server
RUN pecl install sqlsrv pdo_sqlsrv && \
    docker-php-ext-enable sqlsrv pdo_sqlsrv

# Instalar la extensión de MongoDB
RUN pecl install mongodb && docker-php-ext-enable mongodb

# Instalar la extensión de Redis
RUN pecl install redis && docker-php-ext-enable redis

# Instalar las dependencias de Composer (gestor de dependencias PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copiar los archivos de la aplicación en el contenedor
COPY . /var/www/html/

# Asignar permisos a los archivos del proyecto
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Exponer el puerto 80
EXPOSE 80

# Iniciar Apache
CMD ["apache2-foreground"]

