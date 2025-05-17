# **Satirical Story Generator – Planning Document**

## **Overview**
This application will generate satirical stories based on a predefined list of prompts using an AI API. The generated stories will be formatted in Markdown and automatically checked into a Git repository.

## **Features**
### **1. Prompt Selection**
- Maintain a predefined list of satirical prompts.
- Allow selection of a random or user-chosen prompt.

### **2. Story Generation**
- Use an AI API (e.g., OpenAI, Anthropic, or another LLM provider) to generate the satirical story.
- Ensure stories adhere to the desired tone and formatting.

### **3. Markdown Formatting**
- Convert the AI-generated story into Markdown.
- Support title, subtitles, and sections for readability.
- Embed metadata (timestamp, author, prompt used, etc.).

### **4. Version Control & Storage**
- Automatically commit each new story to a Git repository.
- Generate a unique filename based on timestamp and prompt.
- Push to a remote repository for archiving.

### **5. User Interface**
- CLI-based interaction for simplicity.
- Optional web-based UI for enhanced usability.

## **Technical Stack**
- **AI API:** OpenAI GPT, Anthropic Claude, or another LLM provider.
- **Programming Language:** Python or Node.js.
- **Markdown Handling:** Python-Markdown or similar libraries.
- **Version Control:** Git (via CLI commands or GitHub API).
- **Storage:** Local repository or cloud storage.

## **Workflow**
1. User selects or randomizes a prompt.
2. AI API generates the satirical story.
3. Story is formatted into Markdown.
4. Story is saved locally and committed to Git.
5. Push to the repository.

## **Detailed Workflow from write-a-story.txt**
### **1. Prompt Selection**
- Check out `gh-pages` branch
- Read `_/workflow/prompt.md` to get the next unchecked prompt
- Display the selected prompt to the user

### **2. Story Generation**
- Generate story using the selected prompt
- Format the story using `_/workflow/template-article.md`

### **3. Publishing**
- Save formatted story to `_posts/YYYY-MM-DD-title.md`
- Commit the new story file

### **4. Prompt Management**
- Mark the used prompt as checked in `_/workflow/prompt.md`
- Commit the updated `_/workflow/prompt.md`

## **Next Steps**
- Define the list of prompts.
- Choose the AI API for generation.
- Implement the Markdown formatting.
- Set up Git integration.
- Test and refine.
- Set up Git repository with `main` and `gh-pages` branches
- Create `_/workflow/prompt.md` with initial prompts
- Create `_/workflow/template-article.md` with Jekyll front matter
- Implement the workflow script
- Test the complete workflow
- Set up GitHub Actions for automation