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

8.  Click on **Upload (1)** and then select **Browse for files (2)**.

    ![A screenshot of a computer screen AI-generated content may be
incorrect.](./media/image19.png)

9.  Select the **LeavePolicy.docx** from **C:\Users\azureuser** and then click on **Upload**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image20.png)

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image21.png)

10. Navigate to the storage account and select **Access Control (IAM) (1)** from the left pane. Select **+ Add (2) -> Add role assignment (3)**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image22.png)

11. Search for **Storage Blob Data Reader (1)**, select it **(2)** and click on **Next (3)**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image23.png)

12. Make sure **User, group or service principal (1)** is selected, click on **+ Select members (2)**, **search (3)** for and select **<inject key="AzureAdUserEmail"></inject> (4)**, and then click on **Select (5)**. This adds the Storage Blob Data Reader role to your user id.
    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image24-1.png)

13. Select **Managed identity (1)** and then select **+ Select members (2)**. Select **Search service (3)** under **Managed identity** and select the **searchservice<inject key="DeploymentID" enableCopy="false"/> (4)** search service that gets listed. Click on **Select (5)**

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image25.png)

14. Back in the Add role assignment screen, click on **Review + assign**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image27.png)

15. Select **Review + assign** again in the next screen.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image28.png)

16. Proceed to the next step once the roles are added.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image29.png)

In this exercise, we have created a Storage account and added the
document and required Role permissions to it.

## Task 3: Create an Azure OpenAI Service and deploy a model

1. From the Azure portal Home page, search for and select **Azure OpenAI**.

    ![A screenshot of a computer AI-generated content may be incorrect.](./media/image30.png)

2. On the **AI Foundry | Azure OpenAI** select **+ Create (1)** and from the drop-down select **Azure OpenAI (2)**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image31.png)

3.  Enter the below details and select **Next (6)**.

    - Subscription – Select your **assigned subscription (1)**

    - Resource group – Select your **assigned Resource group (2)**

    - Region – **Keep it as default (3)**

    - Name – **openai<inject key="DeploymentID" enableCopy="false"/> (4)**

    - Pricing tier – Select **Standard S0 (5)**

        ![A screenshot of a computer AI-generated content may be incorrect.](./media/image32.png)

4. Select **Next** in the next 2 screens. select **Create** in the **Review + submit** screen.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image34.png)

5.  Click on **Go to resource** once the service is created.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image35.png)

6. Select **Access control (IAM) (1)** from the left pane, select **+ Add (2) -\> Add role assignment (3)**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image36.png)

7. Search for **Cognitive Services OpenAI User (1)**, **select (2)** the role and click on **Next (3)**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image37.png)

8. Make sure **User, group or service principal (1)** is selected, click on **+ Select members (2)**, **search (3)** for and select **<inject key="AzureAdUserEmail"></inject> (4)**, and then click on **Select (5)**. This adds the Storage Blob Data Reader role to your user id.
    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image24-1.png)

9. Select **Managed identity (1)** and then select **+ Select members (2)**. Select **Search service (3)** under **Managed identity** and select the **searchservice<inject key="DeploymentID" enableCopy="false"/> (4)** search service that gets listed. Click on **Select (5)**

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image25.png)

10. Select **Next** in next 2 screens and on the **Review + assign** page, select **Review + assign**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image41.png)

11. Wait for a **success** message on the role additions before proceeding with the next tasks.

    ![A screenshot of a computer AI-generated content may be incorrect.](./media/image42.png)

12. From the **Overview (1)** page of the Azure OpenAI Service resource, select **Go to Azure AI Foundry portal (2)** to open the Azure OpenAI Service there and deploy a model.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image43.png)

13. On the **Azure AI Foundry** portal, select **Deployments** from the left pane.

    ![A screenshot of a chat AI-generated content may be
incorrect.](./media/image44.png)

14. On the **Model deployments** page, select **+ Deploy model (1)** -\> **Deploy base model (2)**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image45.png)

15. Search for **text-embedding (1)**, select **text-embedding-3-large (2)** and then select **Confirm (3)**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image46-1.png)

16. Select **Deployment type** as **Standard (1)** and then select **Deploy (2)** in the **Deploy text-embedding-3-large** screen.

    ![image](./media/image47.png)

17. The model gets deployed and the screen is loaded with the deployment
    details.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image48.png)

## Task 4: Create a vector index

1.  Navigate back to the Azure portal, open the **searchservice<inject key="DeploymentID" enableCopy="false"/>** AI Search service resource that we created in the previous task.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image49.png)

2. On the **Overview** page, select **Import data (new)**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image50.png)

3. On the **Import data (new)** page, select the **Azure Blob Storage** option.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image51.png)

4. Select the **RAG** option on the **What scenarios are you targeting?** page.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image52.png)

5.  Enter the below details, accept the other values as default and click **Next (4)**.

    - Subscription – Select your **assigned subscription (1)**

    - Storage account- Select **storage<inject key="DeploymentID" enableCopy="false"/> (2)**

    - Blob container – Select **document (3)**

        ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image53.png)

6.  In the Vectorize your text screen, the **subscription (1)** is pre-populated. Enter the below details and click **Next (6)**.

    - Azure OpenAI Service – **openai<inject key="DeploymentID" enableCopy="false"/> (2)**

    - Model deployment – Select **text-embedding-3-large (3)**

    - Authentication type – Select **System assigned identity (4)**

    - Select the checkbox to **acknowledge that connecting to an Azure OpenAI service will incur additional costs to my account (5)**.

        ![A screenshot of a computer AI-generated content may be
    incorrect.](./media/image54.png)

7.  Select Next in the **Vectorize and enrich your images** screen since we are not dealing with images here and select **Next** in the **Advanced settings** screen as well.

    ![A screenshot of a computer AI-generated content may be
    incorrect.](./media/image54-(1).png)
    
    ![A screenshot of a computer AI-generated content may be
    incorrect.](./media/image55.png)

8.  Select **Create** in the **Review + create** screen.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image56.png)

9.  Click on **Close** in the success dialog box.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image57.png)

## Task 5: Create a knowledge assistant agent

1.  Open a new broser and login to [https://copilotstudio.microsoft.com](https://copilotstudio.microsoft.com/) using your login credentials.

2.  Select **Get Started** in the Welcome to Microsoft Copilot Studio.

    ![image](./media/image58.png)

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image59.png)

3.  The agent creation page gets opened. Describe the agent in the **Describe** tab. Enter **You are a Knowledge assistant agent
for HR who will answer questions related to leaves and leave policies to the employees** and select **Send**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image60.png)

4.  The copilot suggests a name to the agent. Click on **Create** to create the agent.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image61.png)

5.  Once the agent is created, in the **Test** pane, enter **How many days of Maternity leaves can I avail? (1)** and click **Send (2)**

    ![image](./media/image63.png)

6.  It gives a generalized reply as in the screenshot below.

    ![image](./media/image64.png)

## Task 6: Add the Azure AI Search as a knowledge source

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
