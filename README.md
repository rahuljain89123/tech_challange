# tech_challange
tech challenge :--

To deploy this app we need follow below sequence .
1. we need to create vpc with the help of servian vpc module .It will create entire networking paramaters like subnet ,rt , igw ,sg etc 

2. As part of downstream service we have spin rds db with the help of servian db tf repo .It will create postgress rds with multiAZ

3. I use ecs as cluster (ec2 host) to deply this containerized application in highly available and scalable mannner . To spin up entire cluster we have to use infra servian directory . It will create ecs cluster , roles and cloudwatch log stream to check app logs .

4. We have to push app images with all db detail we have to set  in conf.toml to ecr repo (go app repo , I created it manually ). We can call that image on ecs cluster .Once container is up we can access with the help of ALB .


