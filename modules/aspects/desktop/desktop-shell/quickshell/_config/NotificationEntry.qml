import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Scope {
    id: entry
    required property var store
    required property Notification notice
    property var archive: ({})
    property date received: new Date()
    property bool unread: false
    property bool showToast: false
    readonly property string app: notice?.appName || archive.app || ""
    readonly property string title: notice?.summary ?? archive.title ?? ""
    readonly property string body: notice?.body ?? archive.body ?? ""
    readonly property bool critical: notice ? notice.urgency === NotificationUrgency.Critical : !!archive.critical
    readonly property bool isTransient: notice?.transient ?? false

    function announce(replay) {
        if (!notice) return
        showToast = !replay && (!store.openCenter || isTransient)
        unread = !store.openCenter && !isTransient
        const timeout = notice.expireTimeout
        timer.stop()
        if (timeout > 0 || (timeout < 0 && !critical)) {
            timer.interval = timeout > 0 ? timeout : 6000
            timer.start()
        }
    }
    function dismiss() {
        if (notice) notice.dismiss()
        else store.remove(entry)
    }

    Component.onCompleted: announce(notice.lastGeneration)
    Timer {
        id: timer
        onTriggered: {
            entry.showToast = false
            // Default-timeout notifications stay actionable in the center.
            if (entry.notice && (entry.isTransient || entry.notice.expireTimeout > 0)) entry.notice.expire()
        }
    }
    Connections {
        target: entry.notice
        function onSummaryChanged() { entry.announce(false) }
        function onBodyChanged() { entry.announce(false) }
        function onExpireTimeoutChanged() { entry.announce(false) }
        function onUrgencyChanged() { entry.announce(false) }
        function onClosed(reason) {
            timer.stop()
            entry.showToast = false
            if (reason === NotificationCloseReason.Expired && !entry.isTransient) {
                entry.archive = {app: entry.app, title: entry.title, body: entry.body, critical: entry.critical}
                entry.notice = null
            } else {
                entry.store.remove(entry)
            }
        }
    }
}
