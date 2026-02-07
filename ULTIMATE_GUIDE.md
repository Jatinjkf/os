# The Ultimate Newbie Guide to Zenith OS

This guide will take you from Windows 11 to having your own custom, high-performance Zenith OS.

---

## Phase 1: Set Up Your "Kitchen" (Windows 11)

To build a Linux OS, we need a small Linux corner inside Windows.

1.  **Enable WSL2:**
    *   Right-click your **Start Button** and select **Terminal (Admin)**.
    *   Type: `wsl --install` and press Enter.
    *   **Restart your computer.** After restarting, a black window (Ubuntu) will open. Follow the prompts to create a username and password.

2.  **Install Docker Desktop:**
    *   Go to [Docker Desktop](https://www.docker.com/products/docker-desktop/) and download/install it for Windows.
    *   **Open Docker Desktop** and make sure the little whale icon in your system tray (bottom right) is steady.
    *   In Docker Desktop Settings -> Resources -> WSL Integration, make sure "Ubuntu" is toggled **ON**.

---

## Phase 2: Create the Files

1.  **Open Ubuntu:** (Search for "Ubuntu" in your Windows Start menu).
2.  **Create a folder:** Type these commands one by one:
    ```bash
    mkdir -p ~/zenith-build
    cd ~/zenith-build
    ```
3.  **Download/Copy the Recipe:**
    I have provided the files in this chat. You need to create the files exactly as I've shown.
    *(Tip: You can access your Ubuntu files from Windows Explorer by typing `\\wsl$\Ubuntu\home\YOURNAME\zenith-build` in the address bar).*

---

## Phase 3: Build the ISO

This is where the magic happens. We will use the "Chef" script to cook the ISO.

1.  **Run the builder:**
    In your Ubuntu terminal, run:
    ```bash
    bash build_zenith.sh
    ```
2.  **Wait:** It will download the Arch Linux base and all your apps (WhatsApp, Obsidian, etc.). This takes about 10-20 minutes.
3.  **Result:** When it says "SUCCESS!", you will have a file named `zenith-os-x86_64.iso` in the `out` folder.

---

## Phase 4: Flash to USB

Now you need to put that file onto a USB stick so your laptop can boot from it.

1.  **Get Etcher:** Download [BalenaEtcher](https://www.balena.io/etcher/).
2.  **Prepare USB:** Plug in a USB stick (8GB+). **Warning: Everything on the USB will be deleted.**
3.  **Flash:**
    *   Select **Flash from file** and pick your new `.iso`.
    *   Select your **USB Drive**.
    *   Click **Flash!**.

---

## Phase 5: Run & Install

### Running "Live" (Safe Mode)
This lets you try the OS without changing anything on your hard drive.
1.  Plug the USB into the laptop you want to use.
2.  Turn on the laptop and immediately tap the **Boot Menu Key** (usually F12, F11, or Esc).
3.  Select your USB stick.
4.  Zenith OS will load! It will auto-login.
    *   `Super+Space` opens the app search.
    *   `Super+W` opens WhatsApp.
    *   `Super+L` opens PW Live.

### Installing (Permanent)
If you love it and want it as your main OS:
1.  While running Zenith OS from the USB, press `Super+Space`.
2.  Type "Install" and click **Install Zenith OS**.
3.  A terminal will open with **Archinstall**.
    *   Follow the prompts (choose your language, keyboard, and drive).
    *   **Warning:** Selecting "Wipe all drives" will delete Windows 11. If you want to keep Windows, choose "Dual Boot" or "Manual Partitioning" (Expert level).
4.  Once it finishes, unplug the USB and restart.

---

## Essential Shortcuts for Beginners
*   **Super Key:** This is the "Windows" key on your keyboard.
*   **Super + Space:** Open App Menu (Search for apps).
*   **Super + Q:** Open Terminal (The command line).
*   **Super + E:** Open File Manager (To see your files).
*   **Super + C:** Close the current window.
*   **Super + W / L / N:** WhatsApp / PW Live / OneNote.
*   **Super + 1, 2, 3:** Switch between different screens (Workspaces).
