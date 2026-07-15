# Results Description

This section explains how to interpret analysis results. Once an analysis reaches **Complete** status, a `results/` directory is available containing all outputs. See [Review & Download Results](../analysis/results.md) for how to access them.

---

## Overview

The primary results are annotated variant calls in `.csv` and `.vcf` format ([Variants](#variants)). These are summarized into per-gene genotypes ([Genotypes Summary](#genotypes-summary)) and then into a per-sample overview ([Sample Summary](#sample-summary)). Both summaries include QC flags and are reported in `.csv` format.

For QC details see [Quality Control](#quality-control). For variant type–specific methods see [Variant Classes](#variant-classes).

---

## Sample Summary

The highest-level overview of variants per sample. Only variants that pass the **Summarize** filter criteria appear here (see [Panel Filter Configurations](../configuration/panel-filters.md)). Gene entries also apply additional gene-specific rules (Table 4 in the source guide).

**Access**
- UI: Analysis Dashboard → Complete analysis → Results
- File: `[Analysis Id]/results/analysis_results/sample_summary.csv`

### Columns

| Column | Description |
|--------|-------------|
| **Sample_Name** | User-provided sample name |
| **QC** | QC flags per Mix. `PASS` if all Mixes pass; `FLAG(Mix)` or `FAIL(Mix)` if a Mix has issues; combinations separated by `;`. See [Quality Control](#quality-control). |
| **Genes\[Status\]** | High-level genotype overview. Copy-number genes (HBA1/2, SMN1/2, GBA1, CYP21A2, TNXB) show copy count + `cp`. Variant counts use the symbols in the table below. Phase shown as `(1\|0)` / `(0\|1)`; homozygous as `(H)`. No variants → `No Variants`. |
| **Barcode** | Barcode applied to the sample |
| **Mixes** | Mixes analyzed for the sample |
| **Calibrator** | Mixes the sample was used as calibrator for. `N` if not a calibrator. |

### Variant Symbols in Genes\[Status\]

| Symbol | Variant Type | Genes | Notes |
|--------|-------------|-------|-------|
| V | SNV/Indel | All except FMR1 | |
| SV | Structural Variant (fusions, inversions, large del/ins >50 bp) | All except FMR1 | |
| LV | Linked Variant | SMN1/2 | `c.*3+80 T>G`, `c.*211_*212del` linked to the cis-silent (2+0) carrier haplotype. SMN2 modifier `c.859G>C` is reported as V. |
| PM | Premutation | FMR1 | 55–200 CGG repeats |
| FM | Full Mutation | FMR1 | >200 CGG repeats |

### Which Variants Appear in Sample Summary (by Gene)

| Gene | Variants Represented |
|------|---------------------|
| CFTR | Any Summarized variants; any SVs |
| SMN1 | Any Summarized variants; copy number <2; linked variants (Summarized by default) |
| SMN2 | Mix A: copy number + Summarized variants reported only if SMN1 is also reported. Mix D: not reported. Disease modifier `c.859G>C` Summarized by default. |
| FMR1 | Premutations (PM) and full mutations (FM) only |
| HBB | Any Summarized variants; any SVs; copy number <2 |
| HBA | Any alpha-cluster genotypes affecting HBA_Rgn01–14, or HS-40 deletions affecting HBA_Rgn01/02 |
| HBA1/2 | Any Summarized variants; any SVs; both reported if either copy number <2; `HBA1 [2 cp] / HBA2 [2 cp]` shown for silent carriers with concomitant duplication + deletion |
| CYP21A2/A1P | Any Summarized variants; any SVs; copy number <2 |
| GBA1/P | Any Summarized variants; any SVs; copy number <2 |
| TNXA/B | Any Summarized variants; any SVs; copy number <2 |
| F8 | Any Summarized variants; any SVs; all inversions |

---

## Genotypes Summary

Translates variants into genotypes for each gene target. Like Sample Summary, only Summarized variants are included. All samples have an entry for every summarized gene.

**Access**
- UI: Analysis Dashboard → Complete analysis → Results → double-click a sample row
- File: `[Analysis Id]/results/analysis_results/genotypes_summary.csv`

### Columns

| Column | Description |
|--------|-------------|
| **SampleID** | Sample_Name concatenated with Barcode — unique sample identifier |
| **Sample_Name** | User-provided sample name |
| **Barcode** | Barcode applied to the sample |
| **Mix** | Mix the gene target is in |
| **Calibrator** | Calibrator Mixes for this sample; `N` if not a calibrator |
| **QC** | Per-gene QC flags. `PASS` if all pass; `FLAG (ID)` for a single flag; `FLAG (Multiple)` for multiple; `FAIL (Mix)` for Mix-level QC failure (Genotype and Summary columns also show FAIL). For SMN1/2 analyzed in Mixes A and D, Mix A status appears first. If an HBA endogenous control–affecting genotype is detected without other coverage/model/calibrator flags, shows `PASS(CNV_Warn)`. |
| **Gene** | Gene of interest |
| **Summary** | High-level genotype overview; same nomenclature as `Genes[Status]` in Sample Summary. Gene copy number is always reported here. SMN2 is always reported when summarized. |
| **Genotype** | Detailed gene-specific genotype. See gene-specific rules below. |

### Gene-Specific Genotype Rules

**CFTR:** SNV/Indels and within-amplicon SVs shown in brackets after the amplicon name, with pathogenicity if available. Two-amplicon deletions shown as `dele[exons]`; longer or complex deletions as `ExonDeletionOther`. Variants on different alleles within the same amplicon separated by `|` (phased) or marked `unphased`. 5T alleles in the Poly-T/TG region listed with ClinVar annotation. `No Variants` if none found.

**SMN1/2:** Variants shown in brackets after the amplicon name. Phased variants separated by `|`; unphased marked `unphased`. Mix A: `DELETION` or `DUPLICATION` shown for copy number changes. Mix D: copy number not reported; only phased variants. Mix A+D: copy number from Mix A; Mix D variants reported if found in both Mixes.

**FMR1:** Each allele's CGG size shown with AGG interrupts. Expansion status: Normal (5–44), Intermediate (45–54), Premutation / PM (55–200), Full Mutation / FM (>200). Relative allele abundance shown as 0–1 (most abundant normalized to 1). Unsized full mutations shown as `(>200CGG[noAGG], Full_Mutation) (nan)`.

**HBA1/2:** Two copies of HBA1 and HBA2 always individually listed. Deletions/duplications shown with `DELETION` or `DUPLICATION`; canonical SV names shown (e.g., `3.7del`) when applicable.

**HBB:** SNV/Indels and SVs in brackets after the amplicon name. Phased variants separated by `|`; unphased marked `unphased`.

**CYP21A2/A1P and TNXB/A:** All copies individually listed; gene assignment based on majority-rule PSVs. SNV/Indels and within-amplicon SVs in brackets after the gene name. Fusion subtypes shown when matched; PSVs shown as microconversions when pattern doesn't match a known subtype.

**GBA1/P1:** All copies individually listed. SNV/Indels and SVs in brackets. `Fusion` shown next to any allele with detected PSVs.

**F8:** Intron 01 and intron 22 inversions, SNV/Indels, and within-amplicon SVs in brackets after the amplicon name. Inversions labeled `INVERSION, Pathogenic`. Phased variants listed sequentially; variants on different copies separated by `|`; unphased variants labeled `unphased`.

---

## Variants

Detailed entries for each identified variant. The **Analyze** filter setting determines which variants appear (see [Panel Filter Configurations](../configuration/panel-filters.md)). Available in `.csv` and `.vcf` format.

### Variants (.csv)

Each row represents one variant.

**Access**
- UI: Analysis Dashboard → Complete analysis → Results → Sample Summary → Genotypes Summary
- File: `[Analysis Id]/results/analysis_results/variants.csv`

| Column | Default View | Description |
|--------|:---:|-------------|
| SampleID | No | Sample_Name + Barcode |
| Sample_Name | Yes | User-provided name |
| Barcode | Yes | Barcode applied to the sample |
| Mix | No | Mix the variant is in |
| QC | Yes | QC flags for this variant. Multiple flags separated by `;`. See [Quality Control](#quality-control). |
| Gene | Yes | Gene the variant is in. Overlapping transcripts show concatenated name (e.g., `CYP21A2_TNXB`). `HBA` for alpha-globin cluster amplicons that are not HBA1 or HBA2. |
| Variant | Yes | Variant call. cDNA change (HGVS) for SNVs/Indels; SV subtype for structural variants; CGG/AGG for FMR1; `.` for reference-matching variants (e.g., copy numbers). |
| Genotype | Yes | VCF-format phasing. `\|` = phased; `/` = unphased. For copy number SVs: `0/1` = single deletion; `./1` = single duplication; `1/1` = two duplications; `./.` = unknown. |
| Annotation | Yes | Pathogenicity (primarily from ClinVar). |
| VEP_Protein_Change | Yes | Predicted amino acid change in HGVS notation (from Ensembl VEP) |
| VEP_Consequence | Yes | Molecular consequence from Ensembl VEP |
| Amplicon | Yes | Amplicon the variant is on |
| Variant_Coordinates | Yes | GRCh38 coordinates. Full-amplicon SVs show `IMPRECISE`. |
| Amplicon_Coordinates | No | GRCh38 coordinates of the amplicon |
| Variant_Type | No | `SNV`, `Indel`, `STR`, or `SV` |
| Amplicon_Copies | No | Total copies of the amplicon |
| Variant_Info | Yes | Phasing information in gene context. For high-confidence HBA alpha-cluster or HS-40 genotypes, shows shorthand for affected endogenous control amplicons. |
| Annotation_Source | No | `ClinVar`, `ACMG`, or `Asuragen`. ClinVar annotations last updated 2025-12-03. |
| Clinvar_ID | No | ClinVar identifier |
| CLNSIGCONF | No | ClinVar confidence of annotation |
| CLNREVSTAT | No | ClinVar review status |
| CLNHGVS | No | ClinVar HGVS annotation |
| Transcript | No | MANE Select transcript |
| VEP_Impact | No | Genetic impact rating corresponding to VEP_Consequence |
| Read_Depth | Yes | Fully spanning read count for the amplicon |
| Fold_Change | Yes | Fold change of the amplicon (numerical only for amplicons with fold change calculation) |
| Normalized_Peak_Height | No | Normalized peak height for FMR1 alleles (0–1 range; FMR1 only) |
| RSID | No | dbSNP variant identifier |
| REF | No | Reference sequence (as in the .vcf) |
| ALT | No | Alternate sequence (as in the .vcf) |
| Summarized | Yes | Whether this variant is included in summarized views |

### Variants (.vcf)

Per-sample VCF files follow VCFv4.2 specifications.

**Access**
- UI: Not currently accessible
- File: `[Analysis Id]/results/sample_files/vcf/[SampleID]_variants.vcf`

**Standard VCF columns:**

| Column | Description |
|--------|-------------|
| CHROM | Sample_Name + Barcode |
| POS | Variant position |
| REF | Reference sequence |
| ALT | Alternate sequence (or symbolic allele: `<DEL>`, `<INS>`, `<DUP:TANDEM>`) |
| QUAL | Quality score from external tools, if available |
| FILTER | QC flags |
| INFO | Variant details (see INFO tags below) |
| FORMAT | Tag order for the Sample_Name column |
| Sample_Name | Sample-level data |

**Selected INFO tags:**

| Tag | Source | Description |
|-----|--------|-------------|
| ROI | Asuragen | Amplicon the variant is on |
| VARIANT_INFO | Asuragen | Gene-context phasing information |
| ANNOTATION_SOURCE | Asuragen | `ClinVar`, `ACMG`, or `Asuragen` |
| Variant_Type | Asuragen | `SNV`, `Indel`, `SV`, or `STR` |
| Gene | Asuragen | Gene the variant is in |
| Transcript | Asuragen | MANE Select transcript |
| CONFIDENCE | Asuragen | Estimated genotype call confidence (0–1) |
| Clinvar_ID | ClinVar | ClinVar identifier |
| ANNOTATION | ClinVar | Clinical significance |
| CLNHGVS | ClinVar | Top-level HGVS expression |
| CLNREVSTAT | ClinVar | ClinVar review status |
| CLNSIGCONF | ClinVar | Conflicting classifications |
| VEP_Consequence | VEP | VEP consequence |
| VARIANT | VEP | Variant cDNA |
| END | Sniffles | End position of variant |
| SVTYPE | Sniffles/Asuragen | Structural variant type |
| SUPPORT | Sniffles | Reads supporting the SV |
| AF | Sniffles | Allele frequency |

**FORMAT tags:**

| Tag | Description |
|-----|-------------|
| GT | Genotype |
| DP | Read depth |
| AF | Estimated allele frequency (0–1) |
| CN | Copy number genotype (imprecise events) |
| FC | Fold change of the amplicon |
| AG | Number of allele groups detected |
| GP | Read proportions of allele groups |
| GQ | Genotype quality |
| AD | Allelic depths for ref and alt alleles |
| PL | Phred-scaled genotype likelihoods |
| PS | Phase set identifier |
| PR | Normalized peak height (0–1; FMR1 only) |
| DR | Number of reference reads |
| DV | Number of variant reads |

---

## Variant Classes

### SNVs/Indels

Single nucleotide variants (SNVs) and small insertions/deletions (<50 bp).

**Applicable genes:** CFTR, SMN1/2 (Mix A, D/phased), HBA1/2, HBB, CYP21A2, TNXB, GBA1, F8

**Method:** Reads aligned to GRCh38 and assigned to allele groups via sequence deconvolution are used to call variants with [Clair3](https://github.com/HKU-BAL/Clair3). Variants within the same amplicon are phased (indicated with `|`). Variants observed at a group frequency below 0.15 are filtered out. Detection in or adjacent to homopolymers may have reduced sensitivity.

### Copy Number Variants (CNVs)

Copy number changes at the amplicon or gene level.

**Applicable genes:** CFTR (exon-level deletions), SMN1/2, HBA1/2, HBB, CYP21A2, GBA1, TNXB

**Method:** Copy number is inferred from fold-change calculations using calibrated, normalized read counts relative to endogenous control regions. For genes with paralogs (SMN1/2, CYP21A2/A1P, GBA1/P, TNXB/A), sequence deconvolution is used to assign alleles to the correct paralog before copy number calculation.

**Output:** Copy number results appear in the `Amplicon_Copies` column and are reported as SVs in the Genotype column (`0/1` for deletion, `./1` for duplication).

### Structural Variants (SVs)

Larger genomic rearrangements including deletions/insertions >50 bp, inversions, fusions, and microconversions.

**Applicable genes:** All genes in the panel

**Method:** Within-amplicon SVs are detected using [Sniffles2](https://github.com/fritzsedlazeck/Sniffles). Full-amplicon SVs (copy number changes) are detected by fold-change analysis. Inversions (F8 introns 1 and 22) are detected using a multi-primer system. Gene fusions and microconversions (CYP21A2/A1P, GBA1/P, TNXB/A) are detected by evaluating paralog-specific variant (PSV) patterns.

**Short Tandem Repeats (STRs):** FMR1 CGG repeat expansions are detected and sized by read-based analysis. AGG interrupts within CGG tracts are also detected and reported.

---

## Quality Control

All samples undergo QC checks covering read statistics, copy number model confidence, phasing/copy number consistency, and variant-level quality classifications.

- **QC flags** indicate potential issues but do not prevent results from being reported.
- **QC failures (FAIL)** occur when aggregate Mix coverage is insufficient for any analysis to be confidently performed.

QC information is summarized in the Genotypes Summary and Sample Summary, and detailed in the `quality_control/` output files.

**Primary QC output files:**
- `[Analysis Id]/results/quality_control/quality_control.csv` — all entries
- `[Analysis Id]/results/quality_control/quality_control_flagged.csv` — flagged or failing only
- `[Analysis Id]/results/quality_control/quality_control_fail.csv` — failing only

### QC Table Columns

| Column | Description |
|--------|-------------|
| SampleID | SampleName + Barcode |
| SampleName | User-provided name |
| Barcode | Barcode applied |
| Mix | Mix the QC applies to |
| Analysis | Analysis type affected |
| Measurement under Consideration | Specific measurement identifier |
| Measurement Pass Threshold | Required value to pass |
| Measurement Value | Observed value |
| QC Flag | `PASS` or the associated flag identifier |

### QC Flags Reference

| Flag | Description | Variant Class | Target (Mix) | Criteria |
|------|-------------|:---:|:---:|---------|
| **FAIL** | Mix does not have sufficient fully spanning reads (FSRs) for any analysis | All | All (A, B, C, D) | Mix A: ≥820 FSRs; Mix B: ≥500; Mix C: ≥530; Mix D: ≥195 |
| **CalGT** | Calibrators do not match expected genotypes | CNV, SNV/Indel, SV | SMN1/2 (A), CFTR (A), HBA1/2 (C), HBB (C) | SMN1/2: 2/2 copies; CFTR: no deletions; HBA1/2: 2 copies; HBB: 2 copies; no SVs |
| **CalLowCov** | Calibrator does not have sufficient FSR coverage | CNV | SMN1/2 (A), CFTR (A), HBA1/2 (C), HBB (C) | Informs LowCovEC criteria; propagates to all calibrator-dependent analyses |
| **LowConfidence** | Copy number call does not have sufficient model confidence | CNV | SMN1/2 (A), CFTR (A), HBA1/2 (C), HBB (C), HBA EC (C) | Confidence ≥0.5 (≥0.6 for HBA EC) |
| **FC** | Amplicon fold changes outside expected gene-specific range | CNV | SMN1/2 (A), CFTR (A), HBA1/2 (C), HBB (C) | SMN1/2: [0,7]; CFTR: [0,6]; HBA: [0,5]; HBB: [0,5] |
| **LowCovEC** | Endogenous control geometric mean FSRs insufficient for CN calling | CNV | SMN1/2 (A), CFTR (A), HBA1/2 (C), HBB (C) | SMN1/2: ≥200; CFTR: ≥200; HBA: ≥50; HBB: ≥50 |
| **CNV_Warn** | Genotype impacts endogenous control regions used for HBA1/2 or HBB CN | CNV | HBA1/2 (C), HBB (C) | High-confidence alpha-globin cluster dup/del or HS40 genotype detected. Performance not claimed for HBA1/2 and HBB CN when this flag is present. |
| **LowCov** | Insufficient FSR depth for FMR1 allele detection | STR (CGG/AGG) | FMR1 (B) | <2 alleles and no FM flag: ≥2000 FSRs; otherwise ≥500 FSRs |
| **LowCov** | Insufficient FSR depth for CFTR PolyT/TG sizing | STR (PolyT/TG) | CFTR (A) | ≥60 FSRs |
| **LowCov** | Insufficient FSRs for F8 inversion detection | F8 inversions | F8 (D) | ≥50 FSRs |
| **LowCov** | Insufficient FSRs for within-sequence variant detection | SNV/Indel, SV | CFTR (A), SMN1/2 (A), HBA1/2 (C), HBB (C) | ≥30 FSRs per predicted copy number |
| **LowCov** | Insufficient FSRs across paralogs | SNV/Indel, SV, CNV | GBA (D), CYP21A2 (D), SMN1/2-LR (D) | ≥90 FSRs |
| **LowQUAL** | Clair3 variant calling quality score insufficient (variants table only) | SNV/Indel | CFTR, SMN1/2, HBA1/2, HBB, GBA, CYP21A2, SMN1/2-LR, F8 | Quality Score ≥2 |
| **PHASE** | Discrepancy between variant phasing and predicted copy number (variants table only) | SNV/Indel, SV, CNV | SMN1/2 (A), HBA1/2 (C), HBB (C), GBA (D), CYP21A2 (D), SMN1/2-LR (D) | Zygosity from sequence deconvolution aligns with CNV call |
| **RareGTWarning** | Predicted copy number is unexpected | CNV | CFTR (A), GBA (D), CYP21A2 (D), SMN1/2-LR (D) | Mix A: no homozygous single-amplicon CFTR deletions (excl. Ex19-20). Mix D: total copies across both paralogs ≥1 |

### Coverage Report

The `coverage.csv` file reports fully spanning reads (FSRs), partially spanning reads, and super spanning reads per amplicon, along with analyzed vs. unanalyzed read counts.

**Access:**
- Table: `[Analysis Id]/results/quality_control/coverage.csv`
- Visual: `[Analysis Id]/results/quality_control/coverage.html`

Key coverage columns:

| Column | Description |
|--------|-------------|
| SampleID | SampleName + Barcode |
| Amplicon | Amplicon for the summarized reads |
| Panel | Mix version |
| Calibrator | Whether sample is a calibrator for this Mix |
| Total RC | Total read count (fully + super + partially spanning) |
| Fully Spanning RC | FSRs with AR-tag = TRUE (used in downstream analysis) |
| Unanalyzed Fully Spanning RC | FSRs with AR-tag = FALSE |
| Super Spanning RC | Reads with mismatched primers, AR-tag = TRUE |
| Partially Spanning RC | Single-primer reads, AR-tag = TRUE |
| Ratio | Total RC / Median |
| Median | Median Total RC for the SampleID-Mix combination |
| Sample_Within5xMedian | Whether amplicon Total RC is Over, In Range, or Under 5× the cross-sample median |
