- dashboard: sales_rep_performance
  title: Sales Rep Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Tracks Closed Won sales versus quota for each sales rep."

  filters:
    - name: Quota Year
      title: Quota Year
      type: field_filter
      default_value: "this year"
      allow_multiple_values: true
      required: false
      ui_config:
        type: advanced
        display: popover
      model: gtm_analytics
      explore: fct_quota
      field: fct_quota.quota_date_year

    - name: Quota Type
      title: Quota Type
      type: field_filter
      default_value: "Full Quota"
      allow_multiple_values: false
      required: true
      ui_config:
        type: dropdown_menu
        display: inline
      model: gtm_analytics
      explore: fct_quota
      field: fct_quota.quota_type

    - name: Team
      title: Team
      type: field_filter
      default_value: ""
      allow_multiple_values: true
      required: false
      ui_config:
        type: tag_list
        display: popover
      model: gtm_analytics
      explore: fct_quota
      field: dim_user.manager_name

  elements:
    - name: sales_vs_quota_chart
      title: "Closed Won Sales vs Quota by Sales Rep"
      model: gtm_analytics
      explore: fct_quota
      type: looker_column
      fields: [
        dim_user.manager_name,
        dim_user.full_name,
        fct_opportunity_split.won_amount,
        fct_quota.total_quota_amount
      ]
      sorts: [fct_opportunity_split.won_amount desc]
      limit: 500
      column_limit: 50
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
        Team: dim_user.manager_name
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_label: "Sales Rep"
      legend_position: top
      point_style: none
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types: {}
      series_colors:
        fct_opportunity_split.won_amount: "#1A73E8"
        fct_quota.total_quota_amount: "#34A853"
      series_labels:
        fct_opportunity_split.won_amount: "Closed Won Sales ($)"
        fct_quota.total_quota_amount: "Quota ($)"
      row: 0
      col: 0
      width: 24
      height: 10

    - name: sales_vs_quota_table
      title: "Sales Rep Quota Attainment Summary"
      model: gtm_analytics
      explore: fct_quota
      type: looker_grid
      fields: [
        dim_user.manager_name,
        dim_user.full_name,
        dim_user.region,
        fct_quota.total_quota_amount,
        fct_opportunity_split.won_amount,
        fct_opportunity_split.attainment_percent,
        fct_opportunity_split.gap_to_quota
      ]
      sorts: [fct_opportunity_split.won_amount desc]
      limit: 500
      column_limit: 50
      show_view_names: false
      show_row_numbers: true
      truncate_column_names: false
      hide_totals: false
      hide_row_totals: false
      table_theme: white
      limit_displayed_rows: false
      enable_conditional_formatting: true
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      conditional_formatting:
        - type: along a scale...
          value:
          background_color: "#1A73E8"
          font_color:
          color_application:
            collection_id: 7c5612da-06ff-4abb-8ef7-47b28236d655
            custom:
              id: 5b4e72ce-9257-4ba6-8a7e-1ff9f4305886
              label: Custom
              type: continuous
              stops:
                - color: "#F9AB00"
                  offset: 0
                - color: "#34A853"
                  offset: 100
          bold: false
          italic: false
          strikethrough: false
          fields: [fct_opportunity_split.attainment_percent]
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
        Team: dim_user.manager_name
      series_labels:
        dim_user.manager_name: "Team"
        dim_user.full_name: "Sales Rep"
        dim_user.region: "Region"
        fct_quota.total_quota_amount: "Quota"
        fct_opportunity_split.won_amount: "Closed Won Sales"
        fct_opportunity_split.attainment_percent: "Attainment %"
        fct_opportunity_split.gap_to_quota: "Gap to Quota"
      row: 10
      col: 0
      width: 24
      height: 8
