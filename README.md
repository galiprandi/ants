# 🐜 ants: Where Code Evolves Like Life Itself
Welcome to **ants**, the anthill where software doesn't just sit there—it **grows, learns, and evolves**.
This isn't a repository. It's a living ecosystem where autonomous agents (yes, actual ants) research, propose, build, and improve code while you sip your coffee.
## 🧐 What is ants?
ants is built on the philosophy of **AI Augmented Evolution (AAE)**. Picture this: every task in your backlog gets picked up by a specialized ant that:
 1. **Awakening:** A lightweight Docker container wakes up ready to work.
 2. **Work:** It crushes its mission (refactoring, testing, researching).
 3. **Collaborate:** It pushes changes and opens a Pull Request.
 4. **Rest:** The container goes back to sleep, leaving only pure value behind.
## 🏗️ The Swarm Anatomy
In this ecosystem, tasks are divided into specialized roles:
| Ant | Primary Function |
|---|---|
| **🐜 Architect Ant** | Watches the structure and enforces SOLID/Clean Code principles. |
| **🐜 Bug-Hunter Ant** | Analyzes error reports and proposes immediate patches. |
| **🐜 Researcher Ant** | Compares the repo with external trends and proposes new features. |
| **🐜 Quality Ant** | Ensures that test coverage never drops. |
## 👑 The Human in the Loop (The Queen)
The ants are autonomous, but this colony has a **Queen**: You.
Human wisdom is essential at two critical moments:
 * **Strategic Direction:** You point the compass. You tell the swarm where to focus its energy this quarter.
 * **Evolutionary Filter:** The ants propose hundreds of improvements, but you pick the ones that actually matter—capitalizing on everything the swarm learns.
## 🚀 Wake Your First Ant
Ready to put an ant to work? Build the ant body first, then wake it:
```bash
# Build the ant body
docker build -f .ants/body -t ants-ant .

# Wake the ant
docker run --rm \
  -e GITHUB_TOKEN="your_github_token" \
  -e REPO_URL="github.com/user/repo.git" \
  -e BRANCH_NAME="functional-evolution" \
  -e AI_API_KEY="your_api_key" \
  -e SYSTEM_PROMPT="Your mission is to optimize the main loop performance." \
  -e BOT_NAME="Worker-Ant-01" \
  ants-ant

# Or use the wake script
./.ants/wake.sh "Worker-Ant-01"
```
## 🤝 Join the Colony
Want to join the swarm? We'd love to have more ants in the hill!
To keep things organized, **every contribution starts with an issue**. Whether you're proposing a new ant type, found a bug in the container, or have a strategic idea:
 1. **Create an Issue:** Tell us your idea or what you found.
 2. **Discuss:** We (humans and maybe some bots) will figure out if it flies.
 3. **Evolve:** Once approved, submit a PR or wait for one of our ants to pick it up.
## 🌀 Philosophy: Momentum & The Game of Life
ants draws inspiration from Conway's **Game of Life**: simple rules for individual agents that create complex, beautiful emergent behavior.
By combining micro-agent squads with a **Scale-up** methodology, we generate technological **Momentum**: a constant drive for continuous improvement that makes software a living, adaptable organism that never gets old.
*Built with ❤️ (and plenty of caffeine) by Germán Aliprandi and the entire ants swarm.*
