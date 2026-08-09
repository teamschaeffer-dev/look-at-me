import json

managers = ['Chris Welch', 'Ian Race', 'Jim Oakes', 'Jennifer Marsland']

dashboard = {
    'dashboard': 'sales_rep_performance',
    'title': 'Sales Rep Performance',
    'layout': 'newspaper',
    'preferred_viewer': 'dashboards-next',
    'description': 'Tracks Closed Won sales versus quota for each sales rep.',
    'filters': [
        {
            'name': 'Quota Year',
            'title': 'Quota Year',
            'type': 'field_filter',
            'default_value': 'this year',
            'allow_multiple_values': True,
            'required': False,
            'ui_config': {'type': 'advanced', 'display': 'popover'},
            'model': 'gtm_analytics',
            'explore': 'fct_quota',
            'field': 'fct_quota.quota_date_year'
        },
        {
            'name': 'Quota Type',
            'title': 'Quota Type',
            'type': 'field_filter',
            'default_value': 'Full Quota',
            'allow_multiple_values': False,
            'required': True,
            'ui_config': {'type': 'dropdown_menu', 'display': 'inline'},
            'model': 'gtm_analytics',
            'explore': 'fct_quota',
            'field': 'fct_quota.quota_type'
        }
    ],
    'elements': []
}

