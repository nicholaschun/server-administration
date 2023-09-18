# Backup Postgres Database To S3
This bash script can be used for backing up postgres database to an s3 bucket.

## Use Case
1. Can be used to backup database hosted on an ec2 instance to  s3 bucket.
2. Can be used together with a cron job to regularly backup database to s3.

## How to use
1. ssh into the instance that hosts your postgres database
2. upload backup-postgres-database-to-s3.sh or create a .sh file and copy the content into it.
3. Give execution permission to the bash script by typing `chmod +x backup-postgres-database-to-s3.sh `
4. Type `sh backup-postgres-database-to-s3.sh` to run the script

## Give Permissions to ec2 instance to access s3 bucket

1. Create an IAM policy with the following policies 
```{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:DeleteObject"
            ],
            "Resource": [
                "<arn of S3 bucket>",
                "<arn of S3 bucket>/*"
            ]
        }
    ]
}
```
2. Replace `<arn of S3 bucket>` with the arn of your s3 bucket
3. Create a role using ec2 as a use case
4. Attach the policy above to the role you just created.
5. Modify the IAM role for the ec2 instance to use the role you just created.

## Automate the execution of the backup script
1. Open crontab  by typing `crontab -e`
2. In the resulting window type `0 0 * * 1 ~/backup-postgres-database-to-s3.sh &>> ~/backup-postgres-database-to-s3.sh
` (runs every at 12:00 AM, only on Monday ) use https://crontab.cronhub.io/ to generate a cron expression to use 