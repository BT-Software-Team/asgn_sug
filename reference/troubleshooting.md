# Troubleshooting

---

## Software Won't Start After Restarting (Windows)

The Software runs inside WSL and is started automatically via a Windows Scheduled Task. If it doesn't start after a restart:

### Start the Scheduled Task

1. Open **Task Scheduler** (Start → search "Task Scheduler" → **Run as administrator**).
2. Click **Task Scheduler Library** and locate the task named **AmplideX One Reporter (WSL)**.
3. Right-click the task and click **Run**.
4. In the Actions pane, click **Refresh** and confirm the status changes to **Running**.

If the status remains **Ready**, the task failed — continue to the next section.

### Modify the Scheduled Task

Windows may be blocking WSL from running on behalf of another user. To fix this, update the task to run under the Administrators group:

1. Open Task Scheduler and locate **AmplideX One Reporter (WSL)**.
2. Right-click the task → **Properties**.
3. On the **General** tab, click **Change User or Group…**
4. Type `Administrators` in the text box and click **Check Names**. The computer name will be prepended (e.g., `COMPUTERNAME\Administrators`). Click **OK**.
5. Confirm `BUILTIN\Administrators` now appears in Security options, and that **Run with highest privileges** is checked.
6. Click **OK** to save.
7. Right-click the task → **Run** → **Refresh** and confirm the status is **Running**.

> **Note:** Only administrator accounts can operate the Software when the task is configured this way.

If the Software still does not start, contact Asuragen Technical Support.

---

## Investigating a Failed Installation

### Verify System Requirements

**Confirm your OS version:**

Ubuntu 22.04:
```bash
cat /etc/os-release
```

Windows 11: Start → Settings → System → About → Windows specifications.

