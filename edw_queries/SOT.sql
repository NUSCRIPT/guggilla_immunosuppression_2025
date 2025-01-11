SET NOCOUNT ON
if OBJECT_ID('tempdb..#cohort') IS NOT NULL 
drop table #cohort;
select cp.source_ir_id ir_id
into #cohort
from FSM_Analytics.cohort.cohort_patients cp
-- SCRIPT cohort
where cp.cohort_id = #### and cp.is_dltd_flg = 0

select distinct p.ir_id, dt.diagnosis_code, de.start_date_key
from #cohort p
join NM_BI.dim.vw_patient_current pc
  on p.ir_id = pc.ir_id
join NM_BI.fact.vw_diagnosis_event de
  on pc.patient_key = de.patient_key
join NM_BI.dim.vw_diagnosis_terminology dt
  on de.diagnosis_key = dt.diagnosis_key
-- SOT codes (separately specify ICD-9 and ICD-10 here to avoid V/Z code overlap)
where (dt.diagnosis_code_base = 'V42' and dt.diagnosis_code not in ('V42.81', 'V42.82') and dt.diagnosis_code_set = 'ICD-9-CM')
OR (dt.diagnosis_code_base = 'Z94' and dt.diagnosis_code not in ('Z94.81', 'Z94.84') and dt.diagnosis_code_set = 'ICD-10-CM')
group by p.ir_id, dt.diagnosis_code, de.start_date_key
order by p.ir_id, dt.diagnosis_code, de.start_date_key;