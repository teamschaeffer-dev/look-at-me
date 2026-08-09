create or replace view fake_db.fake_schema.v_dim_user as
select
    u.id as user_id,
    u.user_key,
    u.user_name,
    u.name as full_name,
    u.manager_id,
    m.name as manager_name,
    u.role_name,
    u.region,
    u.is_active
from fake_db.fake_schema.user u
left join fake_db.fake_schema.user m on u.manager_id = m.id;
