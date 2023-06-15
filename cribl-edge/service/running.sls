{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- set sls_package_runmode = tplroot ~ '.config.run-mode' %}

{%- from tplroot ~ "/map.jinja" import mapdata as cribl_edge with context %}

include:
  - {{ sls_package_install }}
  - {{ sls_package_runmode }}

cribl-edge Configure systemd:
  cmd.run:
    - name: '{{ cribl_edge.package.install_path }}/bin/cribl boot-start enable -m systemd'
    - require:
      - archive: 'Cribl-Edge Archive Extracted'
      - cmd: 'cribl-edge Set Run-mode'
    - unless:
      - '[[ $( systemctl is-enabled cribl-edge.service ) == "enabled" ]]'

cribl-edge Start systemd Unit:
  service.running:
    - enable: True
    - name: 'cribl-edge.service'
    - require:
      - cmd: cribl-edge Set-up systemd Unit
    - unless:
      - '[[ $( systemctl is-active cribl-edge.service ) == "active" ]]'
