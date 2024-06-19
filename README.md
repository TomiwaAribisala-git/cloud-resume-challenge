### Cloud Resume Challenge
This repo is a solution of the [Cloud Resume Challenge](https://github.com/cloudresumechallenge/projects/blob/main/projects/aws/cloud-resume-challenge.md), the challenge covers the implementation of a static website served via an S3 Bucket and CloudFront Distribution and reads count views from a DynamoDB table.

### Certification
- [AWS Cloud Practitioner Certification](https://www.credly.com/earner/earned/badge/575e824f-59e2-40b4-9920-da424ab193d2).

### HTML 
- Resume is written in [HTML](index.html).

### CSS
- HTML resume is styled with [CSS](index.css).

### Javascript
- Resume webpage includes a [javascript visitor counter](index.js) that displays how many people have accessed the site.

### Infrastructure As Code
- IAC implemented as [Terraform Modules](./terraform/) consisting of AWS S3 Bucket, CloudFront Distribution, Lambda Function with a CORS-enabled Function URL, and DynamoDB database.

### Continuous Integration/Continuous Deployment
- CI/CD pipeline implemented via Github Actions for deploying infrastructure as code to AWS.