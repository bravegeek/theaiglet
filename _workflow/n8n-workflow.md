# n8n Workflow for AI Story and Image Generation

This n8n workflow automates the process of generating a story and an image based on prompts from `_workflow/prompt.md`. The workflow performs the following steps:

1. **Check out the gh-pages branch**
2. **Read `_workflow/prompt.md` and identify the next unchecked prompt**
3. **Generate a creative story based on this prompt**
4. **Generate an image from the story and save it to a file**
5. **Format the story using the template in `_workflow/template-article.md`**
6. **Save the formatted story and the image to `_posts/YYYY-MM-DD-title.md`**
7. **Commit the new story file with a descriptive message**
8. **Mark the used prompt as checked in `_workflow/prompt.md**
9. **Commit the updated `_workflow/prompt.md`**

## Workflow JSON

```json
{
  "nodes": [
    {
      "parameters": {
        "triggerTimes": {
          "item": [
            {
              "hour": 9,
              "minute": 0
            }
          ]
        }
      },
      "name": "Cron",
      "type": "n8n-nodes-base.cron",
      "typeVersion": 1,
      "position": [
        250,
        300
      ]
    },
    {
      "parameters": {
        "command": "git checkout gh-pages"
      },
      "name": "Git Checkout",
      "type": "n8n-nodes-base.executeCommand",
      "typeVersion": 1,
      "position": [
        450,
        300
      ]
    },
    {
      "parameters": {
        "command": "cat _workflow/prompt.md"
      },
      "name": "Read Prompt File",
      "type": "n8n-nodes-base.executeCommand",
      "typeVersion": 1,
      "position": [
        650,
        300
      ]
    },
    {
      "parameters": {
        "functionCode": "const prompts = $json['stdout'].split('\\n').filter(line => line.includes('[ ]'));\nreturn { prompt: prompts[0] }"
      },
      "name": "Find Unchecked Prompt",
      "type": "n8n-nodes-base.function",
      "typeVersion": 1,
      "position": [
        850,
        300
      ]
    },
    {
      "parameters": {
        "url": "[https://api.example.com/generate-story",](https://api.example.com/generate-story",)
        "method": "POST",
        "jsonParameters": true,
        "options": {},
        "bodyParametersJson": "{\"prompt\": \"{{$node[\"Find Unchecked Prompt\"].json[\"prompt\"]}}\"}"
      },
      "name": "Generate Story",
      "type": "n8n-nodes-base.httpRequest",
      "typeVersion": 1,
      "position": [
        1050,
        300
      ]
    },
    {
      "parameters": {
        "url": "[https://api.openai.com/v1/images/generations",](https://api.openai.com/v1/images/generations",)
        "method": "POST",
        "jsonParameters": true,
        "options": {
          "headers": {
            "Authorization": "Bearer YOUR_OPENAI_API_KEY",
            "Content-Type": "application/json"
          }
        },
        "bodyParametersJson": "{\"prompt\": \"Generate an image for the following story: {{$node[\"Generate Story\"].json[\"story\"]}}\", \"n\": 1, \"size\": \"1024x1024\"}"
      },
      "name": "Generate Image",
      "type": "n8n-nodes-base.httpRequest",
      "typeVersion": 1,
      "position": [
        1250,
        300
      ]
    },
    {
      "parameters": {
        "functionCode": "const fs = require('fs');\nconst storyTemplate = fs.readFileSync('_workflow/template-article.md', 'utf8');\nconst formattedStory = storyTemplate.replace('{{story}}', $node[\"Generate Story\"].json[\"story\"]);\nreturn { formattedStory };"
      },
      "name": "Format Story",
      "type": "n8n-nodes-base.function",
      "typeVersion": 1,
      "position": [
        1450,
        300
      ]
    },
    {
      "parameters": {
        "command": "echo \"{{$node[\"Format Story\"].json[\"formattedStory\"]}}\" > _posts/$(date +\"%Y-%m-%d\")-title.md"
      },
      "name": "Save Story",
      "type": "n8n-nodes-base.executeCommand",
      "typeVersion": 1,
      "position": [
        1650,
        300
      ]
    },
    {
      "parameters": {
        "command": "wget -O _posts/images/$(date +\"%Y-%m-%d\")-image.png \"{{$node[\"Generate Image\"].json[\"data\"][0][\"url\"]}}\""
      },
      "name": "Save Image",
      "type": "n8n-nodes-base.executeCommand",
      "typeVersion": 1,
      "position": [
        1850,
        300
      ]
    },
    {
      "parameters": {
        "command": "git add _posts/* && git commit -m \"Add new story and image\""
      },
      "name": "Commit Story and Image",
      "type": "n8n-nodes-base.executeCommand",
      "typeVersion": 1,
      "position": [
        2050,
        300
      ]
    },
    {
      "parameters": {
        "functionCode": "const fs = require('fs');\nlet promptFile = fs.readFileSync('_workflow/prompt.md', 'utf8');\npromptFile = promptFile.replace('{{prompt}}', '[x]');\nfs.writeFileSync('_workflow/prompt.md', promptFile);\nreturn {};"
      },
      "name": "Mark Prompt as Checked",
      "type": "n8n-nodes-base.function",
      "typeVersion": 1,
      "position": [
        2250,
        300
      ]
    },
    {
      "parameters": {
        "command": "git add _workflow/prompt.md && git commit -m \"Mark prompt as checked\""
      },
      "name": "Commit Prompt File",
      "type": "n8n-nodes-base.executeCommand",
      "typeVersion": 1,
      "position": [
        2450,
        300
      ]
    }
  ],
  "connections": {
    "Cron": {
      "main": [
        [
          {
            "node": "Git Checkout",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Git Checkout": {
      "main": [
        [
          {
            "node": "Read Prompt File",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Read Prompt File": {
      "main": [
        [
          {
            "node": "Find Unchecked Prompt",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Find Unchecked Prompt": {
      "main": [
        [
          {
            "node": "Generate Story",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Generate Story": {
      "main": [
        [
          {
            "node": "Generate Image",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Generate Image": {
      "main": [
        [
          {
            "node": "Format Story",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Format Story": {
      "main": [
        [
          {
            "node": "Save Story",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Save Story": {
      "main": [
        [
          {
            "node": "Save Image",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Save Image": {
      "main": [
        [
          {
            "node": "Commit Story and Image",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Commit Story and Image": {
      "main": [
        [
          {
            "node": "Mark Prompt as Checked",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Mark Prompt as Checked": {
      "main": [
        [
          {
            "node": "Commit Prompt File",
            "type": "main",
            "index": 0
          }
        ]
      ]
    }
  }
}