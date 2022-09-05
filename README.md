# Capture the Ether Solutions with Foundry Script

## Getting Started

1. **Install Foundry**

Open your terminal and run the command below to get foundryup:

``` bash
curl -L https://foundry.paradigm.xyz | bash
```

Reload your PATH or start a new terminal instance, then run `foundryup` to install Foundry


2. **Clone this repo and install dependencies**

```bash
git clone https://github.com/iczc/capture-the-ether-solutions-foundry.git
cd capture-the-ether-solutions-foundry
forge install
```

3. **Set environment variables**

Add `.env` file to the project directory with the following content:
```bash
RPC_URL=rpcendpoint
PLAYER_KEY=yourprivatekey
```

Replace rpcendpoint and yourprivatekey with appropriate values

4. **Run exploit for a challenge**

```bash
./run.sh [CAHLLENGE_NAME] [CHALLENGE_ADDRESS]
```

The challenge name of https://capturetheether.com/challenges/warmup/call-me/ is `call-me`  