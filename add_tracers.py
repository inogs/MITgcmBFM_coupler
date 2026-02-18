from jinja2 import Environment
from jinja2 import FileSystemLoader
from jinja2 import StrictUndefined

from pathlib import Path
import shutil
from argparse import ArgumentParser

TEMPLATE_DIR = Path("./tpl")

TARGET_TPL = [
    Path("BFMcoupler_LOAD.h.tpl"),
    Path("BFMcoupler_SIZE.h.tpl"),
    Path("BFMcoupler_VARS.h.tpl"),
    Path("BFMcoupler_calc_tendency.F.tpl"),
    Path("BFMcoupler_fields_load.F.tpl"),
    Path("BFMcoupler_ini_forcing.F.tpl"),
    Path("BFMcoupler_readparams.F.tpl"),
    Path("BFMcoupler_tr_register.F.tpl"),
    Path("BFMcoupler_exf_load.F.tpl"),
]

TARGET_STATIC = [
    Path("BFMcoupler_init_fixed.F"),
    Path("BFMcoupler_OPTIONS.h"),
    Path("exf_set_BFMcoupler.F"),
]

def copy_static(dest_dir: Path):
    for file in TARGET_STATIC:
        shutil.copy2(file, dest_dir / file)


def write_templates(dest_dir: Path, n_tracers: int):
    template_env = Environment(
        loader=FileSystemLoader(TEMPLATE_DIR),
        undefined=StrictUndefined,
    )

    for file in TARGET_TPL:
        tpl = template_env.get_template(file.as_posix())
        target = dest_dir / file.stem
        target.write_text(tpl.render(n_tracers=n_tracers))


if __name__ == "__main__":
    parser = ArgumentParser(prog="Tracers patcher")
    parser.add_argument(
        "--outdir",
        "-o",
        type=Path,
        required=True,
        help="Destination directory",
    )
    parser.add_argument(
        "-n",
        type=int,
        required=True,
        help="Number of tracers to add",
    )

    args = parser.parse_args()

    copy_static(args.outdir)
    write_templates(args.outdir, args.n)
