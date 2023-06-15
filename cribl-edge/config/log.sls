{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}

{%- from tplroot ~ "/map.jinja" import mapdata as cribl_edge with context %}

cribl-edge Nuke Default Log-Dir:
  file.absent:
    - name: '{{ cribl_edge.package.install_path }}/log'
    - onlyif:
      - '[[ -d {{ cribl_edge.package.install_path }}/log ]]'
    - require:
      - file: cribl-edge OS Log-Dir Setup

cribl-edge OS Log-Dir Setup:
  file.directory:
    - group: 'root'
    - mode: '0700'
    - name: '/var/log/cribl-edge'
    - selinux:
        serange: 's0'
        serole: 'object_r'
        setype: 'lib_t'
        seuser: 'system_u'

cribl-edge Symlink to OS Log-Dir:
  file.symlink:
    - group: 'root'
    - makedirs: True
    - mode: '0755'
    - name: '{{ cribl_edge.package.install_path }}/log'
    - require:
      - file: 'cribl-edge Nuke Default Log-Dir'
    - target: '/var/log/cribl-edge'
    - user: 'root'
