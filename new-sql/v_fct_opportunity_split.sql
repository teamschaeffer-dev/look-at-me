create or replace view fake_db.fake_schema.v_fct_opportunity_split as
select
    s.id as split_id,
    o.id as opportunity_id,
    o.owner_id as opportunity_owner_id,
    s.splitownerid as split_user_id,
    s.splitpercentage,
    
    o.account_id,
    o.name as opportunity_name,
    o.type as opportunity_type,
    o.copy_opportunity_record_type as record_type,
    o.opportunity_source,
    o.sales_region,
    o.stage_name,
    o.forecast_committed,
    o.is_closed,
    o.is_won,
    o.close_date,
    o.created_date,
    o.amount as opportunity_amount,
    o.currencyisocode as currency_code,
    
    c.conversionrate as active_conversion_rate,
    
    -- Calculate converted amounts
    (o.amount / coalesce(nullif(c.conversionrate, 0), 1)) as opportunity_amount_usd,
    (o.amount / coalesce(nullif(c.conversionrate, 0), 1)) * (s.splitpercentage / 100.0) as split_amount_usd,
    (o.noram_air_volume / coalesce(nullif(c.conversionrate, 0), 1)) as noram_amount_usd,
    (o.noram_air_volume / coalesce(nullif(c.conversionrate, 0), 1)) * (s.splitpercentage / 100.0) as split_noram_amount_usd,
    
    -- History metrics
    coalesce(h.push_count, 0) as push_count,
    coalesce(h.total_push_duration_days, 0) as total_push_duration_days,
    coalesce(h.reached_qualified, false) as reached_qualified,
    
    -- Deal Growth baseline
    coalesce(h.initial_amount, o.amount) as initial_opportunity_amount,
    (coalesce(h.initial_amount, o.amount) / coalesce(nullif(c.conversionrate, 0), 1)) * (s.splitpercentage / 100.0) as initial_split_converted_amount

from fake_db.fake_schema.opportunity o
inner join fake_db.fake_schema.opportunitysplit s 
    on o.id = s.opportunityid
    and coalesce(s.isdeleted, false) = false
left join fake_db.fake_schema.v_fct_opportunity_history_aggs h
    on o.id = h.opportunity_id

-- ASOF JOIN to get the correct conversion rate for the close date
asof join fake_db.fake_schema.datedconversionrate c
    match_condition (o.close_date >= c.startdate)
    on o.currencyisocode = c.isocode

where coalesce(o.is_deleted, false) = false;
