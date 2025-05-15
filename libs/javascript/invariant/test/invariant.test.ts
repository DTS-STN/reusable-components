import { invariant } from '~/index';
import { describe, expect, it, vi } from 'vitest';

describe('message behaviour', () => {
  it('should include a default message when an invariant does throw and no message is provided', () => {
    try {
      invariant(false);
    } catch (error) {
      invariant(error instanceof Error);
      expect(error.message).toEqual('Invariant failed');
    }
  });

  it('should include a provided message when an invariant does throw', () => {
    try {
      invariant(false, 'my message');
    } catch (error) {
      invariant(error instanceof Error);
      expect(error.message).toEqual('Invariant failed: my message');
    }
  });

  it('should not execute a message function if the invariant does not throw', () => {
    const message = vi.fn(() => 'lazy message');
    invariant(true, message);
    expect(message).not.toHaveBeenCalled();
  });

  it('should execute a message function if the invariant does throw', () => {
    const message = vi.fn(() => 'lazy message');
    try {
      invariant(false, message);
    } catch (error) {
      invariant(error instanceof Error);
      expect(message).toHaveBeenCalled();
      expect(error.message).toEqual('Invariant failed: lazy message');
    }
  });
});

describe('throw behaviour', () => {
  it('should not throw if condition is truthy', () => {
    const truthy: unknown[] = [1, -1, true, {}, [], Symbol(), 'hi'];
    for (const value of truthy) {
      expect(() => {
        invariant(value);
      }).not.toThrow();
    }
  });

  it('should throw if the condition is falsy', () => {
    // https://github.com/getify/You-Dont-Know-JS/blob/master/types%20%26%20grammar/ch4.md#falsy-values
    // eslint-disable-next-line unicorn/no-null
    const falsy: unknown[] = [undefined, null, false, +0, -0, Number.NaN, ''];
    for (const value of falsy) {
      expect(() => {
        invariant(value);
      }).toThrow();
    }
  });
});
