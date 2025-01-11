# Identifying immunosuppression

_Owner: Vijeeth Guggilla_
_Paper: INSERT_

## Overview
Identifying immunosuppressive conditions and immunosuppressive medication using structured data (diagnosis codes, medication orders) and using LLMs

## Files
- **edw_queries/**: this folder contains the SQL queries for pulling all SCRIPT patients diagnosis codes and dates for patients with a given immunosuppressive condition. it also contains Meds.sql for pulling medication information.
- **ICD_identifier.ipynb**: whole workflow for ICD diagnosis code identification of each condition and metrics generation
- **meds_identifier.ipynb**: whole workflow for medication order identification of each medication and metrics generation
- **LLM_identifier.ipynb**: whole workflow for LLM identification of each condition/medication and metrics generation
- **local_LLM_identifier.ipynb**: whole workflow for local LLM (Llama 3.1) identification of each condition/medication and metrics generation