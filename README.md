# Itinerary Job - Consumer

## Description
Itinerary Job is an publisher - subscriber architecture
A Publisher generate PNR list and separate into many pieces, and send them to AWS SQS 
As a worker, consumer listen queue, if there is a message (PNR list), consumer will drain this message, and make a restful web service call to retrieve Itinerary from avantik, then store into DB.

## HOW to USE
### Docker way
    > docker build -t itinerary-customer .
    > docker run itinerary-customer

### Console way
    > npm install & npm start

## Configuration
### File
we will save an temp csv file, please make sure the folder must exists before you run this application

### AWS
Use your AWS credential and specify the Queue URL

### DB
Config DB Connection String

### Environment
concurrentServiceCallLimit: protect avantik from crash, DO NOT set this number larger than 30, please

itineraryApiUrl: Web service URL of restful API

