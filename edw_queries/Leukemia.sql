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
-- (Acute) leukemia codes
where dt.diagnosis_code in ('204.00', '204.01', '204.02', '205.00', '205.02', '206.00', '207.00', '207.02', '207.20', '207.22', 'C91.0', 'C91.01', 'C91.02', 'C92.0', 'C92.02', 'C92.50', 'C92.52', 'C92.60', 'C92.62', 'C92.A0', 'C92.A2', 'C93.00', 'C94.00', 'C94.02', 'C94.20', 'C94.22') and dt.diagnosis_code_set in ('ICD-9-CM', 'ICD-10-CM')
group by p.ir_id, dt.diagnosis_code, de.start_date_key
order by p.ir_id, dt.diagnosis_code, de.start_date_key;