row_idx = 0
for manager in managers:
    manager_id = manager.lower().replace(' ', '_')
    
    # Header
    dashboard['elements'].append({
        'name': f'header_{manager_id}',
        'type': 'text',
        'title_text': f'Team: {manager}',
        'row': row_idx,
        'col': 0,
        'width': 24,
        'height': 2
    })
    row_idx += 2
    
    # Gauge Chart
    dashboard['elements'].append({
        'name': f'gauge_{manager_id}',
        'title': f'{manager} - Manager Attainment',
        'model': 'gtm_analytics',
        'explore': 'fct_quota',
        'type': 'looker_column',
        'fields': [
            'fct_opportunity_split.manager_attainment_percent'
        ],
        'filters': {'dim_user.manager_name': f'"{manager}"'},
        'listen': {
            'Quota Year': 'fct_quota.quota_date_year',
            'Quota Type': 'fct_quota.quota_type'
        },
        'advanced_vis_config': '|-\n' + ' ' * 8 + '{\n' + ' ' * 8 + '  "chart": { "type": "solidgauge" },\n' + ' ' * 8 + '  "yAxis": [{ "min": 0, "max": 1 }],\n' + ' ' * 8 + '  "pane": {\n' + ' ' * 8 + '    "center": ["50%", "85%"],\n' + ' ' * 8 + '    "size": "140%",\n' + ' ' * 8 + '    "startAngle": -90,\n' + ' ' * 8 + '    "endAngle": 90,\n' + ' ' * 8 + '    "background": {\n' + ' ' * 8 + '      "innerRadius": "60%",\n' + ' ' * 8 + '      "outerRadius": "100%",\n' + ' ' * 8 + '      "shape": "arc"\n' + ' ' * 8 + '    }\n' + ' ' * 8 + '  }\n' + ' ' * 8 + '}',
        'row': row_idx,
        'col': 0,
        'width': 6,
        'height': 8
    })

    # Chart (Looker Bar with Advanced Vis Config)
    dashboard['elements'].append({
        'name': f'chart_{manager_id}',
        'title': f'{manager} Team - Sales vs Quota',
        'model': 'gtm_analytics',
        'explore': 'fct_quota',
        'type': 'looker_bar',
        'fields': [
            'dim_user.full_name',
            'fct_opportunity_split.won_amount',
            'fct_quota.total_quota_amount'
        ],
        'filters': {'dim_user.manager_name': f'"{manager}"'},
        'sorts': ['fct_opportunity_split.won_amount desc'],
        'limit': 500,
        'column_limit': 50,
        'listen': {
            'Quota Year': 'fct_quota.quota_date_year',
            'Quota Type': 'fct_quota.quota_type'
        },
        'series_types': {
            'fct_quota.total_quota_amount': 'scatter'
        },
        'advanced_vis_config': '|-\n' + ' ' * 8 + '{\n' + ' ' * 8 + '  "series": [\n' + ' ' * 8 + '    {},\n' + ' ' * 8 + '    {\n' + ' ' * 8 + '      "marker": {\n' + ' ' * 8 + '        "symbol": "url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0IiBoZWlnaHQ9IjMwIj48cmVjdCB3aWR0aD0iNCIgaGVpZ2h0PSIzMCIgZmlsbD0iIzAwMDAwMCIvPjwvc3ZnPg==)"\n' + ' ' * 8 + '      },\n' + ' ' * 8 + '      "dataLabels": {\n' + ' ' * 8 + '        "enabled": false\n' + ' ' * 8 + '      }\n' + ' ' * 8 + '    }\n' + ' ' * 8 + '  ]\n' + ' ' * 8 + '}',
        'x_axis_gridlines': False,
        'y_axis_gridlines': False,
        'show_view_names': False,
        'show_y_axis_labels': False,
        'show_y_axis_ticks': False,
        'y_axis_tick_density': 'default',
        'show_x_axis_label': False,
        'show_x_axis_ticks': False,
        'x_axis_label': 'Sales Rep',
        'legend_position': 'bottom',
        'point_style': 'none',
        'show_value_labels': True,
        'label_density': 25,
        'x_axis_scale': 'auto',
        'y_axis_combined': True,
        'ordering': 'none',
        'show_null_labels': False,
        'show_totals_labels': False,
        'show_silhouette': False,
        'totals_color': '#808080',
        'series_colors': {
            'fct_opportunity_split.won_amount': '#1A73E8',
            'fct_quota.total_quota_amount': '#34A853'
        },
        'series_labels': {
            'fct_opportunity_split.won_amount': 'Closed Won Sales ($)',
            'fct_quota.total_quota_amount': 'Quota ($)'
        },
        'row': row_idx,
        'col': 6,
        'width': 8,
        'height': 8
    })
    
    # Table (Reverted HTML field)
    dashboard['elements'].append({
        'name': f'table_{manager_id}',
        'title': f'{manager} Team - Quota Attainment Summary',
        'model': 'gtm_analytics',
        'explore': 'fct_quota',
        'type': 'looker_grid',
        'fields': [
            'dim_user.full_name',
            'dim_user.region',
            'fct_quota.total_quota_amount',
            'fct_opportunity_split.won_amount',
            'fct_opportunity_split.attainment_percent',
            'fct_opportunity_split.gap_to_quota'
        ],
        'filters': {'dim_user.manager_name': f'"{manager}"'},
        'sorts': ['fct_opportunity_split.won_amount desc'],
        'limit': 500,
        'column_limit': 50,
        'show_view_names': False,
        'show_row_numbers': True,
        'truncate_column_names': False,
        'hide_totals': False,
        'hide_row_totals': False,
        'table_theme': 'white',
        'limit_displayed_rows': False,
        'enable_conditional_formatting': True,
        'conditional_formatting_include_totals': False,
        'conditional_formatting_include_nulls': False,
        'conditional_formatting': [
            {
                'type': 'along a scale...',
                'value': None,
                'background_color': '#1A73E8',
                'font_color': None,
                'color_application': {
                    'collection_id': '7c5612da-06ff-4abb-8ef7-47b28236d655',
                    'custom': {
                        'id': '5b4e72ce-9257-4ba6-8a7e-1ff9f4305886',
                        'label': 'Custom',
                        'type': 'continuous',
                        'stops': [
                            {'color': '#F9AB00', 'offset': 0},
                            {'color': '#34A853', 'offset': 100}
                        ]
                    }
                },
                'bold': False,
                'italic': False,
                'strikethrough': False,
                'fields': ['fct_opportunity_split.attainment_percent']
            }
        ],
        'series_cell_visualizations': {
            'fct_quota.total_quota_amount': {'is_active': False},
            'fct_opportunity_split.won_amount': {'is_active': False},
            'fct_opportunity_split.attainment_percent': {'is_active': True},
            'fct_opportunity_split.gap_to_quota': {'is_active': False}
        },
        'listen': {
            'Quota Year': 'fct_quota.quota_date_year',
            'Quota Type': 'fct_quota.quota_type'
        },
        'series_labels': {
            'dim_user.full_name': 'Sales Rep',
            'dim_user.region': 'Region',
            'fct_quota.total_quota_amount': 'Quota',
            'fct_opportunity_split.won_amount': 'Closed Won Sales',
            'fct_opportunity_split.attainment_percent': 'Attainment %',
            'fct_opportunity_split.gap_to_quota': 'Gap to Quota'
        },
        'row': row_idx,
        'col': 14,
        'width': 10,
        'height': 8
    })
    row_idx += 8

