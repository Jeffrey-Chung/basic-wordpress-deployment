# basic-wordpress-deployment

<h1>Description</h1>

This repo deploys a basic 2-tier application of a Wordpress site using Docker-Compose. The yaml file will spin up 2 containers, one for the frontend, which is the wordpress site itself. The other is the database, which is a mysql database. Random root password is used for the mysql database to ensure security and actually deploy the site and secrets is used to encrypt the wordpress db password. Port 8085 is exposed to access the site. 

<h1> Commands to run </h1>

Command to spin up containers: `docker-compose up -d`

Link of website: `http://localhost:8085/`

Link of website on Nginx server: `http://localhost:8081/`

Command to disable containers: `docker-compose down`

<h1>Health Check</h1>

Health Check is added to the wordpress image to make sure that the container is in a healthy state.

Run the `docker-compose ps -a` command to check for each container's health.

<h1>Future Considerations</h1>

- Automate the deployment using GitHub Actions
- Add UI Testing with Selenium Grid
