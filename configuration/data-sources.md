# Configure Data Sources

A **data source** defines a path or endpoint where sequencing run data is stored and accessible by the Software.

A default data source is created during installation pointing to where MinKNOW stores run data:

| OS | Default path |
|----|-------------|
| Linux | `/var/lib/minknow/data` |
| Windows | `C:\data` (stored internally as `/mnt/c/data`) |

Additional data sources can be added for networked devices (e.g., a GridION, another sequencing workstation, or a remote fileserver) using SSH on port 22. All configured data sources appear as options when setting up a new analysis.

After a dataset is imported, it is copied to a managed location:

| OS | Imported dataset path |
|----|----------------------|
| Linux | `/var/lib/asuragen/datasets` |
| Windows | `[User Data Path]\datasets` (default: `C:\ProgramData\asuragen\datasets`) |

---

## Add a Local Data Source

1. Click **Settings** in the navigation bar.

2. Under **Data Sources**, click **Create**.

3. Fill in the following fields:

   | Field | Description | Required |
   |-------|-------------|----------|
   | **Endpoint Name** | Unique display name for this data source | ✅ |
   | **Endpoint Type** | Choose `Local Computer` | ✅ |
   | **Run Data Path** | Path to the folder containing sequencing runs (Linux-style) | ✅ |
   | **Import Patterns** | RegEx patterns that identify run files (defaults work for most users) | ✅ |
   | **Exclude Folders** | Folder names to hide from the import list | Optional |

   **Converting Windows paths to Linux-style:**

   | Windows path | Linux-style equivalent |
   |-------------|----------------------|
   | `C:\Archive\Nanopore\runs` | `/mnt/c/archive/nanopore/runs` |
   | `D:\data` | `/mnt/d/data` |

   **Default import patterns:**

   ```
   .*fastq_pass/.*\.gz$           # Compressed FASTQ files inside fastq_pass/
   .*report_.*\.(html|json)$      # MinKNOW report files
   ```

   To create a custom import pattern, identify the actual file path in a completed run and translate it to a RegEx. For example:

   ```
   .*output/reads/.*\.fastq\.gz$      # Custom compressed FASTQ location
   .*reports/.*\.(html|json)$         # Custom report location
   ```

   Use `.*` for variable path segments, escape periods as `\.`, and end patterns with `$` to avoid partial matches.

4. Click **Next** to preview the data source contents. Verify expected folders appear before saving.

5. Click **Save**. The new data source will appear in the **Select a data source** dropdown.

> **Runs not showing up?** Double-check the Run Data Path and Import Patterns — a misconfiguration is the most common cause.

---

## Add a Remote Data Source (SSH/SFTP)

Use this method to connect to a GridION device, another sequencing workstation, or a network file server.

> **Requirement:** SSH access on port 22 (enabled by default on GridION).

1. Click **Settings** in the navigation bar.

2. Under **Data Sources**, click **Create**.

3. Set **Endpoint Type** to `Remote (SFTP)` and fill in:

   | Field | Description |
   |-------|-------------|
   | **Endpoint Name** | Unique display name |
   | **Host Name** | IP address or hostname of the remote computer |
   | **User Name** | SSH username |
   | **Password** | Password for the SSH user |
   | **Run Data Path** | Full path to the run data folder on the remote machine |
   | **Import Patterns** | Same as local — see above |
   | **Exclude Folders** | Optional |

   > **Use a local system account** (not a personal or domain account) for the SSH credentials. This prevents access interruptions caused by password changes or account deactivation.

   **Run data on a non-C drive (Windows remote)?** Create a symlink on the remote machine first:

   ```cmd
   mklink /D C:\sftp\data D:\data
   ```

   Then enter `/sftp/data` as the Run Data Path in the Software. The symlink resolves to `D:\data` transparently — no data is moved.

4. Click **Next** to preview the top-level directories. Confirm expected folders are visible.

5. Click **Save**.

---

## Modify a Data Source

Use this when sequencing data has moved to a different path, or when SSH credentials change.

> **Credential changes:** If the account configured for a data source is disabled, sequencing runs at that endpoint will disappear from the import list. Update the data source with a working account to restore access.

1. Click **Settings** → select the data source from the dropdown → click **Change**.
2. Update the relevant fields using the same instructions above.

---

## Remove a Data Source

1. Click **Settings** → select the data source from the dropdown → click **Remove**.
2. Confirm by clicking **Remove** again in the confirmation dialog.

---

## Set Up Remote Access

Remote access controls whether other computers on the network can connect to the Software.

> **Security note:** The Software does not include authentication or authorization controls. Secure remote access with a firewall or network access controls before enabling.

1. Click **Settings** in the navigation bar.
2. Under **System Configuration**, your current remote access status is shown.
   - **Allow Remote Access** — enables access from other computers on the local network
   - **Restrict Remote Access** — limits access to the local machine only

The service restarts automatically when access settings change.
