from jinja2 import Environment
from jinja2 import FileSystemLoader
from jinja2 import StrictUndefined

from pathlib import Path

TEMPLATE_DIR = Path("./tpl")

if __name__ == "__main__":
    template_env = Environment(
        loader=FileSystemLoader(TEMPLATE_DIR),
        undefined=StrictUndefined,
    )

    load_tpl = template_env.get_template("BFMcoupler_LOAD.h.tpl")
    load_target = load_tpl.render(n_tracers=2)

    size_tpl = template_env.get_template("BFMcoupler_SIZE.h.tpl")
    size_target = size_tpl.render(n_tracers=2)
    
    vars_tpl = template_env.get_template("BFMcoupler_VARS.h.tpl")
    vars_target = vars_tpl.render(n_tracers=2)
    
    calc_tendency_tpl = template_env.get_template("BFMcoupler_calc_tendency.F.tpl")
    calc_tendency_target = calc_tendency_tpl.render(n_tracers=2)

    fields_load_tpl = template_env.get_template("BFMcoupler_fields_load.F.tpl")
    fields_local_target = fields_load_tpl.render(n_tracers=2)

    ini_forcing_tpl = template_env.get_template("BFMcoupler_ini_forcing.F.tpl")
    ini_forcing_target = ini_forcing_tpl.render(n_tracers=2)

    readparams_tpl = template_env.get_template("BFMcoupler_readparams.F.tpl")
    readparams_target = readparams_tpl.render(n_tracers=2)
    print(readparams_target)
