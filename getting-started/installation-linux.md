# Installation on Ubuntu 22.04 Linux

Ubuntu 22.04 is the recommended operating system for optimal performance.

**Time required:** 10–15 minutes, plus background Docker image downloads (time varies by internet speed)

## Prerequisites

Before you begin:

- Ubuntu 22.04 Linux system with administrator privileges
- Internet access (see [Network Requirements](system-requirements.md#network-requirements))
- Ports `80`, `3500`, `5123`, `8100`, `8101`, `8103`, `8104`, and `9000` available
- Google Chrome® or Microsoft Edge®

The installer automatically handles the following dependencies: Docker CE, OpenJDK 17 JRE (headless), nginx, apt-transport-https, ca-certificates, and software-properties-common.

---

## User Access Recommendations

The Software must be installed with a Linux user account that has administrator privileges (`sudo`). It is recommended to always run the Software using the same account used for installation, as the installer may configure user-specific environment settings and file permissions.

> **Remote access note:** Remote access is enabled during installation by default, but the Software does not provide authentication or authorization controls. Secure remote access using a firewall or network access control. See [Set Up Remote Access](../configuration/data-sources.md#remote-access).

---

## Install the Software

1. Download the installation script (`asgn_onereporter_installer_linux.sh`) from [myAsuragen](https://asuragen.com/myasuragen) and copy it to your home directory.

2. Open a terminal (`Ctrl+Alt+T`).

3. Make the script executable:

   ```bash
   sudo chmod +x asgn_onereporter_installer_linux.sh
   ```

4. Run the installer:

   ```bash
   sudo ./asgn_onereporter_installer_linux.sh
   ```

5. **Wait for Docker images to finish downloading.** Installation completes before the Docker images finish. Monitor progress:

   ```bash
   tail -f /var/log/asgn-carrier-plus-images.log
   ```

   When all images have downloaded, the log will read `Docker image pull completed` and a confirmation file will be created at `/var/log/.carrier-plus-images-ready`.

6. Verify the installation by opening your browser and navigating to:

   ```
   http://localhost:9000
   ```

   If installation was successful, the **About** button will display the installed components and version.

---

## Updating the Software

Run the same installation script to check for and apply updates.

1. Navigate to the folder containing the installation script.

2. Open a terminal (`Ctrl+Alt+T`).

3. Run the script:

   ```bash
   sudo ./asgn_onereporter_installer_linux.sh
   ```

4. When prompted `Would you like to check for updates and install?`, type `y` and press **Enter**.

---

## Supporting Files

The following additional files are available on the [myAsuragen Customer Portal](https://asuragen.com/myasuragen):

- Amplicon coordinates (`.bed` format)
- Supplementary genome FASTA file (non-GRCh38 reference sequences for F8 inversions and T2T HBA1/2 region)
- Panel configurations for common use cases
- Paralogous-sequence variant (PSV) lists
- ClinVar annotation CSV with cDNA representations
