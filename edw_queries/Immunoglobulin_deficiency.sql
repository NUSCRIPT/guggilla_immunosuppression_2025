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
-- Immunoglobulin deficiency codes
where (dt.diagnosis_code_base in ('D80') or dt.diagnosis_code in ('279.01', '279.02', '279.03', '279.04', '279.05', '279.09')) and dt.diagnosis_code not in ('D80.1') and dt.diagnosis_code_set in ('ICD-9-CM', 'ICD-10-CM')
group by p.ir_id, dt.diagnosis_code, de.start_date_key
order by p.ir_id, dt.diagnosis_code, de.start_date_key;