def list_dict_to_yaml(data):
    lines = []
    lines.append('- dashboard: ' + data['dashboard'])
    lines.append('  title: ' + data['title'])
    lines.append('  layout: ' + data['layout'])
    lines.append('  preferred_viewer: ' + data['preferred_viewer'])
    lines.append('  description: \"' + data['description'] + '\"')
    
    # Simple recursive YAML dumper tailored for LookML
    def dump_val(v, indent=2):
        if isinstance(v, str):
            if v.startswith('|-'):
                return v # Pre-formatted block scalar
            if ':' in v or '{' in v or '}' in v or ' ' in v and not v.startswith('"'):
                return '\"' + v + '\"'
            return v
        if isinstance(v, bool):
            return 'true' if v else 'false'
        if v is None:
            return ''
        return str(v)
    
    def dump_dict(d, indent):
        res = []
        for k, v in d.items():
            ind = ' ' * indent
            if isinstance(v, dict):
                if not v:
                    res.append(f"{ind}{k}: {{}}")
                else:
                    res.append(f"{ind}{k}:")
                    res.extend(dump_dict(v, indent + 2))
            elif isinstance(v, list):
                if not v:
                    res.append(f"{ind}{k}: []")
                elif isinstance(v[0], dict):
                    res.append(f"{ind}{k}:")
                    for item in v:
                        res.append(f"{ind}  -")
                        item_lines = dump_dict(item, indent + 4)
                        # Fix the first line of the item
                        if item_lines:
                            res[-1] = f"{ind}  - {item_lines[0].lstrip()}"
                            res.extend(item_lines[1:])
                else:
                    # simple list
                    list_str = '[' + ', '.join([dump_val(x) for x in v]) + ']'
                    res.append(f"{ind}{k}: {list_str}")
            else:
                if k == 'filters' and isinstance(d, dict):
                     res.append(f"{ind}{k}:")
                elif k == 'advanced_vis_config':
                     res.append(f"{ind}{k}: {v}")
                else:
                    res.append(f"{ind}{k}: {dump_val(v)}")
        return res

    lines.append('')
    lines.append('  filters:')
    for f in data['filters']:
        lines.append('    -')
        flines = dump_dict(f, 6)
        lines[-1] = '    - ' + flines[0].lstrip()
        lines.extend(flines[1:])
        
    lines.append('')
    lines.append('  elements:')
    for el in data['elements']:
        lines.append('    -')
        elines = dump_dict(el, 6)
        lines[-1] = '    - ' + elines[0].lstrip()
        lines.extend(elines[1:])
        lines.append('')

    return '\n'.join(lines)

with open('dashboards/sales_rep_performance.dashboard.lookml', 'w') as f:
    f.write(list_dict_to_yaml(dashboard))
