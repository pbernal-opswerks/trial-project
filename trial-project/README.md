# Mini Project 1 — Employee Shift Scheduler

This repository contains a **Bash-based employee shift scheduler** with strict constraints, JSON persistence, and Dockerization.  
It was built as part of **The Academy: Mini Project 1**.

---

## Features
- Accepts input: **Employee Name**, **Shift** (`morning|mid|night`), **Team** (`A1..B3`).
- Enforces **max 2 employees per shift per team**.
- Stores data in a **JSON file** for persistence.
- Type `print` as employee name → displays current table and exits.
- Docker-ready with volume mounts.

---

## Quick Start (Docker)

```bash
docker build -t shift-scheduler .
mkdir -p ./data
docker run --rm -it -v "$PWD/data:/data" shift-scheduler
```

---

## Local Run (without Docker)
Requires `bash` + `jq`.

```bash
chmod +x shift_manager.sh
export DATA_FILE="$PWD/data/shifts.json"
mkdir -p data
./shift_manager.sh
```

---

## Automated Tests

We provide test scripts under the `tests/` folder.

### Happy Path Test
Runs two valid employee inserts and prints schedule.

```bash
cd tests
chmod +x happy_path.sh
./happy_path.sh
```

Expected: Table shows Alice & Bob in Team A1 (morning).

### Unhappy Path Test
Runs three inserts in the same team/shift → triggers limit error.

```bash
cd tests
chmod +x unhappy_path.sh
./unhappy_path.sh
```

Expected: Error: maximum employees per shift reached.

---

## Git Workflow (Team Requirements)
- Use a **private GitHub repo** as main.
- Each teammate forks → works on branches → opens Pull Requests.
- No direct commits to `main` branch.
- Example branches:
  - `feature/script-core`
  - `feature/json-persistence`
  - `feature/print-table`
  - `feature/dockerization`
  - `docs/readme-and-tests`

---

## Deliverables
- `shift_manager.sh` — Bash scheduler script
- `tests/` — automated test scripts
- `Dockerfile` — container build
- `docker-compose.yml` — optional
- `README.md` — this file
