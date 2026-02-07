# Newbie Guide: Building Zenith OS on Windows 11

Since you are using Windows 11, the easiest way to "cook" this OS is by using **WSL2 (Windows Subsystem for Linux)**. It allows you to run a Linux environment inside Windows.

### Step 1: Set up WSL2 (If you haven't already)
1. Open **PowerShell** as Administrator (Right-click Start -> Terminal Admin).
2. Type this command and press Enter:
   ```powershell
   wsl --install
   ```
3. Restart your computer if prompted.
4. Once restarted, a window will open to set up Ubuntu. Create a username and password.

### Step 2: Prepare the Build Environment
Inside your new Ubuntu terminal, run these commands to install the tools needed:
```bash
sudo apt update
sudo apt install -y docker.io
sudo usermod -aG docker $USER
```
*Note: You may need to restart the terminal for the docker command to work without 'sudo'.*

### Step 3: Get the Zenith OS Files
You need to copy the files I created for you. You can create a folder on your Windows Desktop named `zenith-build` and I will provide a way to get the files there.
On Windows, your C: drive is located at `/mnt/c/` in Linux.
```bash
mkdir -p /mnt/c/zenith-build
```

### Step 4: Run the "Chef" Script
I have created a script that does all the hard work for you. It uses a "Docker" container (a mini virtual computer) to build the ISO so you don't have to install Arch Linux yourself.

Save this script as `build_zenith.sh` in your folder and run it:
```bash
# Inside the Ubuntu terminal
cd /mnt/c/zenith-build
# (I will provide the content of this script in the next message)
bash build_zenith.sh
```

### Step 5: Flash to USB
Once the script finishes, you will see a file named `zenith-os-x86_64.iso` in your folder.
1. Download **BalenaEtcher** (https://www.balena.io/etcher/).
2. Plug in a USB stick (at least 4GB). **Warning: This will erase the USB!**
3. Select the `zenith-os` file, select your USB, and click **Flash!**

### Step 6: Boot Zenith OS
1. Keep the USB plugged in and restart your laptop.
2. Press your laptop's "Boot Menu" key (usually **F12, F11, F10, or Esc**) as soon as the screen turns on.
3. Select your USB stick.
4. Welcome to Zenith OS!

---
**Would you like me to provide the "Chef" script now to start the build?**
