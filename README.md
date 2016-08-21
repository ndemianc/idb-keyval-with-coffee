# IDB-Keyval written in CoffeeScript

### This is implementation of the idb-keyval using CoffeeScript.
### Original idea and code for idb-keyval taken from here: https://www.npmjs.com/package/idb-keyval

### I like idea of idb-keyval, really super-simple-small keyval store build on top of IndexedDB
### I just cannot stop myself from making it even smaller, so I made a port of the idb-keyval to CoffeeScript :)

## How to compile:

```
npm install
coffee --compile idb-keyval.coffee
```

## How to use:

### Well the same way as original idb-keyval

### set:

```js
idbKeyval.set('hello', 'world');
idbKeyval.set('foo', 'bar');
```

Since this is IDB-backed, you can store anything structured-clonable (numbers, arrays, objects, dates, blobs etc).

All methods return promises:

```js
idbKeyval.set('hello', 'world')
  .then(() => console.log('It worked!'))
  .catch(err => console.log('It failed!', err));
```

### get:

```js
// logs: "world"
idbKeyval.get('hello').then(val => console.log(val));
```

### keys:

```js
// logs: ["hello", "foo"]
idbKeyval.keys().then(keys => console.log(keys));
```

### delete:

```js
idbKeyval.delete('hello');
```

### clear:

```js
idbKeyval.clear();
```

This is port of idb-keyval (https://github.com/jakearchibald/idb-keyval) to CoffeeScript!
