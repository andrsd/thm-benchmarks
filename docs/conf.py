import os
import sys
import subprocess

project = 'Thermal Hydraulics Module Benchmarks'
copyright = '2022, David Andrs'
author = 'David Andrs'

extensions = [
    'matplotlib.sphinxext.plot_directive',
    'sphinx_tabs.tabs'
]

templates_path = ['_templates']

exclude_patterns = []

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
html_show_sourcelink = False
