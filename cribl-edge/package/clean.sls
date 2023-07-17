{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}

{%- from tplroot ~ "/map.jinja" import mapdata as cribl_edge with context %}

Cribl-Edge App-Dir Removed:
  file.absent:
    - name: {{ cribl_edge.package.install_path }}
    - onlyif:
      - '[[ -d {{ cribl_edge.package.install_path }} ]]'

Cribl-Edge Log-Dir Removed:
  file.absent:
    - name: {{ cribl_edge.package.real_log_dir }}
    - onchanges:
      - file: Cribl-Edge App-Dir Removed
