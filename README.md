# TerraformAWS
The terraform script for:
1. Create autoscaling group, tag instances with Role: web
2. Instances should run web server and response with instance name
3. Point DNS record to web-servers
4. Scale UP instances if CPU load > 60% during 15 min
