import { invariant } from '~/index';
import { describe, expectTypeOf, it } from 'vitest';

describe('type narrowing', () => {
  it('should correctly narrow a type (boolean)', async (): Promise<void> => {
    await new Promise<void>((resolve) => {
      try {
        const value = false;

        invariant(value, 'Value is false');
        // This will never be hit as value is false, but it is showing
        // That in order to get to this point the type would need to be true
        expectTypeOf(value).toEqualTypeOf<never>();
      } catch {
        // Ensures that invariant has thrown and goes through the catch block.
        resolve();
      }
    });
  });

  it('should correctly narrow a type (custom type)', () => {
    type Nullable<T> = T | null;

    interface Person {
      name: string;
    }

    function tryGetPerson(name: string): Nullable<Person> {
      return { name };
    }

    const alex: Nullable<Person> = tryGetPerson('Alex');

    invariant(alex);
    expectTypeOf(alex).toEqualTypeOf<Person>();
  });
});
