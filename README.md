# Setup a Nagios server docker container which would connect to a Windows machine and perform Disk Velocity check and Free Disk Space check.
## Prerequistes
- The windows machine you want to connect should have NSClient++ installed inside it and also should be properly configured in order to accept incoming requests from Nagios Server (You can get a detailed description [here](https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/monitoring-windows.html))
- You should have docker and docker-compose installed on the machine you will be using to spawn the nagios docker container. 

## Configuration

-	Open docker-compose.yml 
-	Update the environment variables with values as applicable. Once done save the file.
- Next open docker terminal and navigate to the path where you have cloned this repository.
- Fire the following command:
    - `docker-compose up -d --build` 
- Next go to any browser and type `http://<dockerserverurl>/nagios`
- Enter the following credentials
    - Username - `nagiosadmin`
    - Password - `nagios`
- Thats it. You are all set. Now if you click on the `Services` you will see the windows machine with alias `winserver`   
   