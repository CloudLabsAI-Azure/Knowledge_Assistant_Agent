# Lab 02: Create a Knowledge Assistant agent for HR in Copilot Studio that leverages Azure AI Search

### Estimated Duration: 

## Lab Overview
In this lab, you will explore

## Lab Objective

In this lab, you will perform the following:
- Task 1: Create an Azure AI Search resource
  
## Task 1: Create an Azure AI Search resource

In this task, you will create an Azure AI Search resource from the
Azure portal. This will be used to search the documents using AI
capability.

**Azure AI Search** is a cloud-based service for searching within your
privately curated data. It uses a combination of Microsoft’s AI and
JSON-based indexes to provide fast, relevant search results.

1.  Open a edge browser and login to Azure portal with your credentials.

    - Username - <+++@lab.CloudPortalCredential>(User1).Username+++

    - Password - <+++@lab.CloudPortalCredential>(User1).Password+++

1. From the Home page of the Azure portal, select **Azure AI Foundry.**

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image1.png)

2. In the **AI Foundry page**, select **AI Search (1)** under **Use with AI Foundry** from the left pane and then select **+ Create (2)**.

    ![A screenshot of a search engine AI-generated content may be
incorrect.](./media/image2.png)

3.  Enter the below details and select **Review + create (5)**.

    - Subscription – Select your **assigned subscription (1)**

    - Resource group – Select your **assigned Resource
      group (2)**

    - Service name – **searchervice<inject key="DeploymentID" enableCopy="false"/> (3)**

    - Location – **Keep it as default (4)**

        ![A screenshot of a search service AI-generated content may be
incorrect.](./media/image3.png)

4.  Once the validation passes, select **Create**.

    ![A screenshot of a search engine AI-generated content may be
incorrect.](./media/image4.png)

5.  The deployment takes around few minutes to complete. Select **Go to resource** once the search service is created.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image5.png)

6.  From the **Overview** page, copy the **Url** value and save it in a notepad to be used in a future exercise.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image6.png)

7.  Select **Keys (2)** under **Settings (1)** from the left pane. Copy the **Primary admin key (3)** and save it in a notepad for using it in the upcoming exercises.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image7.png)

8.  Select **Identity (2)** under **Settings (1)** from the left pane.

    ![A screenshot of a search engine AI-generated content may be
incorrect.](./media/image8.png)

9.  Toggle the Status to **On (1)** under **System assigned** and then click on **Save (2)**.

    ![A screenshot of a search engine AI-generated content may be
incorrect.](./media/image9.png)

10. Select **Yes** in the **Enable system assigned managed identity** confirmation dialog.

    ![A screenshot of a computer error AI-generated content may be
incorrect.](./media/image10.png)

## Task 2: Create a Storage account

1.  From the Azure portal Home page, select **Storage accounts**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image11.png)

2.  Select **+ Create** to create a new Storage account.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image12.png)

3.  Enter the below details, accept the default values in the other fields and click on **Review + create (5)**.

    - Subscription – Select your **assigned subscription (1)**

    - Resource group – Select your **assigned Resource group (2)**

    - Storage account name - **storage<inject key="DeploymentID" enableCopy="false"/> (3)**

    - Region – Keep it as default

    - Preferred storage type – Select **Azure Blob Storage or Azure Data Lake Storage Gen 2 (4)**

        ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image13.png)

4.  Once the validation passes, click on **Create**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image14-1.png)

5.  Once the resource creation succeeds, click on **Go to resource**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image15.png)

6.  Select **Containers (1)** under **Data storage**. Select **+ Add Container (2)**, enter the name as **document (3)** and click on **Create (4)** to create the container.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image17.png)

7.  Select the created container **document** to upload the leave policy document into it.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image18.png)

8.  Click on **Upload** and then select **Browse for files**.

    ![A screenshot of a computer screen AI-generated content may be
incorrect.](./media/image19.png)

9.  Select the **LeavePolicy.docx** from **C:\Labfiles\LabFiles** and
    then click on **Upload**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image20.png)

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image21.png)

