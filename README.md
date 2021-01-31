# actions-runner: GitHub Actions runner docker image

## example usage

Read https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners to understand usual configuration of the hosted-runner.

```shell
# * Clone at-wat/actions-runner
cd /path/to/your/workdir
git clone https://github.com/at-wat/actions-runner.git

# * Setup runner config
sudo mkdir -p /opt/actions-runner
sudo chown ${USER}: /opt/actions-runner
cd /opt/actions-runner
ln -s /path/to/your/workdir/actions-runner/config.sh ./
ln -s /path/to/your/workdir/actions-runner/run.sh ./
./config.sh --url https://github.com/OWNER/REPO --token SELF_HOSTED_RUNNER_TOKEN

# * Run runner as a systemd service
sudo cp /path/to/your/workdir/actions-runner/examples/actions-runner.service /etc/systemd/system/
sudo systemctl enable actions-runner.service
sudo systemctl start actions-runner.service
```
