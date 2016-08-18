# front-end-build-server

Docker image for front end CI build server

## Sample usage in BitBucket Pipeline ##

```
image: originalfunction/front-end-build-server:latest

pipelines:
  default:
    - step:
        script:
          - cd ./source 
          - npm install
          - bower --allow-root install
          - grunt --force build
          - cd ..
          - echo ${SSH_KEY} | sed 's/\\n /\'$'\n/g' | sed 's/\\n//g' > key.pem
          - chmod 400 key.pem
          - rsync -Prvz ./source/dist/ -e 'ssh -o StrictHostKeyChecking=no -i key.pem' ubuntu@${STAGING_SERVER}:/var/www/isitaip
```
bitbucket-pipelines.yml

We save the private key in an environment variable and regenerate it temporarily for ssh.