**Confirm network access:** Verify that outbound HTTPS (TCP port 443) is permitted to all required endpoints. See [System Requirements](../getting-started/system-requirements.md#network-requirements).

**Confirm hardware:** Review the minimum hardware specifications in [System Requirements](../getting-started/system-requirements.md).

**Windows-specific — WSL install error:** If the installer fails with a WSL error, return to [Step 1 of Windows Installation](../getting-started/installation-windows.md) and confirm both `wsl --update` and `wsl --install --no-distribution` were run before retrying.

---

## Investigating Failed Analyses

### Verify Analysis Prerequisites

1. **Docker images not fully downloaded:** If a new Mix is analyzed and fails, check `C:\Program Files\asuragen\carrier-plus-images.log` for `Docker image pull completed successfully`. If missing, confirm internet connectivity, restart the computer, and re-run within 24 hours.
2. **Firewall or network restrictions:** Review [System Requirements](../getting-started/system-requirements.md#network-requirements).
3. **Analysis metadata:** Review the Analysis Configuration page to confirm all calibrators and Mixes are correctly configured.

### Diagnose the Failure

1. Open the failed processes log:
   ```
   [User Data Path]\analyses\{Analysis Id}\results\logs\failed_processes_log.txt
   ```
   The file shows `No failed processes.` if none occurred, or lists failed process names and their hash identifiers.

2. For each failed process, locate its directory in `logs/errors/` using the hash.

3. Open `.command.err` in a text editor to inspect the error. This file can also be sent to Asuragen Technical Support.

4. If the process `COMBINEDEMUXFILES` failed, there is likely an error with the input dataset or sample sheet.

5. Also review the process log for error messages near the bottom:
   ```
   [User Data Path]\analyses\{Analysis Id}\results\logs\process.log
   ```

### Investigating Blank Results Pages

If results pages appear blank after analysis completes:

1. Check `failed_processes_log.txt` (see above) for failed processes.
2. Review the QC failure file:
   ```
   [User Data Path]\analyses\{Analysis Id}\results\quality_control\quality_control_fail.csv
   ```
3. If all samples are present for each selected Mix, the input FASTQ files likely have few or no reads.

---

## Troubleshooting by Observation

| Observation | Potential Cause | Action |
|-------------|----------------|--------|
| **Calibrator-specific low coverage (CalLowCov)** | Wrong calibrator input volume or mass; wrong sample marked as calibrator; incorrect pooling of calibrator PCR product | Add calibrator at recommended input volume; update sample sheet with correctly marked calibrators; repeat analysis |
| **Incompatible calibrator genotype (CalGT)** | Incompatible user-provided calibrator | Use known normal (2-copy) samples in conjunction with the kit calibrator. Mark additional calibrators in the sample sheet. |
| **Expected QC Fail not observed for NTC** | Sample contamination; reuse of flow cell with same barcode/mix combination | Check NTC fully spanning read depth (should be <100 FSRs or >1000-fold below sample median); apply library to a new/unused flow cell; repeat gene-specific PCR with fresh reagents |
| **Amplicon-level LowCov flag** | Evaporation during PCR from improper plate sealing; insufficient sample quantity/quality; unsupported sample type; under-sequencing | Verify plate sealing and well volumes; confirm sample quantity/quality per Protocol Guide; check Estimated Gb Target in sequencing settings |
| **Sample-level QC fail from low coverage** | Mass calculation errors leading to pooling imbalance; insufficient sample quantity/quality; reads just below QC cutoffs | Use Bench Workbook for calculations; check barcode PCR plate volumes; repeat sequencing with increased Gb target |
| **LowConfidence or FC QC flags** | Insufficient sample quantity/quality; unsupported sample type | Repeat sequencing; if persistent, repeat sample prep from gene-specific PCR; if common across an isolation batch, consider user-defined calibrators |
| **Uneven read distribution across samples** | Qubit measurement error; manual pooling calculation error; expanded Mix B samples; poor PCR amplification | Repeat Qubit measurements; use Bench Workbook for pooling; dilute samples with Pooled Sample Mass Ratio >1.2 before within-mix pooling |
| **High frequency of LowCov in one or more Mixes** | Pooling errors; Qubit errors; insufficient Gb target; under-sequencing | Repeat Qubit measurements; use Bench Workbook; increase Gb target; repeat BC-PCR for under-represented samples |
| **"Alpha cluster duplication" reported erroneously** | Sample contamination; flow cell reuse with same barcode/mix | Apply library to a new or unused flow cell; repeat gene-specific PCR with fresh reagents |
| **Super accurate basecalling / barcode trimming warning** | Sequencing did not use required basecalling settings | Repeat basecalling with correct settings per Protocol Guide |

---

## Missing Datasets {#missing-datasets}

**Dataset doesn't appear when importing:**

- GridION users: check that MinKNOW's built-in firewall is **off** (when enabled, it may block dataset imports).
- Verify the data source configuration is correct, especially the Run Data Path and import patterns.

**Dataset was imported but doesn't appear in Select Dataset dropdown:**

Confirm the dataset was successfully copied to the managed storage location:

- Linux: `/var/lib/asuragen/datasets`
- Windows: `[User Data Path]\datasets` (default: `C:\ProgramData\asuragen\datasets`)

---

## Uninstalling the Software

### Ubuntu 22.04 Linux

```bash
sudo chmod +x /usr/local/bin/asuragen/asgn_onereporter_uninstaller_linux.sh
sudo /usr/local/bin/asuragen/asgn_onereporter_uninstaller_linux.sh
```

### Windows 11

1. Open the installation directory (`C:\Program Files\asuragen` by default) in File Explorer.
2. Right-click `amplidex_one_reporter_uninstaller.exe` → **Run as administrator**.
3. The uninstaller removes all application files, undoes system configurations, and deletes the WSL environment.
4. When prompted, choose whether to delete or keep the uninstaller file.
5. Press any key to close when complete.

> **Analysis data is preserved.** Results and imported datasets remain at `[User Data Path]` (`C:\ProgramData\asuragen` by default) after uninstallation. See [Data Storage & Archival](data-storage.md) for managing this data.
