import { describe, expect, it } from 'vitest';
import { formatInr } from './format.js';

describe('formatInr', () => {
  it('uses Indian digit grouping without paise', () => {
    expect(formatInr(1031400)).toBe('₹10,31,400');
  });
});
