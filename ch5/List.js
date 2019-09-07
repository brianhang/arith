const assert = require('assert');

/*
 * Basic list construction
 */
const nil = c => n => n;
const cons = e => l => c => n => c(e)((l)(c)(n));
const toList = l => l(e => n => [e, ...n])([])

assert.deepStrictEqual(
  toList(
    cons(20)(cons(10)(cons(5)(nil)))
  ),
  [20, 10, 5],
);

/*
 * Church Booleans
 */
const T = t => f => t
const F = t => f => f
const OR = a => b => a(T)(b)
const AND = a => b => a(b)(F)
const toBool = b => b(true)(false)

/*
 * Church pairs
 */
const pair = x => y => f => f(x)(y)
const fst = p => p(T)
const snd = p => p(F)
const pairToJSPair = p => {
  let x = undefined;
  let y = undefined;
  const getY = newY => {
    y = newY;
  };
  const getX = newX => {
    x = newX;
    return getY;
  }
  p(getX);
  return [x, y];
}

/*
 * isnil for lists
 */
const isnil = l => l(x => AND(F))(T)

assert.strictEqual(
  toBool(
    isnil(cons(10)(cons(5)(nil)))
  ),
  false,
);
assert.strictEqual(
  toBool(
    isnil(nil)
  ),
  true,
);

/*
 * head of a list
 */
const head = l => l(h => _ => h)(undefined)

assert.strictEqual(
  head(
    cons(20)(cons(10)(cons(5)(nil)))
  ),
  20,
);
assert.strictEqual(
  head(cons(5)(nil)),
  5,
);
assert.strictEqual(
  head(nil),
  undefined,
);

/*
 * tail of a list
 */
const tail = l => fst(
  l
  (x => a => pair
             (snd(a))
             (cons(x)(snd(a)))
  )
  (pair(nil)(nil))
)

assert.deepStrictEqual(
  toList(tail(
    cons(20)(cons(10)(cons(5)(nil)))
  )),
  [10, 5],
);
assert.deepStrictEqual(
  toList(tail(cons(5)(nil))),
  [],
);
assert.deepStrictEqual(
  toList(tail(nil)),
  [],
);

