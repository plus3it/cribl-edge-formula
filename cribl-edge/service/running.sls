{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- set sls_package_runmode = tplroot ~ '.config.run-mode' %}

{%- from tplroot ~ "/map.jinja" import mapdata as cribl_edge with context %}

include:
  - {{ sls_package_install }}
  - {{ sls_package_runmode }}

Cribl-Edge Configure systemd Unit:
  cmd.run:
    - name: '{{ cribl_edge.package.install_path }}/bin/cribl boot-start enable -m systemd'
    - require:
      - archive: 'Cribl-Edge Archive Extracted'
      - cmd: 'Cribl-Edge Set Run-mode'
    - unless:
      - '[[ $( systemctl is-enabled {{ cribl_edge.service.name }} ) == "enabled" ]]'

Cribl-Edge Start systemd Unit:
  service.running:
    - enable: True
    - name: '{{ cribl_edge.service.name }}'
    - require:
      - cmd: 'Cribl-Edge Configure systemd Unit'
    - unless:
      - '[[ $( systemctl is-active {{ cribl_edge.service.name }} ) == "active" ]]'
