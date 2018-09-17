### Configuration based Http Network Managment<br><br>
* Configuration based network managment using url session 
  * Every request is built from 
    * 1. Data object(which has data properties) and 
    * 2. An enum (which provides network properties like http method, url, content type time intervel etc)   
  * Supports SSL Pinning

#### Mock Server
* To test the services, start server using node app.js using the code in MockServer folder
