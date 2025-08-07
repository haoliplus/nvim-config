# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "loguru",
# ]
# ///

from pathlib import Path
import json
from loguru import logger

def main():
    workding_dir = Path(__file__).parent
    logger.info(f"Working directory: {workding_dir}")
    package_json_path = workding_dir / "package.json"
    if not package_json_path.exists():
        logger.error(f"package.json not found in {workding_dir}")
        return
    try:
        with package_json_path.open("r", encoding="utf-8") as f:
            package_data = json.load(f)
    except json.JSONDecodeError as e:
        logger.error(f"Error decoding JSON in package.json: {e}")
        return
    name = package_data.get("name", "unknown")
    contributes = package_data.get("contributes", {"snippets": []})
    snips = contributes.get("snippets", [])
    for snip in snips:
        if not isinstance(snip, dict):
            logger.error(f"Invalid snippet format: {snip}")
            continue
        language = snip.get("language", "unknown")
        path = snip.get("path", "")
        try:
            json.load(open(workding_dir / path, "r", encoding="utf-8"))
        except json.JSONDecodeError as e:
            logger.error(f"Error decoding JSON in {path}: {e}")
            logger.error(f"Snippet '{snip.get('name', 'unknown')}' in {language} by {name} is invalid.")
            continue
        logger.info(f"Snippet '{snip.get('path', 'unknown')}' in {language} by {name} is valid.")


if __name__ == "__main__":
    main()

