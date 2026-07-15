# Installation on Windows 11

## Prerequisites

- Windows 11 Pro or Enterprise
- An administrator account (the active logged-in account must itself have admin rights — running the installer as a different user with elevated privileges is not supported)
- Internet access (see [Network Requirements](system-requirements.md#network-requirements))
- Google Chrome® or Microsoft Edge®

---

## Step 1 — Set Up Windows Subsystem for Linux (WSL)

WSL is a required prerequisite. These steps make changes to the operating system and require administrator privileges. If you are unfamiliar with Windows system configuration, consult your IT department before proceeding.

1. Press **Windows + R**, type `optionalfeatures.exe`, and press **Enter**.

2. In the Windows Features dialog, enable the following, then click **OK**:
   - Hyper-V
   - Virtual Machine Platform
   - Windows Subsystem for Linux

3. Restart the computer.

4. After restarting, open **Command Prompt as Administrator** (Start → search "Command Prompt" → **Run as administrator**).

5. Run the following two commands:

   ```cmd
   wsl --update
   wsl --install --no-distribution
   ```

6. Restart the computer again to finalize WSL setup.

---

## Step 2 — Install AmplideX One Reporter

Download the installer from [myAsuragen](https://asuragen.com/myasuragen).

1. Copy the installer file to your target PC.

2. Right-click the installer and choose **Run as Administrator**. Click **Yes** when prompted.

3. Click **Install Software**.

4. Review or change the installation paths:
   - **Application Installation Path** — where the software is installed
   - **User Data Path** — where results and datasets are stored

5. Select the Software Release Configuration (version) to install.

6. Choose whether to enable **Remote Access** (disabled by default). If disabled, only users logged into the host computer can access the Software.

7. Accept the End User License Agreement (EULA) and click **Confirm and Install**.

8. The installer will download the WSL environment and required Docker images. Progress is shown in the live output log. You can save this log using **Download Log**.

9. **Wait for Docker images to finish downloading.** The installer may show "Installation Complete" before all Docker images have finished. Monitor progress at:

   ```
   C:\Program Files\asuragen\carrier-plus-images.log
   ```

   When finished, the log will read `Docker image pull completed` and the file `C:\Program Files\asuragen\.carrier-plus-images-ready` will be created.

   > **Installer fails with a WSL error?** Return to Step 1 and confirm you ran both `wsl --update` and `wsl --install --no-distribution` before retrying.

   > **Credential prompt:** The installer needs your Windows account credentials to create a Scheduled Task that starts the Software on boot. These credentials are managed by Windows and are never stored by the Software.

10. Click **OK** when the installer shows "Installation Complete".

11. **Restart the computer.** This is required so Windows can allocate computational resources for WSL. Skipping this step may cause analyses to fail.

12. Verify the installation by opening your browser and navigating to:

    ```
    http://localhost:9000
    ```

    The **About** button will display the installed components if installation was successful.

---

## Updating the Software

The installer supports updating the platform and analysis pipeline independently — no full reinstall is needed.

To update:

1. Re-download the installer from [myAsuragen](https://asuragen.com/myasuragen).
2. Open the installer and select **Update Platform**.
3. Once complete, reopen the installer and select **Update Analysis Pipeline**.

Updating platform components before the pipeline ensures all required dependencies are in place.

> See the [Software Release Notes](https://asuragen.com/myasuragen) (doc 00003933) for details on what changed in each release.

---

## Multi-User Access on Windows

The Software relies on WSL, which is tied to a specific Windows user account. The administrator account used for installation must be actively logged in for the Software to be accessible over the network. After a computer restart, that account must re-authenticate before the Software becomes available to other users on the network.

For this reason, it is recommended to use the administrator account for routine operation of the Software.
