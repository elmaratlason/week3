# Week 3

## [Jenkins](http://ec2-35-177-8-43.eu-west-2.compute.amazonaws.com:8080/configure)

## [TicTacToe](http://ec2-34-242-213-4.eu-west-1.compute.amazonaws.com/)

## [DataDog](https://p.datadoghq.com/sb/5cb1a354c-cbf8737fd7)


### FAILURE!
Somehow datadog crashed my jenkins instance as I was unable to access shell after it installed and started sending data so I had to install a new one.


## List of things done  

Completed the migrations needed for the application to work
- Database migrated
- Rename of files

On Git push Jenkins pulls my code and the Tic Tac Toe application is deployed through a build pipeline, but only if all my tests are successful
- This works!

Filled out the Assignments: for the API and Load tests
[Assignement](apitest/assignment.md)

The API and Load test run in my build pipeline on Jenkins and everything is cleaned up afterwards
- I run the tests in the same stage, if either fail the pipeline stops

My [test reports](http://ec2-35-177-8-43.eu-west-2.compute.amazonaws.com:8080/job/hgop/27/testReport/) are published in Jenkins
- one report for each build
My Tic Tac Toe game works, two people can play a game till the end and be notified who won.
- Two blind people can play this game as I haven't finished implementing showing where you place your man.
- chat is working as expected.

My TicCell is NOT tested
- not implemented :-(

I've set up Datadog
- When I added the Jenkins integration, Jenkins died
- agents for docker, ubuntu, jenkins installed
- [Management Console](https://app.datadoghq.com/)
- for both ec2 instances, I added neccessary DataDog steps
 - ec2-bootstrap-jenkins.sh
 - ./provisioning/ec2-docker-instance-init.sh
