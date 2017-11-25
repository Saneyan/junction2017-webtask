"use strict";

const pg = require('pg')
const _ = require('lodash')

module.exports = async function (context, cb) {
  const pool = new pg.Pool({
    user: context.secrets.PGUSER,
    host: context.secrets.PGHOST,
    database: context.secrets.PGDATABASE,
    password: context.secrets.PGPASSWORD,
    port: context.secrets.PGPORT
  });

  const nextQuestionId = parseInt(context.data.question_id) || 0;
  const answeredOptionId = parseInt(context.data.option_id) || null;

  let selectQuery = `
    SELECT
      q.content AS question_content,
      o.content AS option_content,
      o.id AS option_id,
      q.id AS question_id
    FROM question as q, option as o
    WHERE q.id = o.question_id
    AND q.id = ${nextQuestionId+1}
  `.trim().replace(/\s+/gi, " ");

  try {
    const res = await pool.query(selectQuery);

    let insertQuery
    if (answeredOptionId) {
      insertQuery = `
        INSERT INTO answer(user_id, option_id)
        VALUES(1, ${answeredOptionId})
      `.trim().replace(/\s+/gi, " ");
      await pool.query(insertQuery)
    }

    pool.end();

    // parse response
    let next;
    if (res && res.rows && res.rows.length > 0) {
      next = {
        question_id: res.rows[0].question_id,
        question_content: res.rows[0].question_content,
        options: res.rows.map((row) => _.pick(row, ['option_id', 'option_content']))
      }
    }
    // TODO: add new answer if given in request body
    // TODO: don't give query or error on production
    const response = { next, q: [selectQuery, insertQuery] }
    cb(null, response);
  } catch (err) {
    cb(null, err);
  }
}
