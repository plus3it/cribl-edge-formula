{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}

{%- from tplroot ~ "/map.jinja" import mapdata as cribl_edge with context %}

Cribl-Edge Service Dead:
  service.dead:
    - name: {{ cribl_edge.service.name }}
    - enable: False

Cribl-Edge Delete Unit-File:
  file.absent:
    - name: {{ cribl_edge.service.unit_file }}
    - onchanges:
      - service: Cribl-Edge Service Dead

Cribl-Edge Clean-Reload:
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: Cribl-Edge Delete Unit-File
