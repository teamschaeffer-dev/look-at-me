connection: "snowflake_sales_db"

include: "/views/*.view.lkml"
include: "/dashboards/*.dashboard.lookml"

explore: fct_quota {
  label: "Sales Performance Dashboard"

  always_filter: {
    filters: [
      fct_quota.quota_type: "Full Quota",
      dim_user.role_name: "%Sales%"
    ]
  }

  join: dim_user {
    type: left_outer
    relationship: many_to_one
    sql_on: ${fct_quota.sales_rep} = ${dim_user.full_name} ;;
  }

  join: fct_opportunity_split {
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_user.user_id} = ${fct_opportunity_split.split_user_id} 
        AND ${fct_quota.quota_date_raw} = date_trunc('month', ${fct_opportunity_split.close_date_raw}) ;;
  }

  join: fct_opportunity {
    type: left_outer
    relationship: many_to_one
    sql_on: ${fct_opportunity_split.opportunity_id} = ${fct_opportunity.opportunity_id} ;;
  }
}
