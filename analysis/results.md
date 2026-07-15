# Review & Download Results

## View Results

1. From the **Analysis Dashboard**, click an analysis with status **Complete**.

2. Double-click the row (or click **Results**) to open the **Sample Summary** — a high-level view of key results per sample.

3. From Sample Summary, click a sample row and then **Genotype Summary** (or double-click the row) to see per-gene genotype results filtered to a single sample and barcode. Clear the filters to view all entries.

4. From Genotype Summary, click a row and then **Variant Results** (or double-click) to see detailed variant-level data filtered for a single sample, barcode, and gene. Clear filters to view all entries.

5. From Variant Results, click a row and then **View Variant Figure** to open an interactive visualization for that gene in a new tab.

### Share Results

URLs for Sample Summary, Genotype Summary, and Variant Results are **permalinks** — they preserve the current filter state and are unique to each analysis and page. Share them directly with collaborators who have access to the Software.

---

## Download Results

1. From the Analysis Dashboard, select an analysis with status **Complete** and click **Download**.

2. Navigate the folder tree to find specific files. The folder structure mirrors the on-disk layout at:

   ```
   [User Data Path]\analyses\{Analysis Id}\results\
   ```

3. Click any file to open it in the browser or download it. Supported formats include `.png`, `.html`, `.csv`, `.json`, `.log`, `.txt`, and other common types.

### Access Results Outside the Software

Analysis results remain accessible on disk even after the Software is uninstalled. Navigate to:

```
[User Data Path]\analyses\{Analysis Id}\results\
```

---

## Output Structure

```
results/
├── analysis_results/
│   ├── genotypes_summary.csv     # Per-gene genotype summary for all samples
│   ├── sample_summary.csv        # Per-sample variant and QC summary
│   └── variants.csv              # All variants for all samples
├── figures/                      # Interactive (.html) and static (.png) visualizations
│   ├── mix_a/
│   │   ├── cftr_large_exon_deletion/
│   │   │   └── [sample]_BCXX_CFTR.{png,html}        # CFTR copy number signal
│   │   └── smn/
│   │       └── SMN_Fold_Change.{png,html}             # SMN1/2 copy number scatter plot
│   ├── mix_b/
│   │   └── fmr1/
│   │       ├── [sample]_BCXX_FMR1.{png,html}         # FMR1 allele waterfall plot
│   │       └── [sample]_BCXX_FMR1_signal.html         # CGG sizing histogram
│   ├── mix_c/
│   │   └── hba_cnv/
│   │       └── [sample]_BCXX_HBA.{png,html}          # HBA1/2 copy number signal
│   └── mix_d/
│       ├── cyp21a2_tnxb/
│       │   └── [sample]_BCXX_CYP21_TNXB.{png,html}  # CYP21A2-TNXB allele transcript map
│       ├── f8/
│       │   └── [sample]_BCXX_F8.{png,html}           # F8 inversion read depth bar chart
│       ├── gba/
│       │   └── [sample]_BCXX_GBA.html                # GBA1 allele transcript map
│       └── smn/
│           ├── [sample]_BCXX_SMN1.{png,html}         # SMN1 allele transcript map
│           └── [sample]_BCXX_SMN2.{png,html}         # SMN2 allele transcript map
├── inputs/
│   ├── [panel_config_name].json  # Panel filter configuration used
│   └── sample_sheet.txt          # Sample sheet used for this analysis
├── json/                         # JSON versions of analysis_results files (for UI/LIMS)
│   ├── genotypes_summary.json
│   ├── sample_summary.json
│   └── variants.json
├── logs/
│   ├── run.log                   # Summary log with start/end time and failures
│   ├── failed_processes_log.txt  # Failed pipeline processes and hashes
│   ├── errors/                   # Working directories for each failed process
│   └── pipeline_info/            # Nextflow execution trace, reports, and versions
├── quality_control/
│   ├── coverage.csv              # Per-amplicon read counts and statistics
│   ├── coverage.html             # Visual coverage report (per mix, per sample)
│   ├── quality_control.csv       # All QC measurements and flags
│   ├── quality_control_fail.csv  # Failing QC entries only
│   ├── quality_control_flagged.csv  # Flagged or failing QC entries only
│   └── sample_qc/
│       └── [sample]_BCXX_qc_ampl_plots.html  # Per-sample amplicon coverage bar chart
├── sample_files/
│   ├── bam/
│   │   ├── [sample]_BCXX.bam     # Aligned reads for genome browser review (e.g., IGV)
│   │   └── [sample]_BCXX.bam.bai
│   ├── variants_csv/
│   │   └── [sample]_BCXX_variants.csv
│   └── vcf/
│       └── [sample]_BCXX_variants.vcf
└── supplementary/
    ├── bam_files/                # BAMs with both analyzed and unanalyzed reads
    └── raw_variants.csv          # Unfiltered variants table
```

For detailed descriptions of each file's columns and contents, see [Results Description](../reference/results-description.md).

---

## Post-run Basecalling

If run data was generated with an older or incompatible MinKNOW version, rebasecall the raw data before analysis. See the Software Release Notes for specific basecaller model requirements for your pipeline version.

1. Follow MinKNOW's post-run basecalling guide. At step 4, create a new output folder at a **different directory level** from the original run — not nested inside it — so the rebasecalled dataset can be imported as a distinct dataset.

2. The default output subdirectory for rebasecalled `fastq.gz` files is `fastq_pass`. Confirm this matches the import pattern configured in your data source (see [Configure Data Sources](../configuration/data-sources.md)).

3. *(Optional)* Copy the original run's `report.json` file into the rebasecalled folder to enable MinKNOW compatibility checks. If omitted, the Software will show basecaller model warnings — these can be ignored when using post-run basecalled data.

4. Resume the [Analysis Workflow](workflow.md) and select **Import Dataset…** to import the rebasecalled dataset.
