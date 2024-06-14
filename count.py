#!/usr/bin/env python

from collections import defaultdict
import zd
from fire import Fire
from json import dump, loads
from os.path import dirname, join
import os


@Fire
def main(fp):
    n = 0
    root = dirname(__file__)
    counter = defaultdict(int)

    with zd.open(fp) as f:
        for txt in f:
            n += 1
            for i in txt:
                counter[i] += 1
            if n % 50000 == 0:
                print(n)
    tmp = join(root, "tmp")
    for filename in os.listdir(tmp):
        if filename.endswith(".json"):
            filepath = join(tmp, filename)
            with open(filepath, "r", encoding="utf-8") as file:
                for line in file:
                    if line:
                        n += 1
                        if n % 50000 == 0:
                            print(n)
                        data = loads(line)
                        for key in ["title", "answer", "content"]:
                            t = data.get(key)
                            if t:
                                for i in t:
                                    counter[i] += 1
    li = sorted(list(counter.items()), key=lambda x: x[1], reverse=True)
    with open(join(root, "count.json"), "w") as f:
        dump(li, f, ensure_ascii=False)
