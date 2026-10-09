const test = require('node:test');
const assert = require('node:assert');
const { health } = require('./index');
test('reports OpsPilot health', () => {
  assert.strictEqual(health().app, 'OpsPilot');
});
