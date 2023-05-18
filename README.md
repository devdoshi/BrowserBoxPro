# Install and Run

Firstly, it's important to run the install process from bash (bourne shell). Although it should work from other shells, it's possible that some install scripts will break if not run from a bash shell. 

**First, set up your machine**

An example set up on Debian is given below, and involves upgrading your packages, creating a sudo user, and installing required basic tools (git, curl, wget). From `root`, do:

1. `adduser pro` (create a user to run bbpro)
2. `usermod -L pro`
3. `addgroup sudoers`
4. `visudo` (add: `%sudoers ALL=(ALL) NOPASSWD:ALL` if desire to not enter password for sudo)
5. `usermod -G sudoers pro` (give that user sudo privileges)

Switch to that user (`sudo -u pro bash`), and do:

1. `sudo apt update && sudo -y apt upgrade`
2. `sudo apt install git curl wget`

Now open **a block of TCP ports** around your main port (in the example below, you use port `8080` as your main browser service port).

A single browser instance runs 3 services (audio, devtools, and browser) and requires 3 ports. But we use a block of 5 ports for redundancy. These services run on separate ports:

- Main browser service: input port (in our example, 8080)
- Audio service: browser service port - 2 (in our example, 8078)
- Devtools service: browser service port + 1 (in our example, 8081)

In other words, the main browsing services runs on the *middle port of the block* and there's space either side for 2 satellite services each (in the above example, audio and devtools are the satellite services used). 

So, open a block of 5 ports centered on 8080: in other words, open up TCP ports 8078 through 8082.

*And that's it!* At this point your machine should be set up to begin the install. ✔️

**Then, run the install**

:warning: Make sure you're installing from a non-`root` user with `sudo` permissons (for example, the `pro` user created in the example above), because some components aren't intended to be installed as root and probably won't work, but nevertheless require `sudo` to install.

ℹ️ Make sure you have set up your hostname DNS records for your VPS prior to install, as we use LetsEncrypt to get certificates for the web application.

🥇 You need to respond "Y" to some prompts throughout the install, so be sure to sit there and complete it and not let it time out.

1. `git clone https://github.com/dosyago/BrowserBoxPro`
2. `cd BrowserBoxPro`
3. `./deploy-scripts/global_install.sh`
4. `setup_bbpro --port 8080` (this will run the main service on port 8080 and output the login link)
5. `bbpro`

Then, use the login link output in step 4 to connect to the virtual browser (from a regular mobile or desktop browser). 

ℹ️ You may observe some errors during the install! As long as everything runs, you can safely ignore those, because they're likely branches for different OSes. 

# System Requirements (recommended)

Debian VPS with 2 core, 4 GB RAM, and 100 GB SSD, and at least 10 Mbps connection, *plus a public hostname with a DNS A record pointing to the IP of your VPS, because we provision a TLS certificate for that hostname, and it forms part of the login link!*

Actual requirements depends on what you browse, but the above should give good performance on a range of real-world browsing tasks. If you need better performance, use better hardware.

To reduce any lag and increase framerate, locate the server as close to you as physically possible. The longer the link round-trip time, the more lag will be introduced: this is because remote browser isolation is essentially a real-time interactive video streaming application, so **RTT matters!**


