# Lab 02: Create a Knowledge Assistant agent for HR in Copilot Studio that leverages Azure AI Search

### Estimated Duration: 01 hour

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

    - Username - <inject key="AzureAdUserEmail"></inject>

    - Password - <inject key="AzureAdUserPassword"></inject>

1. From the Home page of the Azure portal, select **Azure AI Foundry.**

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image1.png)

2. In the **AI Foundry page**, select **AI Search (1)** under **Use with AI Foundry** from the left pane.

    ![A screenshot of a search engine AI-generated content may be
incorrect.](./media/image2.png)

3.  From the **Overview** page, copy the **Url** value and save it in a notepad to be used in a future exercise.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image6.png)

4.  Select **Keys (2)** under **Settings (1)** from the left pane. Copy the **Primary admin key (3)** and save it in a notepad for using it in the upcoming exercises.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image7.png)

5.  Select **Identity (2)** under **Settings (1)** from the left pane.

    ![A screenshot of a search engine AI-generated content may be
incorrect.](./media/image8.png)

6.  Toggle the Status to **On (1)** under **System assigned** and then click on **Save (2)**.

    ![A screenshot of a search engine AI-generated content may be
incorrect.](./media/image9.png)

7. Select **Yes** in the **Enable system assigned managed identity** confirmation dialog.

    ![A screenshot of a computer error AI-generated content may be
incorrect.](./media/image10.png)

## Task 2: Create a Storage account

1.  From the Azure portal Home page, select **Storage accounts**.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image11.png)

2.  Select **Containers (1)** under **Data storage**. Select **document (2)** container.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image17.png)

3.  Select the created container **document** to upload the leave policy document into it.

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

2. Select Azure AI Search from the list of knowledge sources available.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image66.png)

3.  Click on the **drop down** next to **Not connected** in the next screen and select **Create new connection**.

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

6.  The AI Search service is added as a knowledge source to the agent and is in **Ready** state now. Ensure that the **Web search** option
    is **disabled** in the Knowledge section.

    ![A screenshot of a computer AI-generated content may be
incorrect.](./media/image70.png)

7.  Now, let us test the agent with the same question we tried before.

8.  In the Test pane, enter **How many days of Maternity leaves can I avail?** and click **Send.**

    ![image](./media/image71.png)

9.  You can see that the response from the agent now is from the document uploaded in the AI Search service.

    ![image](./media/im6.png)

   
## Summary
In this lab, you have completed the following tasks:
- 

### You have successfully completed the lab. Click on **Next >>** to proceed with the next Lab.

![](./media/9-7-next.png)
