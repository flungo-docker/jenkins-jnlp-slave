# Jenkins JNLP Slave

Docker image for a configurable Jenkins JNLP Slave. When the slave is started it will contact the Jenkins server, download the slave client and connect with the credentials provided via environment variables.

## Configure the Slave

The slave needs to be configured on your Jenkins instance in order to be able to use this image. To do this, in Jenkins:

1. Navigate to **Manage Jenkins** > **Manage Nodes** > **New Node**.
2. Give your node a unique **Node name**, choose the **Permanent Agent** type and proceed by pressing **OK**.
3. Set the **Remote root directory** to `/var/jenkins_home`.
4. Keep the **Launch method** as `Launch agent via Java Web Start`.
5. Configure other fields to your needs and **Save** the node.

## Run the Slave

The slave can be run with the following command:

```
docker run --env JENKINS_URL={{JENKINS_URL}}--env JENKINS_SLAVE_NAME={{JENKINS_SLAVE_NAME}} --env JENKINS_SLAVE_SECRET={{JENKINS_SLAVE_SECRET}} flungo/jenkins-jnlp-slave
```

To get the `{{JENKINS_SLAVE_SECRET}}` (and `{{JENKINS_URL}}`/`{{JENKINS_SLAVE_NAME}}`):

1. On Jenkins navigate to **Manage Jenkins** > **Manage Nodes** > **New Node**.
2. Choose the node you want to run a slave for (see [Configure the Slave](#configure-the-slave) if you have not created a node yet).
3. You will find on this page an example command for running the agent which is of the following form: `java -jar slave.jar -jnlpUrl {{JENKINS_URL}}/computer/{{JENKINS_SLAVE_NAME}}/slave-agent.jnlp -secret {{JENKINS_SLAVE_SECRET}}`. You can use this to extract the variables required for running the docker image. If you do not have `-secret {{JENKINS_SLAVE_SECRET}}` in the example command, then you can ommit the `--env JENKINS_SLAVE_SECRET={{JENKINS_SLAVE_SECRET}}` flag.
