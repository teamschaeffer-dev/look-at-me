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

  measure: total_quota_amount {
    type: sum
    value_format_name: usd
    sql: ${quota_amount} ;;
  }
}
