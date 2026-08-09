view: fct_opportunity {
  derived_table: {
    sql:
      SELECT DISTINCT
        opportunity_id,
        opportunity_amount_usd,
        initial_opportunity_amount / coalesce(nullif(active_conversion_rate, 0), 1) as initial_opportunity_amount_usd,
        push_count,
        total_push_duration_days,
        is_won,
        is_closed
      FROM `fake_db.fake_schema.v_fct_opportunity_split`
    ;;
  }

  dimension: opportunity_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: opportunity_amount_usd {
    type: number
    hidden: yes
    sql: ${TABLE}.opportunity_amount_usd ;;
  }

  dimension: initial_opportunity_amount_usd {
    type: number
    hidden: yes
    sql: ${TABLE}.initial_opportunity_amount_usd ;;
  }

  dimension: push_count {
    type: number
    hidden: yes
    sql: ${TABLE}.push_count ;;
  }

  dimension: total_push_duration_days {
    type: number
    hidden: yes
    sql: ${TABLE}.total_push_duration_days ;;
  }

  dimension: is_won {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_won ;;
  }

  dimension: is_closed {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_closed ;;
  }

  # --- Measures ---

  measure: average_deal_size_cw {
    label: "Average Deal Size (Closed Won)"
    type: average
    value_format_name: usd_millions
    sql: ${opportunity_amount_usd} ;;
    filters: [is_won: "yes"]
  }

  measure: average_deal_size_open {
    label: "Average Deal Size (Open)"
    type: average
    value_format_name: usd_millions
    sql: ${opportunity_amount_usd} ;;
    filters: [is_closed: "no"]
  }

  measure: deals_pushed_count {
    label: "Deals Pushed"
    type: count_distinct
    sql: ${opportunity_id} ;;
    filters: [push_count: ">0"]
  }

  measure: total_deal_push_count {
    label: "Deal Push Count"
    type: sum
    sql: ${push_count} ;;
  }

  measure: average_push_duration {
    label: "Average Push Duration (Days)"
    type: number
    value_format_name: decimal_1
    sql: sum(${total_push_duration_days}) / nullif(sum(${push_count}), 0) ;;
  }

  measure: deal_growth_amount {
    label: "Deal Growth (USD)"
    type: sum
    value_format_name: usd_millions
    sql: ${opportunity_amount_usd} - ${initial_opportunity_amount_usd} ;;
    filters: [is_won: "yes"]
  }
}
