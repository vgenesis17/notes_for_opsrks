

Next

2 / 8
What are jenkins plugins?


A. Plugins are used to configure the security settings in Jenkins.


B. Plugins are the primary means of enhancing the functionality of a Jenkins environment to suit organization or user specific needs.


C. Plugins are used to create jobs in Jenkins.


D. Plugins are the tools to setup CI/CD pipelines in Jenkins.

answer: B






Create a pipeline job named hello-world, it should just echo the Hello World string.

You can name the stage as per your choice.






Login into the Jenkins server and follow the below given steps:


1. On the left side click on New Item.

2. Write the job name hello-world.

3. Select Pipeline job.

4. Under Pipeline section keep selected Pipeline script as Definition and add below given code in the Script

```jenkinsfile
pipeline {
    agent any
    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
```