# 🚀 Getting started with Strapi

Strapi comes with a full featured [Command Line Interface](https://docs.strapi.io/dev-docs/cli) (CLI) which lets you scaffold and manage your project in seconds.

## 🐳 Development with Docker

The easiest way to get started is using Docker and Docker Compose. This will set up both Strapi and PostgreSQL in containers.

### Prerequisites

- Docker installed on your machine
- Docker Compose plugin installed on your machine

### Starting the application

1. Copy the environment file:

```bash
cp .env.example .env
```

2. Start the containers:

```bash
docker compose up -d
```

3. View the logs:

```bash
docker compose logs -f
```

4. Access the application:

- Strapi Admin: http://localhost:1337/admin
- API: http://localhost:1337/api

### Useful Docker commands

```bash
# Stop the containers
docker compose down

# Rebuild the containers
docker compose up -d --build

# View container status
docker compose ps

# Access the Strapi container
docker exec -it strapi /bin/sh

# Access the PostgreSQL container
docker exec -it strapiDB /bin/sh
```

## 🖥️ Local Development (without Docker)

### `develop`

Start your Strapi application with autoReload enabled.

```bash
npm run develop
```

### `start`

Start your Strapi application with autoReload disabled.

```bash
npm run start
```

### `build`

Build your admin panel.

```bash
npm run build
```

## ⚙️ Deployment

Strapi gives you many possible deployment options for your project including [Strapi Cloud](https://cloud.strapi.io). Browse the [deployment section of the documentation](https://docs.strapi.io/dev-docs/deployment) to find the best solution for your use case.

```bash
npm run strapi deploy
```

## 🐋 Docker Deployment

This project uses GitHub Container Registry (ghcr.io) to host private Docker images. The images are built automatically on push to main branch or when creating a new tag.

### Container Registry

Private images are stored at: `ghcr.io/wildlifeai/wildlife-watcher-backend`

Available tags:

- `main` - latest build from main branch
- `v*.*.*` - release versions (e.g., v1.0.0)
- `sha-XXXXXX` - specific commit builds

### Running in Production

1. Login to GitHub Container Registry:

```bash
# Create a Personal Access Token (PAT) with 'read:packages' scope
# at https://github.com/settings/tokens
export CR_PAT=YOUR_PAT
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
```

2. Pull the latest version:

```bash
docker pull ghcr.io/wildlifeai/wildlife-watcher-backend:main
```

3. Clone the repository:

```bash
git clone https://github.com/wildlifeai/wildlife-watcher-backend.git
cd wildlife-watcher-backend
```

4. Create a `.env` file with your production settings.

5. Start the production stack:

```bash
docker compose -f docker-compose.prod.yml up -d
```

### Creating a New Release

To create a new versioned release:

```bash
# Tag the release
git tag v1.0.0

# Push the tag
git push origin v1.0.0
```

This will trigger a new build with the version tag, which you can then pull using:

```bash
docker pull ghcr.io/wildlifeai/wildlife-watcher-backend:v1.0.0
```

## 📚 Learn more

- [Resource Center](https://strapi.io/resource-center) - Strapi resource center.
- [Strapi Documentation](https://docs.strapi.io) - Official Strapi documentation.
- [Strapi Tutorials](https://strapi.io/tutorials) - List of tutorials made by the core team and the community.
- [Strapi Blog](https://docs.strapi.io) - Official Strapi blog containing articles made by the Strapi team and the community.
- [Changelog](https://strapi.io/changelog) - Find out about the Strapi product updates, new features and general improvements.

Feel free to check out the [Strapi GitHub repository](https://github.com/strapi/strapi). Your feedback and contributions are welcome!

## ✨ Community

- [Discord](https://discord.strapi.io) - Come chat with the Strapi community including the core team.
- [Forum](https://forum.strapi.io/) - Place to discuss, ask questions and find answers, show your Strapi project and get feedback or just talk with other Community members.
- [Awesome Strapi](https://github.com/strapi/awesome-strapi) - A curated list of awesome things related to Strapi.

---

<sub>🤫 Psst! [Strapi is hiring](https://strapi.io/careers).</sub>
