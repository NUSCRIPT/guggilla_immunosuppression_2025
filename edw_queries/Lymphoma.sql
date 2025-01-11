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
-- Lymphoma codes
where (dt.diagnosis_code_base in ('200', '201', 'C81', 'C82', 'C83', 'C84', 'C85', 'C86') 
or dt.diagnosis_code in ('C88.0', 'C88.4')
or (dt.diagnosis_code LIKE '202.1%' OR
	dt.diagnosis_code LIKE '202.2%' OR
	dt.diagnosis_code LIKE '202.7%' OR
	dt.diagnosis_code LIKE '202.8%')) 
and dt.diagnosis_code_set in ('ICD-9-CM', 'ICD-10-CM')
group by p.ir_id, dt.diagnosis_code, de.start_date_key
order by p.ir_id, dt.diagnosis_code, de.start_date_key;