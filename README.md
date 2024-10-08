
# FastAPI App Deployment & CI/CD Setup

This repository contains a FastAPI application along with a setup guide to deploy the app on a server and configure a CI/CD pipeline using GitHub Actions. Follow the steps below to set up the deployment and automation process.

## Prerequisites

1. A GitHub repository.
2. A server with `ssh` access and permissions to modify Nginx configuration.
3. Docker installed on the server.

## Steps to Deploy

### 1. Create GitHub Repository and Deployment Key

- Create a GitHub repository (if not already created).
- Generate an SSH key pair on the server:
  
  ```bash
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/depl_key
  ```
  
- Add the **public key** (`~/.ssh/depl_key.pub`) as a deployment key in your GitHub repository.
  
  - Go to **Settings** → **Deploy Keys** → **Add deploy key**.
  - Paste the contents of `~/.ssh/depl_key.pub`.
  - Check **Allow write access**.

- Update your server's SSH configuration to use the private key (`~/.ssh/depl_key`) for GitHub interactions.

### 2. Install and Configure Nginx

- Install Nginx:

  ```bash
  sudo apt update
  sudo apt install nginx
  ```


- Copy your FastAPI app's Nginx configuration file (e.g., `fastapiapp`) to `/etc/nginx/sites-enabled/`:

  ```bash
  sudo cp fastapiapp /etc/nginx/sites-enabled/
  ```

- Unlink the default Nginx site configuration:

  ```bash
  sudo unlink /etc/nginx/sites-enabled/default
  ```

- Restart Nginx:

  ```bash
  sudo systemctl restart nginx
  ```

### 3. Install Docker and Setup Docker Configuration

- Install Docker:

  ```bash
  sudo apt install docker.io
  ```

- Ensure you have a `Dockerfile` and `docker-compose.yml` file in your repository. If not, copy the existing ones from the repository.

- Build and run the Docker container:

  ```bash
  sudo docker-compose up --build -d
  ```

### 4. Write the FastAPI App and Configure GitHub Workflow

- Ensure that your FastAPI app has a GitHub workflow endpoint for automation. If you want to use the existing endpoint in your repository, check the `api.py` file for details.

- Set up GitHub Actions workflow in your repository to trigger the CI/CD process on specific events (e.g., `push` to `main`).

### 5. Setup the `deploy.sh` Script

- Copy the `deploy.sh` script from your repository to the server.

- Modify the script to include your GitHub repository details (replace `<your_repo_name>` with your repository name).

- Make the script executable:

  ```bash
  chmod +x deploy.sh
  ```

- Run the `deploy.sh` script:

  ```bash
  ./deploy.ssh
  ```

This script will pull the latest changes from your GitHub repository and restart the Docker container with the updated code.

## Additional Information

- Make sure your GitHub repository and server configurations are secure and permissions are correctly set.
- Monitor your app's logs using:

  ```bash
  sudo docker-compose logs -f
  ```

## Contributing

Feel free to open issues or submit pull requests if you'd like to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
