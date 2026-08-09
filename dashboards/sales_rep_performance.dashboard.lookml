- dashboard: sales_rep_performance
  title: Sales Rep Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Tracks Closed Won sales versus quota for each sales rep."

  filters:
    - name: "Quota Year"
      title: "Quota Year"
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
    - name: "Quota Type"
      title: "Quota Type"
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

  elements:
    - name: header_chris_welch
      type: text
      title_text: "Team: Chris Welch"
      row: 0
      col: 0
      width: 24
      height: 2

    - name: table_chris_welch
      title: "Chris Welch Team - Quota Attainment Summary"
      model: gtm_analytics
      explore: fct_quota
      type: looker_grid
      fields: [dim_user.full_name, dim_user.region, fct_quota.total_quota_amount, fct_opportunity_split.won_amount, fct_opportunity_split.attainment_bullet_chart, fct_opportunity_split.attainment_percent, fct_opportunity_split.gap_to_quota]
      filters:
        dim_user.manager_name: "Chris Welch"
      sorts: ["fct_opportunity_split.won_amount desc"]
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
        - type: "along a scale..."
          value: 
          background_color: #1A73E8
          font_color: 
          color_application:
            collection_id: 7c5612da-06ff-4abb-8ef7-47b28236d655
            custom:
              id: 5b4e72ce-9257-4ba6-8a7e-1ff9f4305886
              label: Custom
              type: continuous
              stops:
                - color: #F9AB00
                  offset: 0
                - color: #34A853
                  offset: 100
          bold: false
          italic: false
          strikethrough: false
          fields: [fct_opportunity_split.attainment_percent]
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_labels:
        dim_user.full_name: "Sales Rep"
        dim_user.region: Region
        fct_quota.total_quota_amount: Quota
        fct_opportunity_split.won_amount: "Closed Won Sales"
        fct_opportunity_split.attainment_bullet_chart: "Attainment Chart"
        fct_opportunity_split.attainment_percent: "Attainment %"
        fct_opportunity_split.gap_to_quota: "Gap to Quota"
      row: 2
      col: 0
      width: 24
      height: 12

    - name: header_ian_race
      type: text
      title_text: "Team: Ian Race"
      row: 14
      col: 0
      width: 24
      height: 2

    - name: table_ian_race
      title: "Ian Race Team - Quota Attainment Summary"
      model: gtm_analytics
      explore: fct_quota
      type: looker_grid
      fields: [dim_user.full_name, dim_user.region, fct_quota.total_quota_amount, fct_opportunity_split.won_amount, fct_opportunity_split.attainment_bullet_chart, fct_opportunity_split.attainment_percent, fct_opportunity_split.gap_to_quota]
      filters:
        dim_user.manager_name: "Ian Race"
      sorts: ["fct_opportunity_split.won_amount desc"]
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
        - type: "along a scale..."
          value: 
          background_color: #1A73E8
          font_color: 
          color_application:
            collection_id: 7c5612da-06ff-4abb-8ef7-47b28236d655
            custom:
              id: 5b4e72ce-9257-4ba6-8a7e-1ff9f4305886
              label: Custom
              type: continuous
              stops:
                - color: #F9AB00
                  offset: 0
                - color: #34A853
                  offset: 100
          bold: false
          italic: false
          strikethrough: false
          fields: [fct_opportunity_split.attainment_percent]
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_labels:
        dim_user.full_name: "Sales Rep"
        dim_user.region: Region
        fct_quota.total_quota_amount: Quota
        fct_opportunity_split.won_amount: "Closed Won Sales"
        fct_opportunity_split.attainment_bullet_chart: "Attainment Chart"
        fct_opportunity_split.attainment_percent: "Attainment %"
        fct_opportunity_split.gap_to_quota: "Gap to Quota"
      row: 16
      col: 0
      width: 24
      height: 12

    - name: header_jim_oakes
      type: text
      title_text: "Team: Jim Oakes"
      row: 28
      col: 0
      width: 24
      height: 2

    - name: table_jim_oakes
      title: "Jim Oakes Team - Quota Attainment Summary"
      model: gtm_analytics
      explore: fct_quota
      type: looker_grid
      fields: [dim_user.full_name, dim_user.region, fct_quota.total_quota_amount, fct_opportunity_split.won_amount, fct_opportunity_split.attainment_bullet_chart, fct_opportunity_split.attainment_percent, fct_opportunity_split.gap_to_quota]
      filters:
        dim_user.manager_name: "Jim Oakes"
      sorts: ["fct_opportunity_split.won_amount desc"]
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
        - type: "along a scale..."
          value: 
          background_color: #1A73E8
          font_color: 
          color_application:
            collection_id: 7c5612da-06ff-4abb-8ef7-47b28236d655
            custom:
              id: 5b4e72ce-9257-4ba6-8a7e-1ff9f4305886
              label: Custom
              type: continuous
              stops:
                - color: #F9AB00
                  offset: 0
                - color: #34A853
                  offset: 100
          bold: false
          italic: false
          strikethrough: false
          fields: [fct_opportunity_split.attainment_percent]
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_labels:
        dim_user.full_name: "Sales Rep"
        dim_user.region: Region
        fct_quota.total_quota_amount: Quota
        fct_opportunity_split.won_amount: "Closed Won Sales"
        fct_opportunity_split.attainment_bullet_chart: "Attainment Chart"
        fct_opportunity_split.attainment_percent: "Attainment %"
        fct_opportunity_split.gap_to_quota: "Gap to Quota"
      row: 30
      col: 0
      width: 24
      height: 12

    - name: header_jennifer_marsland
      type: text
      title_text: "Team: Jennifer Marsland"
      row: 42
      col: 0
      width: 24
      height: 2

    - name: table_jennifer_marsland
      title: "Jennifer Marsland Team - Quota Attainment Summary"
      model: gtm_analytics
      explore: fct_quota
      type: looker_grid
      fields: [dim_user.full_name, dim_user.region, fct_quota.total_quota_amount, fct_opportunity_split.won_amount, fct_opportunity_split.attainment_bullet_chart, fct_opportunity_split.attainment_percent, fct_opportunity_split.gap_to_quota]
      filters:
        dim_user.manager_name: "Jennifer Marsland"
      sorts: ["fct_opportunity_split.won_amount desc"]
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
        - type: "along a scale..."
          value: 
          background_color: #1A73E8
          font_color: 
          color_application:
            collection_id: 7c5612da-06ff-4abb-8ef7-47b28236d655
            custom:
              id: 5b4e72ce-9257-4ba6-8a7e-1ff9f4305886
              label: Custom
              type: continuous
              stops:
                - color: #F9AB00
                  offset: 0
                - color: #34A853
                  offset: 100
          bold: false
          italic: false
          strikethrough: false
          fields: [fct_opportunity_split.attainment_percent]
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_labels:
        dim_user.full_name: "Sales Rep"
        dim_user.region: Region
        fct_quota.total_quota_amount: Quota
        fct_opportunity_split.won_amount: "Closed Won Sales"
        fct_opportunity_split.attainment_bullet_chart: "Attainment Chart"
        fct_opportunity_split.attainment_percent: "Attainment %"
        fct_opportunity_split.gap_to_quota: "Gap to Quota"
      row: 44
      col: 0
      width: 24
      height: 12
