#!/data/data/com.termux/files/usr/bin/bash
# Build ecosystem-wide registries from per-project .skb/*.json
# Output: registry/ecosystem.json, modules.json, assets.json

set -e
SKB_HOME="$HOME"
OUT="$(dirname "$0")"

python3 - <<'PYEOF'
import json, os, glob
from datetime import datetime

HOME = os.path.expanduser("~")
OUT  = os.path.join(HOME, "SKB-Dev", "registry")

projects = []
modules_all = []
assets_all = []

# Discover all .skb/ projects
for proj_dir in sorted(glob.glob(os.path.join(HOME, "*", ".skb"))):
    root = os.path.dirname(proj_dir)
    name = os.path.basename(root)
    if name.startswith('.'): continue

    def load(f):
        p = os.path.join(proj_dir, f)
        if not os.path.exists(p): return None
        try:
            with open(p) as fh: return json.load(fh)
        except Exception as e:
            return {"_error": str(e)}

    proj = load("project.json")
    if not proj or proj.get("schema") != "skb/v1":
        continue

    mods = load("modules.json") or {"modules": []}
    assets = load("assets.json") or {"assets": []}

    # Aggregate
    for m in mods.get("modules", []):
        m_copy = dict(m)
        m_copy["_project"] = name
        m_copy["_project_id"] = proj.get("id")
        modules_all.append(m_copy)

    for a in assets.get("assets", []):
        a_copy = dict(a)
        a_copy["_project"] = name
        a_copy["_project_id"] = proj.get("id")
        assets_all.append(a_copy)

    # Index entry
    projects.append({
        "name": name,
        "id": proj.get("id"),
        "type": proj.get("type"),
        "version": proj.get("version"),
        "status": proj.get("status"),
        "path": root,
        "repo": proj.get("repo", {}).get("remote"),
        "stack_count": len(proj.get("stack", [])),
        "module_count": len(mods.get("modules", [])),
        "asset_count": len(assets.get("assets", []))
    })

# Write ecosystem.json
ecosystem = {
    "schema": "skb/v1",
    "generated": datetime.now().isoformat(),
    "project_count": len(projects),
    "module_count": len(modules_all),
    "asset_count": len(assets_all),
    "projects": projects
}
with open(os.path.join(OUT, "ecosystem.json"), "w") as f:
    json.dump(ecosystem, f, indent=2)

# Write merged modules.json
with open(os.path.join(OUT, "modules.json"), "w") as f:
    json.dump({
        "schema": "skb/v1",
        "generated": datetime.now().isoformat(),
        "count": len(modules_all),
        "modules": modules_all
    }, f, indent=2)

# Write merged assets.json
with open(os.path.join(OUT, "assets.json"), "w") as f:
    json.dump({
        "schema": "skb/v1",
        "generated": datetime.now().isoformat(),
        "count": len(assets_all),
        "assets": assets_all
    }, f, indent=2)

# Write schema.json — the lock
with open(os.path.join(OUT, "schema.json"), "w") as f:
    json.dump({
        "schema": "skb/v1",
        "locked": "2026-09-16",
        "projects": len(projects),
        "files_per_project": 6,
        "required_files": [
            "project.json", "state.json", "history.json",
            "config.json", "modules.json", "assets.json"
        ]
    }, f, indent=2)

print(f"✅ ecosystem.json   — {len(projects)} projects")
print(f"✅ modules.json     — {len(modules_all)} modules")
print(f"✅ assets.json      — {len(assets_all)} assets")
print(f"✅ schema.json      — v1 locked")
PYEOF
