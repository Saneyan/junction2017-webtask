-- Exported from QuickDBD: https://www.quickdatatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/schema/y_gG4jH7K0yhJNpoietgEQ
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

BEGIN;
CREATE TABLE "user" (
    "id" int  NOT NULL ,
    "name" varchar  NOT NULL ,
    "age" varchar  NOT NULL ,
    "job_track" int  NOT NULL ,
    "email" varchar  NOT NULL ,
    "facebook_id" varchar  NOT NULL ,
    CONSTRAINT "pk_user" PRIMARY KEY ( "id" )
);

CREATE TABLE "employer" (
    "id" int  NOT NULL ,
    "user_id" int  NOT NULL ,
    "name_of_company" varchar  NOT NULL ,
    CONSTRAINT "pk_employer" PRIMARY KEY ( "id" )
);

CREATE TABLE "job_seeker" (
    "id" int  NOT NULL ,
    "user_id" int  NOT NULL ,
    "nation_currently_stay" varchar  NOT NULL ,
    "current_job_type" int  NOT NULL ,
    CONSTRAINT "pk_job_seeker" PRIMARY KEY ( "id" )
);

CREATE TABLE "question" (
    "id" int  NOT NULL ,
    "content" varchar  NOT NULL ,
    CONSTRAINT "pk_question" PRIMARY KEY ( "id" )
);

CREATE TABLE "option" (
    "id" int  NOT NULL ,
    "question_id" int  NOT NULL ,
    "content" varchar  NOT NULL ,
    CONSTRAINT "pk_option" PRIMARY KEY ( "id" )
);

CREATE TABLE "answer" (
    "id" int  NOT NULL ,
    "option_id" int  NOT NULL ,
    "user_id" int  NOT NULL ,
    CONSTRAINT "pk_answer" PRIMARY KEY ( "id" )
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
