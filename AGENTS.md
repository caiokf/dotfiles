# Agent Rules

## Commits

- Always create small, focused commits with a single purpose
- Each commit should be atomic and independently revertable
- Write clear commit messages explaining the "why", not just the "what"
- Group related changes together, but separate unrelated changes into different commits

## Secrets

- NEVER commit secrets, API keys, tokens, passwords, or credentials
- Check for secrets before staging: AWS keys, SSH keys, tokens, .env files
- Files that commonly contain secrets and should be in .gitignore:
  - `.env`, `.env.*`
  - `*credentials*`
  - `*secret*`
  - `*.pem`, `*.key`
  - `config/aws_*`
- If a secret is accidentally staged, unstage it immediately with `git reset HEAD <file>`
- If a secret was committed, alert the user - it needs to be rotated
