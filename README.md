# **Setting Up Ollama & Running DeepSeek R1 Locally for a Powerful RAG System**  

## **🔹 AI | RAG | Python | DeepSeek**  

## **🤖 Ollama**  
Ollama is a framework for running large language models (LLMs) locally on your machine. It allows you to download, run, and interact with AI models without relying on cloud-based APIs.  

### **Why use it?**  
✅ Free  
✅ Private & Secure  
✅ Fast  
✅ Works Offline  

### **Example Usage:**  
```sh
ollama run deepseek-r1:1.5b
```
This command runs DeepSeek R1 locally.  

---  

## **🔗 LangChain**  
LangChain is a Python/JavaScript framework that helps integrate LLMs with external data sources, APIs, and memory.  

### **Why use it?**  
- Connects LLMs to real-world applications like chatbots, document processing, and Retrieval-Augmented Generation (RAG).  

---  

## **📄 What is RAG (Retrieval-Augmented Generation)?**  
RAG is an AI technique that retrieves external data (e.g., PDFs, databases) and augments the LLM’s response.  

### **Why use it?**  
✅ Improves accuracy  
✅ Reduces hallucinations  
✅ Enhances LLM responses with real-world data  

### **Example:**  
AI-powered PDF Q&A system that retrieves relevant document content before generating answers.  

---  

## **⚡ DeepSeek R1**  
DeepSeek R1 is an open-source AI model optimized for reasoning, problem-solving, and factual retrieval.  

### **Why use it?**  
✅ Strong logical capabilities  
✅ Great for RAG applications  
✅ Can be run locally with Ollama  

---  

## **🚀 How They Work Together?**  
1️⃣ **Ollama** runs DeepSeek R1 locally.  
2️⃣ **LangChain** connects the AI model to external data.  
3️⃣ **RAG** enhances responses by retrieving relevant information.  
4️⃣ **DeepSeek R1** generates high-quality answers.  

### **💡 Example Use Case**  
A Q&A system that allows users to upload a PDF and ask questions about it, powered by DeepSeek R1 + RAG + LangChain on Ollama! 🚀  

---  

## **🎯 Why Run DeepSeek R1 Locally?**  

| Benefit         | Cloud-Based Models | Local DeepSeek R1 |
|----------------|--------------------|-------------------|
| **Privacy**    | ❌ Data sent to external servers | ✅ 100% Local & Secure |
| **Speed**      | ⏳ API latency & network delays | ⚡ Instant inference |
| **Cost**       | 💰 Pay per API request | 🆓 Free after setup |
| **Customization** | ❌ Limited fine-tuning | ✅ Full model control |
| **Deployment** | 🌍 Cloud-dependent | 🔥 Works offline & on-premises |

---

## **🛠 Step 1: Installing Ollama**  
### **🔹 Download Ollama**  
Ollama is available for macOS, Linux, and Windows.  

1️⃣ Go to the [official Ollama download page](https://ollama.com/download)  
2️⃣ Select your operating system  
3️⃣ Click on the **Download** button  
4️⃣ Install it following the system-specific instructions  

---

## **🛠 Step 2: Running DeepSeek R1 on Ollama**  

### **🔹 Pull the DeepSeek R1 Model**  
To download and set up the DeepSeek R1 (1.5B parameter model), run:  
```sh
ollama pull deepseek-r1:1.5b
```

### **🔹 Running DeepSeek R1**  
After the model is downloaded, start interacting with it using:  
```sh
ollama run deepseek-r1:1.5b
```

---

## **🛠 Step 3: Setting Up a RAG System Using Streamlit**  

### **🔹 Prerequisites**  
Before running the RAG system, install the required dependencies:  

```sh
pip install -U langchain langchain-community
pip install streamlit
pip install pdfplumber
pip install semantic-chunkers
pip install open-text-embeddings
pip install faiss
pip install ollama
pip install prompt-template
pip install langchain_experimental
pip install sentence-transformers
pip install faiss-cpu
```

---

## **🛠 Step 4: Running the RAG System**  

### **🔹 Clone or Create the Project**  
```sh
mkdir rag-system && cd rag-system
```
Create a Python script `app.py` and paste the following code:

```python
import streamlit as st
from langchain_community.document_loaders import PDFPlumberLoader
from langchain_experimental.text_splitter import SemanticChunker
from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_community.vectorstores import FAISS
from langchain_community.llms import Ollama
from langchain.prompts import PromptTemplate
from langchain.chains.llm import LLMChain
from langchain.chains.combine_documents.stuff import StuffDocumentsChain
from langchain.chains import RetrievalQA

# Streamlit UI
st.title("📄 RAG System with DeepSeek R1 & Ollama")

uploaded_file = st.file_uploader("Upload your PDF file here", type="pdf")

if uploaded_file:
    with open("temp.pdf", "wb") as f:
        f.write(uploaded_file.getvalue())

    loader = PDFPlumberLoader("temp.pdf")
    docs = loader.load()

    text_splitter = SemanticChunker(HuggingFaceEmbeddings())
    documents = text_splitter.split_documents(docs)

    embedder = HuggingFaceEmbeddings()
    vector = FAISS.from_documents(documents, embedder)
    retriever = vector.as_retriever(search_type="similarity", search_kwargs={"k": 3})

    llm = Ollama(model="deepseek-r1:1.5b")

    prompt = """
    Use the following context to answer the question.
    Context: {context}
    Question: {question}
    Answer:"""

    QA_PROMPT = PromptTemplate.from_template(prompt)

    llm_chain = LLMChain(llm=llm, prompt=QA_PROMPT)
    combine_documents_chain = StuffDocumentsChain(llm_chain=llm_chain, document_variable_name="context")

    qa = RetrievalQA(combine_documents_chain=combine_documents_chain, retriever=retriever)

    user_input = st.text_input("Ask a question about your document:")

    if user_input:
        response = qa(user_input)["result"]
        st.write("**Response:**")
        st.write(response)
```

---

## **🛠 Step 5: Running the App**  
Once the script is ready, start your Streamlit app:  

```sh
streamlit run app.py
```

---

## **🚀 Summary**  
You now have a fully functional local RAG system powered by:  
✅ **Ollama** for running DeepSeek R1 locally  
✅ **LangChain** for integrating LLMs with data sources  
✅ **Streamlit** for an interactive UI  

This setup enables **secure, fast, and cost-free** AI-powered document retrieval and Q&A. 🚀  
