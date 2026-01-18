# Docker deploy CI


This repository includes a GitHub Actions workflow to build and push the Docker image to GitHub Container Registry (GHCR).

Image name:

- The workflow pushes to `ghcr.io/<OWNER>/<REPO>`, which is available as `ghcr.io/${{ github.repository }}` in the workflow. Example: `ghcr.io/your-org/basis-redis`.

Authentication and permissions:

- The workflow uses the automatically provided `GITHUB_TOKEN` to authenticate to GHCR. The workflow file configures `permissions: packages: write` so the token can push packages.
- If you prefer a personal token, create a PAT with the `write:packages` scope and store it as a secret (for example `CR_PAT`) and replace `${{ secrets.GITHUB_TOKEN }}` in the workflow with your secret.

Runner:

- The workflow targets a self-hosted runner labeled `evolto3-runner`. Ensure you have a self-hosted runner registered with that label.

Usage:

- Push to `main` or create a tag `v*` to trigger the workflow. The job will build the image and push two tags: `latest` and the commit SHA.
