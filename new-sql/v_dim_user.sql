create or replace view fake_db.fake_schema.v_dim_user as
select
    id as user_id,
    user_key,
    user_name,
    name as full_name,
    manager_id,
    role_name,
    region,
    is_active
from fake_db.fake_schema.user;
