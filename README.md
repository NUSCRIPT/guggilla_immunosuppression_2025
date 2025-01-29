# Identifying immunosuppression

_Owner: Vijeeth Guggilla_

_Guggilla, V. et al. Large language models outperform traditional structured data-based approaches in identifying immunosuppressed patients. 2025.01.16.25320564 Preprint at https://doi.org/10.1101/2025.01.16.25320564 (2025)._

## Overview
Identifying immunosuppressive conditions and immunosuppressive medication using structured data (diagnosis codes, medication orders) and using LLMs

## Files
- **edw_queries/**: this folder contains the SQL queries for pulling all SCRIPT patients diagnosis codes and dates for patients with a given immunosuppressive condition. it also contains Meds.sql for pulling medication information.
- **ICD_identifier.ipynb**: whole workflow for ICD diagnosis code identification of each condition and metrics generation
- **meds_identifier.ipynb**: whole workflow for medication order identification of each medication and metrics generation
- **LLM_identifier.ipynb**: whole workflow for LLM identification of each condition/medication and metrics generation
- **local_LLM_identifier.ipynb**: whole workflow for local LLM (Llama 3.1) identification of each condition/medication and metrics generation
