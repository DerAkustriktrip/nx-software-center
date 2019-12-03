import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami
import org.kde.mauikit 1.0 as Maui
import QtGraphicalEffects 1.0

import "ui/views/apps"
import "ui/views/store"
import "ui/views/system"
import "ui/views/search"
import "ui/views/progress"
import "ui/templates"
import "ui"

Maui.ApplicationWindow
{
    id: root

    Maui.App.iconName: "qrc:/nx-software-center.svg"
    Maui.App.description : "NX Software Center distributes AppImages for GNU Linux and APKS for Android"

    readonly property var views: ({apps: 0, store: 1, system: 2, search: 3, progress: 4})
    property int currentView: views.apps

    onSearchButtonClicked: currentView = views.search

    headBar.middleContent: [
        ToolButton
        {
            text: qsTr("Apps")
            icon.name: "nx-home"
            checkable: true
            checked: currentView === views.apps
            autoExclusive: true
            onClicked: root.currentView = views.apps
//            display: isWide ? ToolButton.TextBesideIcon : ToolButton.TextUnderIcon

            Maui.Badge
            {
                id: _countBadge
                text: "3"
                height: Maui.Style.iconSizes.small *1.4
                width: height
                Kirigami.Theme.backgroundColor: "#D81B60"
                anchors
                {
                    horizontalCenter: parent.left
                    top: parent.top
                }
            }
        },

        ToolButton
        {
            text: qsTr("Store")
            icon.name: "nx-software-center"
            checkable: true
            checked: currentView === views.store
            autoExclusive: true
            onClicked: root.currentView = views.store
//            display: isWide ? ToolButton.TextBesideIcon : ToolButton.TextUnderIcon
        },

        ToolButton
        {
            text: qsTr("System")
            icon.name: "start-here"
            checkable: true
            checked: currentView === views.system
            autoExclusive: true
            onClicked: root.currentView = views.system
//            display: isWide ? ToolButton.TextBesideIcon : ToolButton.TextUnderIcon
        }
    ]

    Item
    {
        id: _overlayButton
        visible: _progressView.isActive
        z: 999
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: Maui.Style.toolBarHeight
        anchors.bottomMargin: Maui.Style.toolBarHeight
        height: Maui.Style.toolBarHeight
        width: height

        Rectangle
        {
            id: _rec
            anchors.fill: parent
            color: Kirigami.Theme.highlightColor
            radius: Maui.Style.radiusV
            ToolButton
            {
                anchors.fill : parent
                icon.name: "appimage-store"
                icon.color: Kirigami.Theme.highlightedTextColor
                onClicked: currentView = views.progress
            }
        }

        DropShadow
        {
            id: rectShadow
            anchors.fill: parent
            cached: true
            horizontalOffset: 0
            verticalOffset: 0
            radius: 8.0
            samples: 16
            color: "#333"
            smooth: true
            source: _rec
        }

    }


    sideBar: CategoriesSidebar
    {
id: _categoriesSidebar
    }

    SwipeView
    {
        id: _swipeView
        anchors.fill: parent
        currentIndex: root.currentView
        onCurrentIndexChanged: root.currentView = currentIndex
        interactive: isMobile

        AppsView
        {
            id: _appsView
        }

        StoreView
        {
            id: _storeView
        }

        SystemView
        {
            id: _systemView
        }

        SearchView
        {
            id: _searchView
        }

        ProgressView
        {
            id: _progressView
        }
    }
}
