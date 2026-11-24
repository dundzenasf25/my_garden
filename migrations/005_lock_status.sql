CREATE TABLE bed_log_new (
    log_id   INTEGER PRIMARY KEY,
    bed_id   INTEGER NOT NULL REFERENCES bed(bed_id),
    log_date TEXT,
    status   TEXT CHECK (
        status IN (
            'seeded',
            'sprouting',
            'harvesting',
            'fallow',
            'failed'
        )
    )
);

-- 2. Copy every row, preserving its ID.
INSERT INTO bed_log_new (log_id, bed_id, log_date, status)
SELECT log_id, bed_id, log_date, status
FROM bed_log;

-- 3. Remove the old table after copying its rows.
DROP TABLE bed_log;

-- 4. Give the replacement table the original name.
ALTER TABLE bed_log_new RENAME TO bed_log;

