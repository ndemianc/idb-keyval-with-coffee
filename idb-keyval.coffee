do ->
  'use strict'
  utils =
    getDB: ->
      unless db
        db = new Promise (resolve, reject) ->
          openreq = indexedDB.open 'keyval-store', 1
          openreq.onerror = -> reject openreq.error
          openreq.onupgradeneeded = -> openreq.result.createObjectStore 'keyval'
          openreq.onsuccess = -> resolve openreq.result
      return db

    withStore: (type, callback) ->
      return utils.getDB()
      .then (db) ->
        new Promise (resolve, reject) ->
          transaction = db.transaction 'keyval', type
          transaction.oncomplete = -> resolve()
          transaction.onerror = -> reject transaction.error
          callback(transaction.objectStore 'keyval')

  idbKeyval =
    get: (key, req = null) ->
      utils.withStore 'readonly', (store) -> req = store.get key
      .then -> req.result
    set: (key, value) ->
      utils.withStore 'readwrite', (store) -> store.put value, key
    delete: (key) ->
      utils.withStore 'readwrite', (store) -> store.delete key
    clear: ->
      utils.withStore 'readwrite', (store) -> store.clear()
    keys: ->
      keys = []
      utils.withStore 'readonly', (store) ->
        func = store.openKeyCursor ? store.openCursor
        func.call(store).onsuccess = ->
          return unless this.result
          keys.push this.result.key
          this.result.continue()
      .then -> keys

  root = exports ? self
  root.idbKeyval = idbKeyval

