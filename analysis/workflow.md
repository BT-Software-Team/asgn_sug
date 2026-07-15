# Analysis Workflow

This section walks through the full lifecycle of an analysis: creating it, configuring it, running it, and reviewing results.

---

## Step 1 — Create an Analysis

1. From the **Analysis Dashboard**, click **New Analysis**.

2. Enter a name in the **Analysis Id** field. The current pipeline version is shown.

   > **Naming rules:** Only letters, numbers, dashes (`-`), and underscores (`_`) are accepted. Spaces and special characters are not allowed.

3. In **Select Dataset**, choose an already-imported dataset or select **Import Dataset…** to bring in a new one.

   > **Important:** Ensure the sequencing run has fully completed before importing. Importing a run that is still in progress may result in missing FASTQ files, insufficient read depth, missing samples, QC flags, or analysis failures.

4. If importing a new dataset, a table of available datasets from all configured endpoints appears (see [Configure Data Sources](../configuration/data-sources.md)). Use the **Filters** and **Columns** buttons to locate a specific dataset.

   If you previously imported a dataset and have since added FASTQ files to that directory, re-importing will prompt you to overwrite the existing dataset. This will not affect any completed analyses.

   > **Dataset not visible?** See [Missing Datasets](../reference/troubleshooting.md#missing-datasets) in Troubleshooting.

5. Click **Create** to confirm. A MinKNOW warning about a missing `report.json` file does not prevent you from proceeding — see [MinKNOW Warnings](#minkow-warnings) for context.

---

## Step 2 — Configure the Analysis

A panel configuration and a sample sheet are required before analysis can begin.

1. From the Analysis Dashboard, double-click an analysis with status **New**, or select it and click **Load Analysis**.

2. Review any **MinKNOW Warnings** displayed at the top of the page (see [MinKNOW Warnings](#minknow-warnings) below).

3. Under **Assign a Panel Configuration**, select a configuration from the dropdown and click **Add Panel Configuration** to apply it.

4. Under **Import Sample Sheet**, click **Choose File**, select your `.txt` sample sheet, then click **ADD SAMPLESHEET**.

   The sample sheet will be validated automatically. Any errors are shown in the **Errors** column. Click the pencil icon in the **Actions** column to correct individual rows inline, or upload a corrected file and re-validate.

5. Once all errors are resolved, click **Analyze** to start the analysis.

### Sample Sheet Requirements

The sample sheet must be a tab-delimited `.txt` file with the following required headers (case-sensitive):

| Column | Description |
|--------|-------------|
| `SourceID` | Sample name |
| `BarcodeID` | Barcode in format `BCXX` (e.g., `BC01`) |
| `Mixes` | Letters for each Mix included (e.g., `abc` for Mix A, B, and C) |
| `Calibrators` | `n` for non-calibrators; `a`, `c`, or `ac` for calibrators |

Additional rules:
- Values may only contain letters, numbers, `-`, and `_`. Spaces and other whitespace are not accepted.
- Each `SourceID` + `BarcodeID` combination must be unique.
- For each `BarcodeID`, a matching `barcodeXX` folder must exist in the imported dataset directory.
- If Mix A or C is used, at least one calibrator sample must be designated for those mixes.

> **Default User Data Path is a hidden folder.** To view it in File Explorer on Windows, enable hidden files in View settings. Default path: `C:\ProgramData\asuragen\`

---

## MinKNOW Warnings

A warning in this section means that the run data may not be fully compatible with the selected analysis pipeline. Common causes include an unsupported MinKNOW version, basecaller model mismatch, barcode trimming settings, or an unvalidated barcode kit.

Warnings do not block analysis, but should be reviewed before proceeding. If the warning relates to a basecaller model or incompatible MinKNOW version, see [Post-run Basecalling](#post-run-basecalling).

---

## Step 3 — Monitor Execution

Navigate to the **Analysis Dashboard** and check the **Status** column. Refresh the page to see updates.

| Status | Meaning | What to do |
|--------|---------|------------|
| **Import Initializing** | Dataset is being transferred from the source endpoint | Wait |
| **Import Error** | Dataset did not import correctly | Verify `fastq.gz` files exist in `fastq_pass/barcodeXX` directories |
| **New** | Analysis created, data imported, ready to configure | Load Analysis, assign panel and sample sheet, then click Analyze |
| **In Queue** | Waiting for a previous analysis to complete | Wait — analyses run one at a time, in order |
| **Running** | Analysis is actively processing | Wait |
| **X processed of Y** | Analysis is progressing | Wait — the Y value increases as new tasks are discovered |
| **Error** | Analysis did not complete or was cancelled | See [Troubleshooting](../reference/troubleshooting.md); reload and retry |
| **Complete** | Analysis finished successfully | Review results or download files |

> **Analysis time** varies by number of samples, read depth, and available compute resources.

---

## Step 4 — Review Results

1. From the Analysis Dashboard, click an analysis with status **Complete**.

2. Double-click the row (or click **Results**) to open the **Sample Summary** — a high-level view of key results per sample.

3. From Sample Summary, click a sample row and then **Genotype Summary** to see per-gene genotype results filtered to a single sample.

4. From Genotype Summary, click a row and then **Variant Results** to see detailed variant-level data for a single sample, barcode, and gene. Clear the filters to view all entries.

5. From Variant Results, click a row and then **View Variant Figure** to open an interactive visualization for that gene.

### Sharing Results

URLs for Sample Summary, Genotype Summary, and Variant Results are **permalinks** — they preserve the current filter state and are unique to each analysis and page. Share them directly with collaborators who have access to the Software.

---

## Download Results

1. From the Analysis Dashboard, select an analysis with status **Complete** and click **Download**.

2. Navigate the folder tree to find specific files. Folders reflect the on-disk structure at:

   ```
   [User Data Path]\analyses\{Analysis Id}\results\
   ```

3. Click any file to open it in the browser or download it (`.png`, `.html`, `.csv`, `.json`, `.log`, `.txt`, and other common formats are supported).

### Output Structure

```
results/
├── analysis_results/
│   ├── genotypes_summary.csv     # Per-gene genotype summary for all samples
│   ├── sample_summary.csv        # Per-sample variant and QC summary
│   └── variants.csv              # All variants for all samples
├── figures/                      # Interactive (.html) and static (.png) visualizations
│   └── [samplename_BCXX]_*.html
├── inputs/                       # Copies of inputs used for the analysis
├── logs/                         # Pipeline execution logs
└── [samplename_BCXX]_VARIANTS.csv / .vcf   # Per-sample variant files
```

> Analysis results remain accessible on disk even after the Software is uninstalled. Find them at `[User Data Path]\analyses\{Analysis Id}\results\`.

---

## Post-run Basecalling

If your run data was generated with an older or incompatible MinKNOW version, you can rebasecall the raw data before analysis. See the Software Release Notes for specific basecaller model requirements for your pipeline version.
