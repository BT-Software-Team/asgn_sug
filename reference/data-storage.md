# Data Storage & Archival

---

## Storage Requirements

A single 96-sample run can require substantial storage depending on which Mixes were run. The work directory is automatically removed after analysis completes to free space; the analysis results are retained.

| Samples | Mix | POD5s | FASTQs | Analysis Results | Work Directory | Total |
|:-------:|:---:|------:|-------:|-----------------:|---------------:|------:|
| 96 | A | 135 GB | 20 GB | 25 GB | 275 GB | 455 GB |
| 96 | B | 25 GB | 5 GB | 1 GB | 10 GB | 40 GB |
| 96 | C | 40 GB | 5 GB | 10 GB | 110 GB | 165 GB |
| 96 | D | 90 GB | 15 GB | 25 GB | 210 GB | 350 GB |

Per-mix storage requirements are **additive** for multi-Mix analyses. Transfer raw and processed data to external storage regularly to avoid drive issues that could cause sequencing or analysis failures.

---

## Archive Sequencing Runs (MinKNOW)

1. Locate the run folders in `C:\data\` (the default MinKNOW output location). Each run has a dedicated folder named after the Experiment Name used when starting sequencing.

2. Move the entire folder from `C:\data\` to external or network storage.

3. The run will no longer appear in the Software's dataset import list.

**To restore a sequencing run:** Move or copy the folder back to `C:\data\`. Alternatively, add a remote data source pointing to the archived location — see [Configure Data Sources](../configuration/data-sources.md#add-a-remote-data-source).

---

## Archive Analysis Data

1. Move analysis folders from `[User Data Path]\analyses` to another location. You can move all Analysis IDs or a subset.

2. *(Optional)* Delete the analysis from the UI using the **Delete** button on the Analysis Dashboard. The analysis will no longer appear in the Software.

> **Important:** Once an analysis is deleted from the UI, there is no way to make it visible again in the interface. The archived result files remain accessible on disk and can be reviewed directly in File Explorer.

---

## Delete Imported Dataset Copies

When an analysis is created, the dataset is copied to the computer (under `[User Data Path]\datasets`). This can cause unnecessary duplication if the original data is still accessible elsewhere.

To delete imported datasets that are no longer needed:

1. Delete the relevant run folders from `[User Data Path]\datasets`.
2. To run another analysis on the same dataset, re-import it within the Software.

> A dataset does not need to be restored to view previously completed analysis results, but must be imported again before running a new analysis on that dataset.

---

## Backup & Restore Application Data

### Linux (Ubuntu 22.04)

When the Software is uninstalled:
- Analyses and their statuses are archived as a Docker volume at `/var/lib/docker/volumes/file_interface_vol`.
- Result files are preserved at `/var/lib/asuragen/analyses`.

When the Software is reinstalled on the same computer, it checks for the Docker volume and restores the database automatically. Existing analyses will appear on the Analysis Dashboard.

> **Do not** delete `/var/lib/docker/volumes/file_interface_vol` or run `apt purge` on Docker if you intend to restore the database later. If the analyses at `/var/lib/asuragen/analyses` are moved or deleted, they will not appear in the Software even if database restoration succeeds.

### Windows 11

When the Software is uninstalled:
- Analyses and their statuses are saved as a SQL dump backup file at `C:\ProgramData\asuragen`.
- Result files are preserved at `C:\ProgramData\asuragen\analyses`.

When the Software is reinstalled on the same computer, it checks for the SQL dump file, restores the database, deletes the backup file, and the existing analyses appear on the Analysis Dashboard.

> The SQL dump file must be located at `C:\ProgramData\asuragen` for restoration to work. If the analyses at `C:\ProgramData\asuragen\analyses` are moved or deleted, they will not appear in the Software even if database restoration succeeds.
