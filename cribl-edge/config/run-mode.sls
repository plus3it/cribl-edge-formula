{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}

{%- from tplroot ~ "/map.jinja" import mapdata as cribl_edge with context %}

include:
  - {{ sls_package_install }}

Cribl-Edge Set Run-mode:
  cmd.run:
    - name: '{{ cribl_edge.package.install_path }}/bin/cribl mode-edge'
    - require:
      - archive: 'Cribl-Edge Archive Extracted'
      - file: 'Cribl-Edge Symlink to OS Log-Dir'
    - onlyif:
      - [[ $( /opt/cribl-edge/bin/cribl status ) == "Cribl is not running" ]]
