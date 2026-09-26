CREATE TYPE job_app_stage AS ENUM ('applied', 'interviewing', 'offer', 'ghosted', 'rejected');
CREATE TABLE job_apps (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint NOT NULL REFERENCES users(id),
    company varchar NOT NULL,
    position varchar NOT NULL,
    url varchar,
    hr_contact varchar,
    commentary text,
    current_stage job_app_stage NOT NULL,
    applied_at date NOT NULL
);

CREATE INDEX idx_job_apps_applied_at ON job_apps (applied_at);
