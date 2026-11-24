-- 006: restrict sunlight values

-- bed_log references bed, so temporarily disable foreign keys
-- while replacing the parent table.
PRAGMA foreign_keys = OFF;

-- 1. Create the replacement with all four columns.
CREATE TABLE bed_new (
    bed_id   INTEGER PRIMARY KEY,
    crop     TEXT NOT NULL,
    location TEXT,
    sun      TEXT CHECK (
        sun IN ('full sun', 'part shade', 'shade')
    )
);

-- 2. Copy the rows, preserving bed IDs.
INSERT INTO bed_new (bed_id, crop, location, sun)
SELECT bed_id, crop, location, sun
FROM bed;

-- 3. Remove the old table.
DROP TABLE bed;

-- 4. Rename the replacement.
ALTER TABLE bed_new RENAME TO bed;

PRAGMA foreign_keys = ON;

