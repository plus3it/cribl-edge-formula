{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}

{%- from tplroot ~ "/map.jinja" import mapdata as cribl_edge with context %}

Cribl-Edge Service Dead:
  service.dead:
    - name: {{ cribl_edge.service.name }}
    - enable: False
