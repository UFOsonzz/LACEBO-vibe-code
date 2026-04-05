import db from '../database/connection.js';

export function isDev(worldId, userId) {
  return db.prepare(
    "SELECT id FROM world_members WHERE world_id = ? AND user_id = ? AND role = 'dev' AND status = 'approved'"
  ).get(worldId, userId);
}

export function isMember(worldId, userId) {
  return db.prepare(
    "SELECT * FROM world_members WHERE world_id = ? AND user_id = ? AND status = 'approved'"
  ).get(worldId, userId);
}

export function addCredits(worldId, userId, amount) {
  db.prepare(
    'UPDATE world_members SET credits = credits + ? WHERE world_id = ? AND user_id = ?'
  ).run(amount, worldId, userId);
}
