# Panel Filter Configurations

Panel filters control which variants are included in analysis results. The Software ships with a default filter, and you can create custom configurations to support specific use cases.

> **Note:** Panel filter configurations cannot be deleted from the user interface. To delete a config, navigate to `[User Data Path]\panels\custom\` and delete the relevant JSON file. This requires administrator permissions.

> **Note:** Custom panel filter configurations are deleted when the Software is uninstalled. If you need them for future use, copy the files from `[User Data Path]\panels\custom\` to another location before uninstalling.

---

## Analyze vs. Summarize

Panel filters operate at two levels:

- **Analyze** — variants included in variant-level results ([Variants](../reference/results-description.md#variants))
- **Summarize** — a subset of Analyzed variants that are also included in gene-level ([Genotypes Summary](../reference/results-description.md#genotypes-summary)) and sample-level ([Sample Summary](../reference/results-description.md#sample-summary)) results

The Summarize filter is always a subset of the Analyze filter — this is enforced in the UI.

| File / View | Neither | Analyze only | Analyze & Summarize |
|-------------|---------|-------------|----------------------|
| Sample Summary view / `sample_summary.csv` | Not included | Not included | Included |
| Genotype Summary view / `genotypes_summary.csv` | Not included | Not included | Included |
| Variant Results view / `variants.csv` | Not included | Included | Included |
| `[Sample]_VARIANTS.CSV` / `.VCF` | Not included | Included | Included |

### Inclusion logic

For a variant to appear in Analyze or Summarize results, the following must be true:

```
Gene AND EITHER (Default OR ((ClinVar Classification OR VEP OR Inclusion List) NOT Exclusion List))
```

Regardless of filter settings, the following variant types are **always** Analyzed and Summarized:

- Structural Variants (SVs, including copy number variants)
- Short Tandem Repeats (STRs)
- Linked Variants (LVs): `c.*3+80 T>G`, `c.*211_*212del` present in SMN1 only
- SMN2 disease modifier variant `c.859G>C`

---

## Review the Default Panel Filter

1. Click **Settings** in the navigation bar.
2. Select `default_filter.json` from the **Panel Filter Configurations** dropdown.
3. Use the **GENE FILTER**, **CLINVAR**, and **VARIANT EFFECT** tabs to review the defaults:
   - **GENE FILTER:** All Mixes and all genes are selected for both Analyze and Summarize.
   - **CLINVAR:** All categories are Analyzed; only Pathogenic and Likely Pathogenic are Summarized.
   - **VARIANT EFFECT:** All consequences are Analyzed; only `nonsense` is Summarized.
   - **VARIANT LISTS:** No inclusion or exclusion lists are defined by default.

---

## Create a New Panel Filter Configuration

1. Click **Settings** in the navigation bar.
2. Select **Create a new panel configuration** from the dropdown.

### GENE FILTER tab (required)

1. Choose one or more Mixes from the left pane to filter Mix-specific genes in the right pane.
2. Toggle **Analyze** for each gene target to include in variant-level results.
3. Toggle **Summarize** for each gene to include in summary results.

### CLINVAR tab (optional)

Select which ClinVar variant classifications are included in Analyze and Summarize results. If no selections are made, variants are not filtered by ClinVar classification.

| Classification | Grouped ClinVar Terms |
|---------------|-----------------------|
| **pathogenic** | Pathogenic, Pathogenic\|drug_response, Pathogenic\|risk_factor, Pathogenic/Likely_pathogenic, Pathogenic/Likely_pathogenic\|risk_factor, Pathogenic\|other, Pathogenic/Likely_pathogenic\|other |
| **likely pathogenic** | Likely_pathogenic, Pathogenic/Likely_pathogenic, Pathogenic/Likely_pathogenic\|risk_factor, Pathogenic/Likely_pathogenic\|other |
| **uncertain significance** | Uncertain_significance, not_provided, no_classification_for_the_single_variant, Uncertain_significance\|other |
| **likely benign** | Likely_benign, Benign/Likely_benign\|risk_factor, Benign/Likely_benign |
| **benign** | Benign, Benign/Likely_benign\|risk_factor, Benign/Likely_benign |
| **conflicting** | Conflicting_interpretations_of_pathogenicity, Conflicting_classifications_of_pathogenicity, Conflicting_classifications_of_pathogenicity\|other, Conflicting_classifications_of_pathogenicity\|risk_factor |
| **drug response** | drug_response, Pathogenic\|drug_response, Benign/Likely_benign\|drug_response |
| **risk factor** | risk_factor, Pathogenic\|risk_factor, Pathogenic/Likely_pathogenic\|risk_factor, Benign/Likely_benign\|risk_factor, Conflicting_*\|risk_factor |
| **other** | Pathogenic\|other, other, Conflicting_classifications_of_pathogenicity\|other. Includes unannotated variants. |
| **all** | Reports all variants regardless of ClinVar status |
| **annotated** | All variants present in ClinVar. Excludes unannotated variants (assigned `.` or `N/A`). Note: includes benign/likely benign variants. |

For all categories except `all`, `annotated`, `conflicting`, and `other`, terms are unchanged from [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/docs/clinsig/).

### VARIANT EFFECT tab (optional)

Select which VEP consequences are included. Based on [Ensembl VEP](https://useast.ensembl.org/info/genome/variation/prediction/predicted_data.html).

| VEP Consequence | Grouped Terms |
|----------------|---------------|
| **nonsense** | stop_gained |
| **frameshift** | frameshift_variant |
| **splice** | splice_acceptor_variant, splice_donor_variant, splice_donor_5th_base_variant, splice_region_variant, splice_donor_region_variant, splice_polypyrimidine_tract_variant |
| **missense** | missense_variant, stop_lost, start_lost, inframe_deletion, inframe_insertion, incomplete_terminal_codon_variant |
| **silent** | start_retained_variant, stop_retained_variant, synonymous_variant |
| **intronic** | intron_variant |
| **intergenic** | intergenic_variant |
| **other_high_impact** | transcript_amplification, transcript_ablation, feature_elongation, feature_truncation |
| **other_non_high_impact** | protein_altering_variant, coding_sequence_variant, mature_miRNA_variant, 5_prime_UTR_variant, 3_prime_UTR_variant, NMD_transcript_variant, upstream_gene_variant, downstream_gene_variant, regulatory_region_variant, sequence_variant, and others. Includes unannotated variants. |
| **annotated** | All VEP terms except `.` and `N/A` |

### VARIANT LISTS tab (optional)

Use this tab to include or exclude specific variants by HGVS identifier. If no lists are provided, all variants passing the Gene, ClinVar, and VEP filters are included.

**Exclusion List:** variants always excluded from both Analyze and Summarize, regardless of other settings. The exclusion list overrides the inclusion list.

**Inclusion List:** variants always included in both Analyze and Summarize, regardless of ClinVar/VEP settings. Gene-level Analyze/Summarize toggles still apply — a variant won't be included if its gene is not toggled on.

#### Variant list file format

Upload a plain text file containing a comma-separated list of variants in modified HGVS format: `GENE_NAME:NAME`

- `GENE_NAME` must match the gene name shown in the GENE FILTER tab.
- `NAME` is the variant in MANE Select reference notation.
- No header row.
- The list must not end with a trailing comma.

Valid examples:

```
HBB:c.316-185C>T,GBA1:c.1226A>G
HBB:c.316-185C>T, GBA1:c.1226A>G
HBB:c.316-185C>T
```
