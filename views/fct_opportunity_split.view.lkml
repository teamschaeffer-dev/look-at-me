view: fct_opportunity_split {
  sql_table_name: `fake_db.fake_schema.v_fct_opportunity_split` ;;

  dimension: split_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.split_id ;;
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: opportunity_owner_id {
    type: string
    sql: ${TABLE}.opportunity_owner_id ;;
  }

  dimension: split_user_id {
    type: string
    sql: ${TABLE}.split_user_id ;;
  }

  dimension: split_percentage {
    type: number
    sql: ${TABLE}.splitpercentage ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }

  dimension: opportunity_type {
    type: string
    sql: ${TABLE}.opportunity_type ;;
  }

  dimension: record_type {
    type: string
    sql: ${TABLE}.record_type ;;
  }

  dimension: opportunity_source {
    type: string
    sql: ${TABLE}.opportunity_source ;;
  }

  dimension: sales_region {
    type: string
    sql: ${TABLE}.sales_region ;;
  }

  dimension: stage_name {
    type: string
    sql: ${TABLE}.stage_name ;;
  }

  dimension: forecast_committed {
    type: string
    sql: ${TABLE}.forecast_committed ;;
  }

  dimension: is_closed {
    type: yesno
    sql: ${TABLE}.is_closed ;;
  }

  dimension: is_won {
    type: yesno
    sql: ${TABLE}.is_won ;;
  }

  dimension: reached_qualified {
    type: yesno
    sql: ${TABLE}.reached_qualified ;;
  }

  dimension_group: close_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.close_date ;;
  }

  dimension_group: created_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_date ;;
  }

  dimension: opportunity_amount {
    type: number
    sql: ${TABLE}.opportunity_amount ;;
  }
  
  dimension: currency_code {
    type: string
    sql: ${TABLE}.currency_code ;;
  }

  dimension: active_conversion_rate {
    type: number
    sql: ${TABLE}.active_conversion_rate ;;
  }

  dimension: split_amount_usd {
    type: number
    hidden: yes
    sql: ${TABLE}.split_amount_usd ;;
  }

  dimension: split_noram_amount_usd {
    type: number
    hidden: yes
    sql: ${TABLE}.split_noram_amount_usd ;;
  }

  # --- Measures ---

  measure: total_split_amount {
    label: "Total Split Amount (USD)"
    type: sum
    value_format_name: usd_millions
    sql: ${split_amount_usd} ;;
  }

  measure: deal_count {
    label: "Deals Created (Count)"
    type: count_distinct
    sql: ${opportunity_id} ;;
  }

  measure: won_amount {
    label: "Sales (Won Amount USD)"
    type: sum
    value_format_name: usd_millions
    sql: ${split_amount_usd} ;;
    filters: [is_won: "yes"]
  }

  measure: won_count {
    label: "Deals Won (Count)"
    type: count_distinct
    sql: ${opportunity_id} ;;
    filters: [is_won: "yes"]
  }

  measure: closed_amount {
    label: "Closed Amount (USD)"
    type: sum
    value_format_name: usd_millions
    sql: ${split_amount_usd} ;;
    filters: [is_closed: "yes"]
  }

  measure: closed_count {
    label: "Deals Closed (Count)"
    type: count_distinct
    sql: ${opportunity_id} ;;
    filters: [is_closed: "yes"]
  }

  measure: open_pipeline_amount {
    label: "Open Pipeline (USD)"
    type: sum
    value_format_name: usd_millions
    sql: ${split_amount_usd} ;;
    filters: [is_closed: "no"]
  }

  measure: open_pipeline_count {
    label: "Open Pipeline (Count)"
    type: count_distinct
    sql: ${opportunity_id} ;;
    filters: [is_closed: "no"]
  }

  measure: win_rate {
    label: "Win Rate"
    type: number
    value_format_name: percent_2
    sql: ${won_count} / nullif(${closed_count}, 0) ;;
  }

  measure: qualified_count {
    label: "Qualified Deals (Count)"
    type: count_distinct
    sql: ${opportunity_id} ;;
    filters: [reached_qualified: "yes"]
  }

  measure: conversion_rate {
    label: "Conversion Rate"
    type: number
    value_format_name: percent_2
    sql: ${won_count} / nullif(${qualified_count}, 0) ;;
  }

  measure: attainment_percent {
    label: "Attainment %"
    type: number
    value_format_name: percent_2
    sql: ${won_amount} / nullif(${fct_quota.total_quota_amount}, 0) ;;
  }

  measure: gap_to_quota {
    label: "Gap to Quota (USD)"
    type: number
    value_format_name: usd_millions
    sql: ${fct_quota.total_quota_amount} - ${won_amount} ;;
  }

  measure: attainment_bullet_chart {
    label: "Attainment Bullet Chart"
    type: number
    sql: ${won_amount} ;;
    html:
      {% assign quota = fct_quota.total_quota_amount._value %}
      {% assign sales = won_amount._value %}
      
      <!-- Liquid logic to scale the chart -->
      {% assign max_val = quota %}
      {% if sales > quota %}
        {% assign max_val = sales %}
      {% endif %}
      
      <!-- Avoid division by zero -->
      {% assign max_val = max_val | plus: 0.0001 %}
      {% assign quota_pct = quota | divided_by: max_val | times: 100 %}
      {% assign sales_pct = sales | divided_by: max_val | times: 100 %}

      <!-- Bullet Chart Structure -->
      <div style="width: 100%; height: 20px; position: relative; display: flex; align-items: center;">
        <div style="width: 100%; height: 20px; background-color: #f1f3f4; position: absolute; border-radius: 2px;"></div>
        <div style="width: {{ sales_pct }}%; height: 20px; background-color: #1A73E8; position: absolute; border-radius: 2px;"></div>
        
        <!-- Base64 SVG Marker (Dash, 50% height of the 20px bar = 10px) -->
        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyIiBoZWlnaHQ9IjEwIj48cmVjdCB3aWR0aD0iMiIgaGVpZ2h0PSIxMCIgZmlsbD0iIzAwMDAwMCIvPjwvc3ZnPg==" style="position: absolute; left: calc({{ quota_pct }}% - 1px); height: 10px; width: 2px; z-index: 2;" />
      </div>
    ;;
  }

  measure: open_pipeline_qualified_amount {
    type: sum
    hidden: yes
    sql: ${split_amount_usd} ;;
    filters: [is_closed: "no", reached_qualified: "yes"]
  }

  measure: pipeline_coverage {
    label: "Pipeline Coverage"
    type: number
    value_format_name: decimal_2
    sql: ${open_pipeline_qualified_amount} / nullif(${gap_to_quota}, 0) ;;
  }

  measure: pipeline_coverage_target {
    label: "Pipeline Coverage Target"
    type: number
    value_format_name: decimal_2
    sql: 1.0 / nullif(${conversion_rate}, 0) ;;
  }
}
