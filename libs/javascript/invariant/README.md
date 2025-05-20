# invariant

An `invariant` function takes a value, and if the value is [falsy](https://github.com/getify/You-Dont-Know-JS/blob/bdbe570600d4e1107d0b131787903ca1c9ec8140/up%20%26%20going/ch2.md#truthy--falsy) then the `invariant` function will throw. If the value is [truthy](https://github.com/getify/You-Dont-Know-JS/blob/bdbe570600d4e1107d0b131787903ca1c9ec8140/up%20%26%20going/ch2.md#truthy--falsy), then the function will not throw.

```ts
import { invariant } from '@dts-stn/invariant';

invariant(truthyValue, 'This should not throw!');

invariant(falsyValue, 'This will throw!');
// Error('Invariant violation: This will throw!');
```

## Why `@dts-stn/invariant`?

Unlike [`tiny-invariant`](https://www.npmjs.com/package/tiny-invariant), which strips error messages in production, `@dts-stn/invariant` preserves them. This is the fundamental reason for its creation, as these messages are vital for debugging production issues.

## Error Messages

`@dts-stn/invariant` allows you to pass a `string` message, or a function that returns a `string` message. Using a function that returns a message is helpful when your message is expensive to create.

```ts
import { invariant } from '@dts-stn/invariant';

invariant(condition, `Hello, ${name} - how are you today?`);

// Using a function is helpful when your message is expensive
invariant(value, () => getExpensiveMessage());
```

## Type narrowing

`@dts-stn/invariant` is useful for correctly narrowing types for `typescript`

```ts
const value: Person | null = { name: 'Alex' }; // type of value == 'Person | null'
invariant(value, 'Expected value to be a person');
// type of value has been narrowed to 'Person'
```

## API: `(condition: any, message?: string | (() => string)) => void`

- `condition` is required and can be anything
- `message` optional `string` or a function that returns a `string` (`() => string`)
