view: fct_quota {
  sql_table_name: `fake_db.fake_schema.v_fct_quota` ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${quota_type}, '-', ${sales_rep}, '-', ${quota_date_raw}) ;;
  }

  dimension: quota_type {
    type: string
    sql: ${TABLE}.quota_type ;;
  }

  dimension: sales_rep {
    type: string
    sql: ${TABLE}.sales_rep ;;
  }

  dimension_group: quota_date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.quota_date ;;
  }

  dimension: quota_amount {
    type: number
    hidden: yes
    sql: ${TABLE}.quota_amount ;;
  }

  dimension: sales_team {
    label: "Sales Team"
    type: string
    sql: ${TABLE}.sales_team ;;
  }

  dimension: is_leader {
    type: yesno
    sql: ${TABLE}.is_leader ;;
  }

  measure: total_quota_amount {
    type: sum
    value_format_name: usd_millions
    sql: ${quota_amount} ;;
  }

  measure: manager_quota {
    label: "Manager Quota (USD)"
    type: number
    value_format_name: usd_millions
    sql: ${total_quota_amount} * 0.9 ;;
  }
}
