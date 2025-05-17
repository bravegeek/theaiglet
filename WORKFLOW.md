# LLM Prompts for Story Generation Workflow

## Prompt 1: Branch and Prompt Selection
```
Check out the gh-pages branch of the repository and read the prompt.md file. Identify the next unchecked prompt in the file and display it to me.
```

## Prompt 2: Story Generation
```
Using the following prompt: "[INSERT SELECTED PROMPT HERE]", generate a creative short story. Format the story according to the structure defined in template-article.md, including appropriate front matter.
```
## TODO: Generate an image using the story

## Prompt 3: Story Publishing
```
Save the generated story to the _posts directory with the filename format YYYY-MM-DD-title.md, where YYYY-MM-DD is today's date and title is a kebab-case version of the story title. Then commit this new file with a descriptive message like "Add new story: [STORY TITLE]".
```

## Prompt 4: Prompt Management
```
In the prompt.md file, mark the prompt "[INSERT USED PROMPT HERE]" as checked by adding an 'x' in its checkbox. Commit the updated prompt.md with a message indicating "Mark prompt as used: [BRIEF PROMPT DESCRIPTION]". Then push all changes to the remote repository.
```

## Prompt 5: Clean Up
```
Check out the main branch to complete the workflow.
```

## All-in-One Workflow Prompt
```
Follow this workflow to generate and publish a new story:

1. Check out the gh-pages branch
2. Read prompt.md and identify the next unchecked prompt
3. Generate a creative story based on this prompt
4. Format the story using the template in template-article.md
5. Save the formatted story to _posts/YYYY-MM-DD-title.md
6. Commit the new story file with a descriptive message
7. Mark the used prompt as checked in prompt.md
8. Commit the updated prompt.md
9. Push all changes to the remote repository
10. Check out the main branch to complete the process

Please execute each step and report your progress.
```
