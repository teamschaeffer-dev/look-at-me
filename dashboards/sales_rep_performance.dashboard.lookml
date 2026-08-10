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
    - name: header_enterprise
      type: text
      title_text: "Team: Enterprise"
      row: 0
      col: 0
      width: 24
      height: 2

    - name: gauge_enterprise
      title: "Enterprise - Team Attainment"
      model: gtm_analytics
      explore: fct_quota
      type: looker_column
      fields: [fct_opportunity_split.manager_attainment_percent]
      filters:
        fct_quota.sales_team: "Enterprise"
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      advanced_vis_config: |-
        {
          "chart": { "type": "solidgauge" },
          "yAxis": [{ "min": 0, "max": 1 }],
          "pane": {
            "center": ["50%", "85%"],
            "size": "140%",
            "startAngle": -90,
            "endAngle": 90,
            "background": {
              "innerRadius": "60%",
              "outerRadius": "100%",
              "shape": "arc"
            }
          }
        }
      row: 2
      col: 0
      width: 6
      height: 8

    - name: chart_enterprise
      title: "Enterprise Team - Sales vs Quota"
      model: gtm_analytics
      explore: fct_quota
      type: looker_bar
      fields: [dim_user.full_name, fct_opportunity_split.won_amount, fct_quota.total_quota_amount]
      filters:
        fct_quota.sales_team: "Enterprise"
      sorts: ["fct_opportunity_split.won_amount desc"]
      limit: 500
      column_limit: 50
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_types:
        fct_quota.total_quota_amount: scatter
      advanced_vis_config: |-
        {
          "series": [
            {},
            {
              "marker": {
                "symbol": "url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0IiBoZWlnaHQ9IjMwIj48cmVjdCB3aWR0aD0iNCIgaGVpZ2h0PSIzMCIgZmlsbD0iIzAwMDAwMCIvPjwvc3ZnPg==)"
              },
              "dataLabels": {
                "enabled": false
              }
            }
          ]
        }
      x_axis_gridlines: false
      y_axis_gridlines: false
      show_view_names: false
      show_y_axis_labels: false
      show_y_axis_ticks: false
      y_axis_tick_density: default
      show_x_axis_label: false
      show_x_axis_ticks: false
      x_axis_label: "Sales Rep"
      legend_position: bottom
      point_style: none
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: #808080
      series_colors:
        fct_opportunity_split.won_amount: #1A73E8
        fct_quota.total_quota_amount: #34A853
      series_labels:
        fct_opportunity_split.won_amount: "Closed Won Sales ($)"
        fct_quota.total_quota_amount: "Quota ($)"
      row: 2
      col: 6
      width: 8
      height: 8

    - name: table_enterprise
      title: "Enterprise Team - Quota Attainment Summary"
      model: gtm_analytics
      explore: fct_quota
      type: looker_grid
      fields: [dim_user.full_name, dim_user.region, fct_quota.total_quota_amount, fct_opportunity_split.won_amount, fct_opportunity_split.attainment_percent, fct_opportunity_split.gap_to_quota]
      filters:
        fct_quota.sales_team: "Enterprise"
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
      series_cell_visualizations:
        fct_quota.total_quota_amount:
          is_active: false
        fct_opportunity_split.won_amount:
          is_active: false
        fct_opportunity_split.attainment_percent:
          is_active: true
        fct_opportunity_split.gap_to_quota:
          is_active: false
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_labels:
        dim_user.full_name: "Sales Rep"
        dim_user.region: Region
        fct_quota.total_quota_amount: Quota
        fct_opportunity_split.won_amount: "Closed Won Sales"
        fct_opportunity_split.attainment_percent: "Attainment %"
        fct_opportunity_split.gap_to_quota: "Gap to Quota"
      row: 2
      col: 14
      width: 10
      height: 8

    - name: header_canada
      type: text
      title_text: "Team: Canada"
      row: 10
      col: 0
      width: 24
      height: 2

    - name: gauge_canada
      title: "Canada - Team Attainment"
      model: gtm_analytics
      explore: fct_quota
      type: looker_column
      fields: [fct_opportunity_split.manager_attainment_percent]
      filters:
        fct_quota.sales_team: "Canada"
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      advanced_vis_config: |-
        {
          "chart": { "type": "solidgauge" },
          "yAxis": [{ "min": 0, "max": 1 }],
          "pane": {
            "center": ["50%", "85%"],
            "size": "140%",
            "startAngle": -90,
            "endAngle": 90,
            "background": {
              "innerRadius": "60%",
              "outerRadius": "100%",
              "shape": "arc"
            }
          }
        }
      row: 12
      col: 0
      width: 6
      height: 8

    - name: chart_canada
      title: "Canada Team - Sales vs Quota"
      model: gtm_analytics
      explore: fct_quota
      type: looker_bar
      fields: [dim_user.full_name, fct_opportunity_split.won_amount, fct_quota.total_quota_amount]
      filters:
        fct_quota.sales_team: "Canada"
      sorts: ["fct_opportunity_split.won_amount desc"]
      limit: 500
      column_limit: 50
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_types:
        fct_quota.total_quota_amount: scatter
      advanced_vis_config: |-
        {
          "series": [
            {},
            {
              "marker": {
                "symbol": "url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0IiBoZWlnaHQ9IjMwIj48cmVjdCB3aWR0aD0iNCIgaGVpZ2h0PSIzMCIgZmlsbD0iIzAwMDAwMCIvPjwvc3ZnPg==)"
              },
              "dataLabels": {
                "enabled": false
              }
            }
          ]
        }
      x_axis_gridlines: false
      y_axis_gridlines: false
      show_view_names: false
      show_y_axis_labels: false
      show_y_axis_ticks: false
      y_axis_tick_density: default
      show_x_axis_label: false
      show_x_axis_ticks: false
      x_axis_label: "Sales Rep"
      legend_position: bottom
      point_style: none
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: #808080
      series_colors:
        fct_opportunity_split.won_amount: #1A73E8
        fct_quota.total_quota_amount: #34A853
      series_labels:
        fct_opportunity_split.won_amount: "Closed Won Sales ($)"
        fct_quota.total_quota_amount: "Quota ($)"
      row: 12
      col: 6
      width: 8
      height: 8

    - name: table_canada
      title: "Canada Team - Quota Attainment Summary"
      model: gtm_analytics
      explore: fct_quota
      type: looker_grid
      fields: [dim_user.full_name, dim_user.region, fct_quota.total_quota_amount, fct_opportunity_split.won_amount, fct_opportunity_split.attainment_percent, fct_opportunity_split.gap_to_quota]
      filters:
        fct_quota.sales_team: "Canada"
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
      series_cell_visualizations:
        fct_quota.total_quota_amount:
          is_active: false
        fct_opportunity_split.won_amount:
          is_active: false
        fct_opportunity_split.attainment_percent:
          is_active: true
        fct_opportunity_split.gap_to_quota:
          is_active: false
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_labels:
        dim_user.full_name: "Sales Rep"
        dim_user.region: Region
        fct_quota.total_quota_amount: Quota
        fct_opportunity_split.won_amount: "Closed Won Sales"
        fct_opportunity_split.attainment_percent: "Attainment %"
        fct_opportunity_split.gap_to_quota: "Gap to Quota"
      row: 12
      col: 14
      width: 10
      height: 8

    - name: header_mid_market_east
      type: text
      title_text: "Team: Mid Market East"
      row: 20
      col: 0
      width: 24
      height: 2

    - name: gauge_mid_market_east
      title: "Mid Market East - Team Attainment"
      model: gtm_analytics
      explore: fct_quota
      type: looker_column
      fields: [fct_opportunity_split.manager_attainment_percent]
      filters:
        fct_quota.sales_team: "Mid Market East"
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      advanced_vis_config: |-
        {
          "chart": { "type": "solidgauge" },
          "yAxis": [{ "min": 0, "max": 1 }],
          "pane": {
            "center": ["50%", "85%"],
            "size": "140%",
            "startAngle": -90,
            "endAngle": 90,
            "background": {
              "innerRadius": "60%",
              "outerRadius": "100%",
              "shape": "arc"
            }
          }
        }
      row: 22
      col: 0
      width: 6
      height: 8

    - name: chart_mid_market_east
      title: "Mid Market East Team - Sales vs Quota"
      model: gtm_analytics
      explore: fct_quota
      type: looker_bar
      fields: [dim_user.full_name, fct_opportunity_split.won_amount, fct_quota.total_quota_amount]
      filters:
        fct_quota.sales_team: "Mid Market East"
      sorts: ["fct_opportunity_split.won_amount desc"]
      limit: 500
      column_limit: 50
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_types:
        fct_quota.total_quota_amount: scatter
      advanced_vis_config: |-
        {
          "series": [
            {},
            {
              "marker": {
                "symbol": "url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0IiBoZWlnaHQ9IjMwIj48cmVjdCB3aWR0aD0iNCIgaGVpZ2h0PSIzMCIgZmlsbD0iIzAwMDAwMCIvPjwvc3ZnPg==)"
              },
              "dataLabels": {
                "enabled": false
              }
            }
          ]
        }
      x_axis_gridlines: false
      y_axis_gridlines: false
      show_view_names: false
      show_y_axis_labels: false
      show_y_axis_ticks: false
      y_axis_tick_density: default
      show_x_axis_label: false
      show_x_axis_ticks: false
      x_axis_label: "Sales Rep"
      legend_position: bottom
      point_style: none
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: #808080
      series_colors:
        fct_opportunity_split.won_amount: #1A73E8
        fct_quota.total_quota_amount: #34A853
      series_labels:
        fct_opportunity_split.won_amount: "Closed Won Sales ($)"
        fct_quota.total_quota_amount: "Quota ($)"
      row: 22
      col: 6
      width: 8
      height: 8

    - name: table_mid_market_east
      title: "Mid Market East Team - Quota Attainment Summary"
      model: gtm_analytics
      explore: fct_quota
      type: looker_grid
      fields: [dim_user.full_name, dim_user.region, fct_quota.total_quota_amount, fct_opportunity_split.won_amount, fct_opportunity_split.attainment_percent, fct_opportunity_split.gap_to_quota]
      filters:
        fct_quota.sales_team: "Mid Market East"
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
      series_cell_visualizations:
        fct_quota.total_quota_amount:
          is_active: false
        fct_opportunity_split.won_amount:
          is_active: false
        fct_opportunity_split.attainment_percent:
          is_active: true
        fct_opportunity_split.gap_to_quota:
          is_active: false
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_labels:
        dim_user.full_name: "Sales Rep"
        dim_user.region: Region
        fct_quota.total_quota_amount: Quota
        fct_opportunity_split.won_amount: "Closed Won Sales"
        fct_opportunity_split.attainment_percent: "Attainment %"
        fct_opportunity_split.gap_to_quota: "Gap to Quota"
      row: 22
      col: 14
      width: 10
      height: 8

    - name: header_mid_market_west
      type: text
      title_text: "Team: Mid Market West"
      row: 30
      col: 0
      width: 24
      height: 2

    - name: gauge_mid_market_west
      title: "Mid Market West - Team Attainment"
      model: gtm_analytics
      explore: fct_quota
      type: looker_column
      fields: [fct_opportunity_split.manager_attainment_percent]
      filters:
        fct_quota.sales_team: "Mid Market West"
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      advanced_vis_config: |-
        {
          "chart": { "type": "solidgauge" },
          "yAxis": [{ "min": 0, "max": 1 }],
          "pane": {
            "center": ["50%", "85%"],
            "size": "140%",
            "startAngle": -90,
            "endAngle": 90,
            "background": {
              "innerRadius": "60%",
              "outerRadius": "100%",
              "shape": "arc"
            }
          }
        }
      row: 32
      col: 0
      width: 6
      height: 8

    - name: chart_mid_market_west
      title: "Mid Market West Team - Sales vs Quota"
      model: gtm_analytics
      explore: fct_quota
      type: looker_bar
      fields: [dim_user.full_name, fct_opportunity_split.won_amount, fct_quota.total_quota_amount]
      filters:
        fct_quota.sales_team: "Mid Market West"
      sorts: ["fct_opportunity_split.won_amount desc"]
      limit: 500
      column_limit: 50
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_types:
        fct_quota.total_quota_amount: scatter
      advanced_vis_config: |-
        {
          "series": [
            {},
            {
              "marker": {
                "symbol": "url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0IiBoZWlnaHQ9IjMwIj48cmVjdCB3aWR0aD0iNCIgaGVpZ2h0PSIzMCIgZmlsbD0iIzAwMDAwMCIvPjwvc3ZnPg==)"
              },
              "dataLabels": {
                "enabled": false
              }
            }
          ]
        }
      x_axis_gridlines: false
      y_axis_gridlines: false
      show_view_names: false
      show_y_axis_labels: false
      show_y_axis_ticks: false
      y_axis_tick_density: default
      show_x_axis_label: false
      show_x_axis_ticks: false
      x_axis_label: "Sales Rep"
      legend_position: bottom
      point_style: none
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: #808080
      series_colors:
        fct_opportunity_split.won_amount: #1A73E8
        fct_quota.total_quota_amount: #34A853
      series_labels:
        fct_opportunity_split.won_amount: "Closed Won Sales ($)"
        fct_quota.total_quota_amount: "Quota ($)"
      row: 32
      col: 6
      width: 8
      height: 8

    - name: table_mid_market_west
      title: "Mid Market West Team - Quota Attainment Summary"
      model: gtm_analytics
      explore: fct_quota
      type: looker_grid
      fields: [dim_user.full_name, dim_user.region, fct_quota.total_quota_amount, fct_opportunity_split.won_amount, fct_opportunity_split.attainment_percent, fct_opportunity_split.gap_to_quota]
      filters:
        fct_quota.sales_team: "Mid Market West"
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
      series_cell_visualizations:
        fct_quota.total_quota_amount:
          is_active: false
        fct_opportunity_split.won_amount:
          is_active: false
        fct_opportunity_split.attainment_percent:
          is_active: true
        fct_opportunity_split.gap_to_quota:
          is_active: false
      listen:
        Quota Year: fct_quota.quota_date_year
        Quota Type: fct_quota.quota_type
      series_labels:
        dim_user.full_name: "Sales Rep"
        dim_user.region: Region
        fct_quota.total_quota_amount: Quota
        fct_opportunity_split.won_amount: "Closed Won Sales"
        fct_opportunity_split.attainment_percent: "Attainment %"
        fct_opportunity_split.gap_to_quota: "Gap to Quota"
      row: 32
      col: 14
      width: 10
      height: 8
