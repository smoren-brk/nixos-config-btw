import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Scope {
    id: store
    property var entries: []
    property var openCenter: null
    readonly property var history: entries.filter(e => !e.isTransient)
    readonly property var toasts: entries.filter(e => e.showToast).slice(0, 3)
    readonly property bool unread: history.some(e => e.unread)

    function markRead() {
        for (const entry of history) {
            entry.unread = false
            entry.showToast = false
        }
    }
    function remove(entry) {
        entries = entries.filter(e => e !== entry)
        entry.destroy()
    }
    function clearHistory() {
        for (const entry of history.slice()) entry.dismiss()
    }

    Component { id: entryTemplate; NotificationEntry {} }
    NotificationServer {
        keepOnReload: true
        bodySupported: true
        bodyMarkupSupported: false
        actionsSupported: true
        persistenceSupported: true
        onNotification: notice => {
            notice.tracked = true
            const entry = entryTemplate.createObject(store, {store: store, notice: notice})
            store.entries = [entry].concat(store.entries)
            if (store.history.length > 100) store.history[store.history.length - 1].dismiss()
        }
    }
}