10. Navigate to the +++**leavepolicystg@lab.LabInstance.Id**+++ Storage account (Select **Storageaccounts** from the **Home
    page** of the Azure portal and select **leavepolicystg@lab.LabInstance.Id**) and select **Access Control (IAM)** from the left pane. Select **Add -> Add role assignment**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image22.png)

11. Search for +++**Storage Blob Data Reader**+++, select it and click on **Next**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image23.png)

12. Click on **+Select members**, search for and select your **user
    name**, <+++@lab.CloudPortalCredential>(User1).Username+++ and then
    click on **Select**. This adds the Storage Blob Data Reader role to
    your user id.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image24.png)

13. Select **Managed identity** and then select **+ Select members**.
    Select **Search service** under **Managed identity** and select
    the **searchleaves** search service that gets listed.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image25.png)

14. Click on **Select** to select the search service.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image26.png)

15. Back in the Add role assignment screen, click on **Review +
    assign**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image27.png)

16. Select **Review + assign** again in the next screen.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image28.png)

17. Proceed to the next step once the roles are added.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image29.png)

In this exercise, we have created a Storage account and added the
document and required Role permissions to it.

## Exercise 3: Create an Azure OpenAI Service and deploy a model

1.  From the Azure portal Home page, search for and select +++Azure
    OpenAI+++.

    ![A screenshot of a computer AI-generated content may be incorrect.](./media/image30.png)

2.  Select **+ Create**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image31.png)

3.  Enter the below details and select **Next**.

    - Subscription – Select your **assigned subscription**

    - Resource group – Select your **assigned Resource
      group** (**ResourceGroup1**)

    - Region – Select @lab.CloudResourceGroup(ResourceGroup1).Location

    - Name –
      +++[**openaiservice@lab.LabInstance.Id**](mailto:openaiservice@lab.LabInstance.Id)+++

    - Pricing tier – Select **Standard S0**

    ![A screenshot of a computer AI-generated content may be incorrect.](./media/image32.png)

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image33.png)

4.  Select **Next** in the next 2 screens select **Create** in
    the **Review + submit** screen.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image34.png)

5.  Click on **Go to resource** once the service is created.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image35.png)

6.  Select **Access control (IAM)** from the left pane, select **Add -\>
    Add role assignment**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image36.png)

7.  Search for +++**Cognitive Services OpenAI User**+++, select the role
    and click on **Next**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image37.png)

8.  Select **+ Select members**, search for your **user
    name**, <+++@lab.CloudPortalCredential>(User1).Username+++, select
    it and click on **Select**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image38.png)

9.  Back in the **Add role assignment** screen, select **Managed
    identity**. Then select **+ Select members**. In the **Select
    managed identities** screen, select **Search
    service** under **Managed identity** and select
    the **seachleaves** service.

    ![A screenshot of a computer screen AI-generated content may be incorrect.](./media/image39.png)

10. Once selected, click on **Select**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image40.png)

11. Select **Review + assign** in the next 2 screens.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image41.png)

12. Wait for a **success** message on the role additions before
    proceeding with the next tasks.

    ![A screenshot of a computer AI-generated content may be incorrect.](./media/image42.png)

13. From the **Overview** page of the Azure OpenAI Service resource,
    select **Go to Azure AI Foundry portal** to open the Azure OpenAI
    Service there and deploy a model.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image43.png)

14. Select **Deployments** from the left pane.

    ![A screenshot of a chat AI-generated content may be
incorrect.](./media/image44.png)

15. Select **+ Deploy model** -\> **Deploy base model**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image45.png)

16. Search for +++**text-embedding**+++,
    select **text-embedding-3-large** and then select **Confirm**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image46.png)

17. Select **Deployment type** as **Standard** and then
    select **Deploy** in the **Deploy text-embedding-3-large** screen..

    ![image](./media/image47.png)

18. The model gets deployed and the screen is loaded with the deployment
    details.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image48.png)

