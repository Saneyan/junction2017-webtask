-- Exported from QuickDBD: https://www.quickdatatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/schema/y_gG4jH7K0yhJNpoietgEQ
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

BEGIN;
CREATE TABLE "user" (
    "id" serial primary key ,
    "name" varchar ,
    "age" int,
    "job_track" int ,
    "email" varchar ,
    "facebook_id" varchar
);

CREATE TABLE "employer" (
    "id" serial primary key ,
    "user_id" int ,
    "name_of_company" varchar
);

CREATE TABLE "job_seeker" (
    "id" serial primary key ,
    "user_id" int ,
    "nation_currently_stay" varchar ,
    "current_job_type" int
);

CREATE TABLE "question" (
    "id" serial primary key ,
    "content" varchar
);

CREATE TABLE "option" (
    "id" serial primary key ,
    "question_id" int ,
    "content" varchar
);

CREATE TABLE "answer" (
    "id" serial primary key ,
    "option_id" int ,
    "user_id" int
);
COMMIT;

ALTER TABLE "employer" ADD CONSTRAINT "fk_employer_user_id" FOREIGN KEY("user_id")
REFERENCES "user" ("id");

ALTER TABLE "job_seeker" ADD CONSTRAINT "fk_job_seeker_user_id" FOREIGN KEY("user_id")
REFERENCES "user" ("id");

ALTER TABLE "option" ADD CONSTRAINT "fk_option_question_id" FOREIGN KEY("question_id")
REFERENCES "question" ("id");

ALTER TABLE "answer" ADD CONSTRAINT "fk_answer_option_id" FOREIGN KEY("option_id")
REFERENCES "option" ("id");

ALTER TABLE "answer" ADD CONSTRAINT "fk_answer_user_id" FOREIGN KEY("user_id")
REFERENCES "user" ("id");
