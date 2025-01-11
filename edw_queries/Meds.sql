SET NOCOUNT ON
if OBJECT_ID('tempdb..#cohort') IS NOT NULL 
drop table #cohort;
select cp.source_ir_id ir_id
into #cohort
from FSM_Analytics.cohort.cohort_patients cp
-- SCRIPT cohort
where cp.cohort_id = #### and cp.is_dltd_flg = 0

SELECT DISTINCT pat.ir_id
                , mo.order_placed_datetime
                , mo.order_start_datetime
                , mo.order_end_datetime
                , mo.order_display_name
                , med.medication_name
                , med.generic_name
                , med.route
                , med.therapeutic_class
                , med.pharmaceutical_class
                , med.dea_class
FROM #cohort pat
INNER JOIN NM_BI.dim.vw_patient_current pc
  on pat.ir_id = pc.ir_id
INNER JOIN NM_BI.fact.vw_medication_order mo
    ON mo.patient_key = pc.patient_key
INNER JOIN NM_BI.dim.vw_medication_order_profile mop
    ON mop.medication_order_profile_key = mo.medication_order_profile_key
INNER JOIN NM_BI.dim.vw_medication med
    ON med.medication_key = mo.medication_key
    AND med.medication_key > 0 -- FILTER OUT MEDICATION KEYS OF 0
WHERE ISNULL(mop.order_status,'') NOT IN ( --FILTER OUT CANCELLED/INVALID ORDERS
                                            'Canceled' 
                                            , 'Pending Verify'
                                            , 'unknown'
                                            , 'Order Canceled'
                                            , 'Voided'
                                            , 'Future'
                                            , 'Incomplete'
                                            , 'not_applicable'
                                            , 'On Hold, Med Student'
                                            , 'no_value'
                                            )