## Exercise 4: Create a vector index

1.  Back in the Azure portal, open the **searchleaves** AI Search
    service resource.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image49.png)

2.  Select **Import and vectorize data**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image50.png)

3.  Select the **Azure Blob Storage** option.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image51.png)

4.  Select the **RAG** option in the **What scenarios are you
    targeting?** screen.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image52.png)

5.  Enter the below details, accept the other values as default and
    click **Next**.

    - Subscription – Select your **assigned subscription**

    - Storage account-
      Select [**leavepolicystg@lab.LabInstance.Id**](mailto:leavepolicystg@lab.LabInstance.Id)

    - Blob-container – Select **document**

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image53.png)

6.  In the Vectorize your text screen, the subscription is
    pre-populated. Enter the below details and click **Next**.

    - Azure OpenAI Service –
      Select [**openaiservice@lab.LabInstance.Id**](mailto:openaiservice@lab.LabInstance.Id)

    - Model deployment – Select **text-embedding-3-large**

    - Authentication type – Select **System assigned identity**

    - Select the checkbox to acknowledge the cost alert of Azure OpenAI.

7.  Select Next in the **Vectorize and enrich your images** screen since
    we are not dealing with images here and select **Next** in
    the **Advanced settings** screen as well.

    ![A screenshot of a computer AI-generated content may be
    incorrect.](./media/image54.png)
    
    ![A screenshot of a computer AI-generated content may be
    incorrect.](./media/image55.png)

8.  Select **Create** in the **Review + create** screen.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image56.png)

9.  Click on **Close** in the success dialog box.

![A screenshot of a computer AI-generated content may be
incorrect.](./media/image57.png)

## Exercise 5: Create a knowledge assistant agent

1.  Open a new broser and login to
    +++[https://copilotstudio.microsoft.com+++](https://copilotstudio.microsoft.com+++/) using
    your login credentials.

2.  Select **Get Started** in the Welcome to Microsoft Copilot Studio.

    ![image](./media/image58.png)

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image59.png)

3.  The agent creation page gets opened. Describe the agent in
    the **Describe** tab. Enter +++You are a Knowledge assistant agent
    for HR who will answer questions related to leaves and leave
    policies to the employees.+++ and select **Send**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image60.png)

4.  The copilot suggests a name to the agent. Click on **Create** to
    create the agent.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image61.png)

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image62.png)

5.  Once the agent is created, in the Test pane, enter +++How many days
    of Maternity leaves can I avail?+++ and click **Send.**

    ![image](./media/image63.png)

6.  It gives a generalized reply as in the screenshot below.

    ![image](./media/image64.png)

## Exercise 6: Add the Azure AI Search as a knowledge source

1.  From the **Overview** page of the agent, select **Add knowledge**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image65.png)

2.  Select Azure AI Search from the list of knowledge sources available.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image66.png)

3.  Click on the **drop down** next to **Not connected** in the next
    screen and select **Create new connection**.

    ![A screenshot of a search engine AI-generated content may be
incorrect.](./media/image67.png)

4.  Enter the **Endpoint url** and the **Admin key** values which we
    saved to a notepad in a previous exercise and then click
    on **Create** to create the connection.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image68.png)

5.  Once the connection is established, the available index is listed
    and already selected. Click on **Add to agent**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image69.png)

6.  The AI Search service is added as a knowledge source to the agent
    and is in **Ready** state now. Ensure that the **Web search** option
    is **disabled** in the Knowledge section.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image70.png)

7.  Now, let us test the agent with the same question we tried before.

8.  In the Test pane, enter +++How many days of Maternity leaves can I
    avail?+++ and click **Send.**

    ![image](./media/image71.png)

9.  You can see that the response from the agent now is from the
    document uploaded in the AI Search service.

    ![image](./media/im6.png)

   
## Summary
In this lab, you have completed the following tasks:
- 

### You have successfully completed the lab. Click on **Next >>** to proceed with the next Lab.

![](./media/9-7-next.png)
