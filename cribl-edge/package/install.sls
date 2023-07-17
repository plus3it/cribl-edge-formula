{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}

{%- from tplroot ~ "/map.jinja" import mapdata as cribl_edge with context %}

Cribl-Edge Dependencies Installed:
  pkg.installed:
    - pkgs:
      - curl
      - gzip

Cribl-Edge Archive Extracted:
  archive.extracted:
    - enforce_toplevel: False
    - group: 'root'
    - keep_source: False
    - name: '{{ cribl_edge.package.install_path }}'
    - options: '-C {{ cribl_edge.package.install_path }} --strip-components=1'
    - require:
      - pkg: 'Cribl-Edge Dependencies Installed'
    - skip_verify: True
    - source_hash: '{{ cribl_edge.package.archive.source_hash }}'
    - source: '{{ cribl_edge.package.archive.source }}'
    - trim_output: True
    - user: 'root'
