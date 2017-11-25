"use strict";

const pg = require('pg')
const _ = require('lodash')

module.exports = function (context, cb) {
  const pool = new pg.Pool({
    user: context.secrets.PGUSER,
    host: context.secrets.PGHOST,
    database: context.secrets.PGDATABASE,
    password: context.secrets.PGPASSWORD,
    port: context.secrets.PGPORT
  });

  const nextQuestionId = context.data.question_id || 0;

  let query = `
    SELECT
      q.content AS question_content,
      o.content AS option_content,
      o.id AS option_id,
      q.id AS question_id
    FROM question as q, option as o
    WHERE q.id = o.question_id
    AND q.id = ${nextQuestionId+1}
  `.trim().replace(/\s+/gi, " ");

  pool.query(query, (err, res) => {
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
    const response = { next, err, query }
    cb(null, response);
  })
}
