# The Aiglet

> Keeping you sane while the world unravels

The Aiglet is a satirical news publication featuring sharp, witty commentary on technology, politics, business, and society. Think *The Onion* meets *The Atlantic* with a focus on modern tech culture and generational divides.

**Live Site:** [theaiglet.top](https://theaiglet.top/)

## Tech Stack

- **Static Site Generator:** [Hugo](https://gohugo.io/) (v0.120+)
- **Theme:** Quint
- **Hosting:** GitHub Pages
- **Content Creation:** AI-assisted workflow using Claude Code agents

## Quick Start

### Prerequisites

- [Hugo Extended](https://gohugo.io/installation/) v0.120 or later
- Git

### Local Development

```bash
# Clone the repository
git clone https://github.com/bravegeek/theaiglet.git
cd theaiglet

# Initialize git submodules (for theme)
git submodule update --init --recursive

# Start the Hugo development server
hugo server

# Or with drafts enabled
hugo server -D
```

Visit `http://localhost:1313` to preview the site.

## Project Structure

```
theaiglet/
├── archetypes/          # Content templates
├── assets/              # CSS, JS, and other assets
├── content/
│   └── posts/           # Article content
│       └── YYYY-MM-DD-article-slug/
│           ├── index.md           # Article markdown
│           └── featured-image.jpg # Article image
├── data/                # Data files
├── layouts/             # Custom Hugo layouts
├── static/              # Static files (images, fonts, etc.)
├── themes/              # Hugo theme (quint)
├── hugo.toml            # Site configuration
└── README.md
```

## Creating New Articles

### Manual Method

1. Create a new directory for your article:
   ```bash
   mkdir -p content/posts/$(date +%Y-%m-%d)-your-article-slug
   ```

2. Create `index.md` with frontmatter:
   ```yaml
   ---
   title: "Your Article Title"
   date: 2025-12-20T14:30:00-05:00
   draft: false
   tags: ["satire", "technology", "politics"]
   description: "A brief description of your article"
   image: "featured-image.jpg"
   alt: "Image description for accessibility"
   imagePrompt: "Optional: AI image generation prompt"
   ---

   Your article content here...
   ```

3. Add your featured image to the same directory

### Agent-Assisted Method (Recommended)

The Aiglet uses specialized Claude Code agents for streamlined content creation:

```bash
# Launch the satirical article agent
@agent-satirical-article
```

The agent workflow:
1. **Brainstorm ideas** - Search recent news and generate satirical angles
2. **Draft article** - Write in The Aiglet's voice with proper structure
3. **Get feedback** - Optional roast from the writing critic agent
4. **Generate image prompt** - Create detailed prompts for featured images
5. **Publish** - Automatically create Hugo files with proper metadata

#### Available Agents

- **satirical-article** - Main content creation agent
  - Manages ideas and drafts
  - Generates articles in The Aiglet style
  - Creates image prompts

- **hugo-publisher** - Publishing automation
  - Creates Hugo directory structure
  - Generates metadata and frontmatter
  - Handles file organization

- **roast-my-writing** - Writing critique
  - Provides brutal, honest feedback
  - Catches overused jokes and pacing issues
  - Ensures satirical voice consistency

## Writing Guidelines

### The Aiglet Voice

- **Deadpan delivery** - Write like real news, let the absurdity speak for itself
- **Sharp specificity** - Use concrete details (names, numbers, quotes)
- **Professional tone** - Maintain journalistic structure
- **Layered satire** - Multiple levels of commentary working together
- **Trust your reader** - Don't over-explain the joke

### Article Structure

1. **Headline** - Clear, specific, hints at the satire
2. **Lede** - Sets up the premise with journalistic tone
3. **Section headers** - Break up text, add comedic beats
4. **Quotes** - Mix of absurd and realistic
5. **Details** - Sponsors, statistics, specific examples
6. **Closing** - Strong punchline or escalation

### What Works

- Generational economic inequality
- Tech industry absurdity
- Corporate doublespeak
- Political theater
- Cultural contradictions

### What to Avoid

- Punching down
- Gratuitous shock value
- Overexplaining jokes
- Breaking character/winking too hard
- Cramming too many jokes per paragraph

## Image Guidelines

### Featured Images

- **Format:** JPG or PNG
- **Filename:** Descriptive kebab-case (e.g., `patriot-games-obstacle-course.jpg`)
- **Location:** Same directory as `index.md`
- **Alt text:** Always include descriptive alt text in frontmatter

### Image Styles

The Aiglet uses three main visual approaches:

1. **Photorealistic Documentary** - Looks like real event photography
2. **Editorial Illustration** - New Yorker/Atlantic style, sophisticated
3. **Retro Propaganda Parody** - Vintage Americana with modern irony

Include detailed image prompts in article frontmatter for future regeneration.

## Deployment

The site automatically deploys to GitHub Pages on push to `main`:

```bash
# Build the site
hugo

# Or build with future-dated posts
hugo --buildFuture

# The public/ directory contains the generated site
```

### Manual Deployment

```bash
git add .
git commit -m "Publish: Article title"
git push origin main
```

GitHub Actions handles the rest.

## Configuration

Key settings in `hugo.toml`:

- **baseURL** - Production URL
- **title** - Site title
- **theme** - Hugo theme name
- **params.description** - Site tagline
- **params.logo** - Site logo path
- **pagination.pagerSize** - Posts per page

## Contributing

### Content Guidelines

1. Read existing articles to understand the voice
2. Use the agent workflow for consistency
3. Get feedback before publishing
4. Include proper metadata and images
5. Test locally before pushing

### Code Contributions

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Maintenance

### Updating Theme

```bash
git submodule update --remote --merge
```

### Clearing Cache

```bash
hugo --gc
```

## Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [Markdown Guide](https://www.markdownguide.org/)
- [The Onion Style](https://www.theonion.com/) - Inspiration
- [Claude Code](https://claude.com/claude-code) - AI assistance

## License

Content © The Aiglet. All rights reserved.

## Contact

- **GitHub:** [bravegeek/theaiglet](https://github.com/bravegeek/theaiglet)
- **Website:** [theaiglet.top](https://theaiglet.top/)

---

*Built with Hugo. Powered by satire. Maintained by humans (and helpful AI agents).*
