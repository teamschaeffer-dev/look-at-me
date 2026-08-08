create or replace view fake_db.fake_schema.v_fct_quota as
select
    type as quota_type,
    sales_rep,
    amount as quota_amount,
    -- Construct a date for the first of the month using YEAR and MONTH strings
    date_from_parts(try_to_number(year), try_to_number(month), 1) as quota_date,
    year,
    quarter,
    month
from fake_db.fake_schema.rep_quotas;
