{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}

{%- from tplroot ~ "/map.jinja" import mapdata as cribl_edge with context %}

include:
  - {{ sls_package_install }}

Cribl-Edge Nuke Default Log-Dir:
  file.absent:
    - name: '{{ cribl_edge.package.install_path }}/log'
    - onlyif:
      - '[[ -d {{ cribl_edge.package.install_path }}/log ]]'
    - require:
      - file: Cribl-Edge OS Log-Dir Setup

Cribl-Edge OS Log-Dir Setup:
  file.directory:
    - group: 'root'
    - mode: '0700'
    - name: '/var/log/cribl-edge'
    - require:
      - archive: 'Cribl-Edge Archive Extracted'
    - selinux:
        serange: 's0'
        serole: 'object_r'
        setype: 'lib_t'
        seuser: 'system_u'

Cribl-Edge Symlink to OS Log-Dir:
  file.symlink:
    - group: 'root'
    - makedirs: True
    - mode: '0755'
    - name: '{{ cribl_edge.package.install_path }}/log'
    - require:
      - file: 'Cribl-Edge Nuke Default Log-Dir'
    - target: '/var/log/cribl-edge'
    - user: 'root'
