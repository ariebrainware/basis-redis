# Docker deploy CI

This repository includes a GitHub Actions workflow to build and push the Docker image to GitHub Container Registry (GHCR).

Image name:

- The workflow pushes to `ghcr.io/<OWNER>/<REPO>`, which is available as `ghcr.io/${{ github.repository }}` in the workflow. Example: `ghcr.io/your-org/basis-redis`.

Authentication and permissions:

- The workflow uses the automatically provided `GITHUB_TOKEN` to authenticate to GHCR. The workflow file configures packages write permission (`permissions.packages: write`) so the token can push packages.
- If you prefer a personal token, create a PAT with the `write:packages` scope and store it as a secret (for example `CR_PAT`) and replace `${{ secrets.GITHUB_TOKEN }}` in the workflow with your secret.

Runner:

- The workflow targets a self-hosted runner labeled `evolto3-runner`. Ensure you have a self-hosted runner registered with that label.

Usage:

- Push to `main` to trigger a build of the default branch, or create a tag matching `v*` to trigger a release build. In both cases, the job will build the image and push two tags: `latest` and the commit SHA (version tags do not currently produce additional image tags).

Redis runtime configuration:

- The deploy step creates/uses a Docker network named `baota_net` and runs the container attached to that network.
- Set the repository secret `REDIS_PASSWORD` with the desired Redis password. The workflow will pass this secret into the container and start Redis with `--requirepass` to enforce authentication.

