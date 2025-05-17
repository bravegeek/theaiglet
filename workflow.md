# Story Generation and Publishing Workflow

## 1. Prompt Selection
1. Check out the `gh-pages` branch
2. Read `prompt.md` to find the next available (unchecked) prompt
3. Display the selected prompt to the user

## 2. Story Generation
1. Generate a story using the selected prompt
2. Format the story using the structure defined in `template-article.md`

## 3. Publishing
1. Save the formatted story to `_posts/` with filename format: `YYYY-MM-DD-title.md`
2. Commit the new story file with a descriptive message

## 4. Prompt Management
1. Mark the used prompt as checked in `prompt.md`
2. Commit the updated `prompt.md` with a message indicating the prompt was used
3. Push the changes to the remote repository

## 5. Clean up
1. Check out the `main` branch
