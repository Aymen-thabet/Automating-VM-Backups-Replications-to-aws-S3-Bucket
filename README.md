First of all, I created an IAM Role and granted it "s3 full acces" permission and an IAM role also with "s3 full acces + SSMfull acces" and I attached the role to the user , then I modified the IAM role of the running EC2 instance to the created role.


second , I connected to the EC2 instance with the CLI with the acces key and secret acces key of that user then created an S3 bucket


finally , I modify the crontab file to run the script every 2 minutes and then run the script.


![Backups Uploaded](https://github.com/user-attachments/assets/9fcdea62-468b-4a0a-88b3-f4485857e9bf)
