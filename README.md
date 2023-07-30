# Basic-Wordpress-Deployment

<h1>Description</h1>

This repo deploys a basic 2-tier application of a Wordpress site using Docker-Compose. The yaml file will spin up 2 containers, one for the frontend, which is the wordpress site itself. The other is the database, which is a mysql database. Random password is used for the mysql database to ensure security and actually deploy the site and secrets is used to encrypt the wordpress db password. Port 8085 is exposed to access the site. 

<h1> Commands to run </h1>

Command to spin up containers: `docker-compose up -d`

Link of website: `http://localhost:8085/`

Link of website on Nginx server: `http://localhost:8081/`

Command to disable containers: `docker-compose down`
