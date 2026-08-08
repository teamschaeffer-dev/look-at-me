create or replace view fake_db.fake_schema.v_fct_opportunity_history_aggs as
with raw_history as (
    select
        opportunityid,
        field,
        oldvalue,
        newvalue,
        createddate
    from fake_db.fake_schema.opportunityfieldhistory
    where coalesce(isdeleted, false) = false
),

history_with_lead_lag as (
    select
        opportunityid,
        field,
        oldvalue,
        newvalue,
        createddate,
        lead(newvalue) over (partition by opportunityid, field order by createddate) as next_newvalue,
        lead(oldvalue) over (partition by opportunityid, field order by createddate) as next_oldvalue,
        lead(createddate) over (partition by opportunityid, field order by createddate) as next_createddate,
        lag(newvalue) over (partition by opportunityid, field order by createddate) as prev_newvalue,
        lag(oldvalue) over (partition by opportunityid, field order by createddate) as prev_oldvalue,
        lag(createddate) over (partition by opportunityid, field order by createddate) as prev_createddate
    from raw_history
),

history as (
    select 
        opportunityid,
        field,
        oldvalue,
        newvalue,
        createddate
    from history_with_lead_lag
    where not (
        (next_newvalue = oldvalue and next_oldvalue = newvalue and timestampdiff(hour, createddate, next_createddate) <= 24)
        or
        (prev_oldvalue = newvalue and prev_newvalue = oldvalue and timestampdiff(hour, prev_createddate, createddate) <= 24)
    )
),

qualified as (
    select
        opportunityid,
        min(
            case
                when newvalue in (
                    'Discovery / RFX',
                    'Demo / Proposal / Evaluation',
                    'VOC / Verbal',
                    'Contract Out',
                    'Closed - Won'
                ) then createddate
            end
        ) as first_qualified_date,
        max(
            case
                when newvalue in (
                    'Discovery / RFX',
                    'Demo / Proposal / Evaluation',
                    'VOC / Verbal',
                    'Contract Out',
                    'Closed - Won'
                ) then true
                else false
            end
        ) as reached_qualified
    from history
    where field = 'StageName'
    group by opportunityid
),

pushes as (
    select
        h.opportunityid,
        count(*) as push_count,
        sum(datediff(day, try_to_date(left(h.oldvalue, 10)), try_to_date(left(h.newvalue, 10)))) as total_push_duration_days
    from history h
    join qualified s on h.opportunityid = s.opportunityid
    where h.field = 'CloseDate'
      and try_to_date(left(h.newvalue, 10)) > try_to_date(left(h.oldvalue, 10))
      and h.createddate > s.first_qualified_date
    group by h.opportunityid
),

initial_amounts as (
    select
        opportunityid,
        try_to_number(newvalue) as initial_amount
    from history
    where field = 'Amount'
      and try_to_number(newvalue) > 1000
      and trunc(try_to_number(newvalue)) % 1000 != 888
    qualify row_number() over (partition by opportunityid order by createddate asc) = 1
),

unique_opps as (
    select distinct opportunityid
    from history
)

select
    u.opportunityid as opportunity_id,
    coalesce(p.push_count, 0) as push_count,
    coalesce(p.total_push_duration_days, 0) as total_push_duration_days,
    coalesce(s.reached_qualified, false) as reached_qualified,
    a.initial_amount
from unique_opps u
left join pushes p on u.opportunityid = p.opportunityid
left join qualified s on u.opportunityid = s.opportunityid
left join initial_amounts a on u.opportunityid = a.opportunityid;
