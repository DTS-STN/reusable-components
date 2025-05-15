import { invariant } from '~/invariant';
import { describe, expect, expectTypeOf, it, vi } from 'vitest';

describe('message behaviour', () => {
  it('should include a default message when an invariant does throw and no message is provided', () => {
    try {
      invariant(false);
    } catch (e) {
      invariant(e instanceof Error);
      expect(e.message).toEqual('Invariant failed');
    }
  });

  it('should include a provided message when an invariant does throw', () => {
    try {
      invariant(false, 'my message');
    } catch (e) {
      invariant(e instanceof Error);
      expect(e.message).toEqual('Invariant failed: my message');
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
    } catch (e) {
      invariant(e instanceof Error);
      expect(message).toHaveBeenCalled();
      expect(e.message).toEqual('Invariant failed: lazy message');
    }
  });
});

describe('throw behaviour', () => {
  it('should not throw if condition is truthy', () => {
    const truthy: unknown[] = [1, -1, true, {}, [], Symbol(), 'hi'];
    truthy.forEach((value: unknown) =>
      expect(() => invariant(value)).not.toThrow()
    );
  });

  it('should throw if the condition is falsy', () => {
    // https://github.com/getify/You-Dont-Know-JS/blob/master/types%20%26%20grammar/ch4.md#falsy-values
    const falsy: unknown[] = [undefined, null, false, +0, -0, NaN, ''];
    falsy.forEach((value: unknown) => expect(() => invariant(value)).toThrow());
  });
});

describe('type narrowing', () => {
  it('should correctly narrow a type (boolean)', async (): Promise<void> =>
    await new Promise((resolve) => {
      try {
        const value: boolean = false;

        invariant(value, 'Value is false');
        // this will never be hit as value is false, but it is showing
        // that in order to get to this point the type would need to be true
        expectTypeOf<never>(value);
      } catch {
        // Ensures that invariant has thrown and goes through the catch block.
        resolve();
      }
    }));

  it('should correctly narrow a type (custom type)', () => {
    type Nullable<T> = T | null;
    type Person = { name: string };

    function tryGetPerson(name: string): Nullable<Person> {
      return { name };
    }

    const alex: Nullable<Person> = tryGetPerson('Alex');

    invariant(alex);
    expectTypeOf<Person>(alex);
  });
});
