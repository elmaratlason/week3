'use strict';

let dbm;
let type;
let seed;

/**
  * We receive the dbmigrate dependency from dbmigrate initially.
  * This enables us to not have to rely on NODE_PATH.
  */
exports.setup = function(options, seedLink) {
  dbm = options.dbmigrate;
  type = dbm.dataType;
  seed = seedLink;
};
/*
 * column aggregate_id missing, should it be string? (like id)
*/
exports.up = function(db,callback) {
  db.createTable('eventlog', {
    timestamp:{ type:'datetime'},
    id: { type: 'string', primaryKey: true },
    json: 'string'
  }, callback);};

exports.down = function(db) {
  db.dropTable('eventlog', callback);
};

exports._meta = {
  "version": 1
};
