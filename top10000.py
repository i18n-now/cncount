#!/usr/bin/env python

from os.path import dirname, join
from json import load, dumps

ROOT = dirname(__file__)
with open(join(ROOT, "count.json")) as f:
    json = [i[0] for i in load(f)]
    s = "".join(json[:10000])
    with open(join(ROOT, "top10000.js"), "w") as f:
        f.write("export default " + dumps(s, ensure_ascii=False))
