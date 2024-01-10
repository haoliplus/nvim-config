from pathlib import Path
import json
import argparse


def pase_snip(path):
    # Read the file
    snip_pairs = []
    new_snip_file_content = {}
    with path.open() as file:
        lines = file.readlines()
        lines = [line.strip() for line in lines]
        pair = []
        for lino, line in enumerate(lines):
            if line.startswith('snippet'):
                pair.append(lino)
            if line.startswith('endsnippet'):
                pair.append(lino)
                snip_pairs.append(pair)
                assert len(pair) == 2, f"{lino} {line}"
                pair = []
        for pair in snip_pairs:
            define = lines[pair[0]]
            if '"' not in define:
                description = ""
            else:
                description = define.split('"')[1]
            prefix = define.split(" ")[1]
            body = lines[pair[0]+1:pair[1]]
            entry = {

                'prefix': prefix,
                'body': body,
                'description': description
            }
            new_snip_file_content[prefix] = entry
    print(json.dumps(new_snip_file_content, indent=2))


if __name__ == '__main__':
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('path', type=str)
    # Path to the file
    path = Path(arg_parser.parse_args().path)
    print(f"using {path}")
    pase_snip(path)

