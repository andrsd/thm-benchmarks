#!/usr/bin/env python3

import jinja2
import argparse
import os
import sys
import importlib

parser = argparse.ArgumentParser(
    prog = 'gen.py',
    description = 'Generate input file for benchmarking THM'
)

parser.add_argument(
    '--loc',
    '-l',
    dest = 'location',
    help = 'Location to search for templates'
)

parser.add_argument(
    '--base',
    '-b',
    dest = 'base',
    help = 'File name with the base template'
)

parser.add_argument(
    '--template',
    '-t',
    dest = 'templ',
    help = 'File name with the template containing components'
)

parser.add_argument(
    '--file',
    '-f',
    dest = 'file',
    help = 'File name additional parameters'
)

parser.add_argument(
    'params',
    nargs = '*',
    help = 'Parameters passed into the template.'
)

args = parser.parse_args()

# parameters that will be passed into the template
templ_params = {
    'nl_abs_tol': 1e-5
}

if args.file is not None:
    directory, file_name = os.path.split(args.file)
    module_name, ext = os.path.splitext(args.file)
    sys.path.append(directory)
    temp = importlib.import_module(module_name)
    sys.path.remove(directory)

    # store variables into template parameters
    obj_names = [a for a in dir(temp) if not a.startswith('__')]
    for name in obj_names:
        attr = getattr(temp, name)
        if not callable(attr):
            templ_params[name] = attr

# process parameters passed via command line
for str_param in vars(args)['params']:
    # FIXME: to a regexp here instead of a split
    (name, value) = str_param.split('=')
    templ_params[name] = value


tmpl_loader = jinja2.FileSystemLoader(searchpath=args.location)
tmpl_env = jinja2.Environment(loader=tmpl_loader)

# render the full input file
petsc_options = {
    '-pc_factor_mat_solver_type': 'mumps',
    #'-pc_factor_mat_solver_type': 'superlu_dist',
    '-pc_type': 'lu'
}

if args.base is not None:
    # render the "component" part
    comps_templ = tmpl_env.get_template(args.templ)
    comps = comps_templ.render(templ_params)

    base = tmpl_env.get_template(args.base)
    out = base.render(
        templ_params,
        comps=comps,
        petsc_options_iname="'" + ' '.join(petsc_options.keys()) + "'",
        petsc_options_value="'" + ' '.join(petsc_options.values()) + "'",
    )
else:
    templ = tmpl_env.get_template(args.templ)
    out = templ.render(
        templ_params,
        petsc_options_iname="'" + ' '.join(petsc_options.keys()) + "'",
        petsc_options_value="'" + ' '.join(petsc_options.values()) + "'",
    )

print(out)
