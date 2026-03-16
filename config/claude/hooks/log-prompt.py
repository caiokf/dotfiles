#!/usr/bin/env python3
import json
import sqlite3
import sys
from datetime import datetime, timezone
from pathlib import Path

DB_PATH = "/Users/caiokf/.agents/prompts.db"
SETTINGS_PATH = "/Users/caiokf/.agents/settings.json"

def init_db(conn):
    conn.execute("""
        CREATE TABLE IF NOT EXISTS prompts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT NOT NULL,
            session_id TEXT,
            cwd TEXT,
            model TEXT,
            prompt TEXT NOT NULL
        )
    """)
    conn.commit()

def migrate_db(conn):
    cursor = conn.execute("PRAGMA table_info(prompts)")
    columns = [row[1] for row in cursor.fetchall()]
    if "model" not in columns:
        conn.execute("ALTER TABLE prompts ADD COLUMN model TEXT")
        conn.commit()

def get_model():
    try:
        settings = json.loads(Path(SETTINGS_PATH).read_text())
        return settings.get("sessionDefaultSettings", {}).get("model", "")
    except (json.JSONDecodeError, FileNotFoundError, OSError):
        return ""

try:
    input_data = json.load(sys.stdin)
except json.JSONDecodeError:
    sys.exit(1)

prompt = input_data.get("prompt", "")
if not prompt:
    sys.exit(0)

session_id = input_data.get("session_id", "")
cwd = input_data.get("cwd", "")
model = get_model()
timestamp = datetime.now(timezone.utc).isoformat()

conn = sqlite3.connect(DB_PATH)
init_db(conn)
migrate_db(conn)
conn.execute(
    "INSERT INTO prompts (timestamp, session_id, cwd, model, prompt) VALUES (?, ?, ?, ?, ?)",
    (timestamp, session_id, cwd, model, prompt),
)
conn.commit()
conn.close()

sys.exit(0)
