#!/usr/bin/env python3


import json
import jsonschema
from time import sleep


def main():

    # The sleep is necessary to bypass a clock skew problem on HPC filesystems.
    # See
    # https://github.com/snakemake/snakemake/issues/3261#issuecomment-2663727316
    # and
    # https://github.com/snakemake/snakemake/issues/3254#issuecomment-2598641487.
    sleep(5)

    stats = snakemake.params.get("stats", {})

    with open(snakemake.input["stats_schema"], "r") as f:
        schema = json.load(f)

    jsonschema.validate(instance=stats, schema=schema)

    with open(snakemake.output.stats_json, "w") as outfile:
        json.dump(stats, outfile)
        outfile.write("\n")


if __name__ == "__main__":
    main()
