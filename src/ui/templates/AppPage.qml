import QtQuick 2.7
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.7 as Kirigami
import org.kde.mauikit 1.0 as Maui
import QtGraphicalEffects 1.0

import NXModels 1.0 as NX

Maui.Page
{
    id: control
    property alias appInfo : _appHandler.info
    property alias imagesInfo : _appHandler.images
    property alias downloadsInfo : _appHandler.downloads
    property alias urlsInfo : _appHandler.urls

    property alias buttonActions : _actionButtons.data
    property alias data : _appHandler.data
    property alias app : _appHandler

    signal exit()
    signal packageClicked(int index)

    padding: 0
    onGoBackTriggered: control.exit()

    NX.App
    {
        id: _appHandler
    }

    headBar.leftContent: [
        ToolButton
        {
            icon.name: "go-previous"
            onClicked: control.exit()
        },

        Kirigami.Separator
        {
            Layout.preferredHeight: Maui.Style.iconSizes.small
            width:  2
        }
    ]

    headBar.rightContent: Kirigami.ActionToolBar
    {
        Layout.fillWidth: true
        display: isWide ? ToolButton.TextBesideIcon : ToolButton.IconOnly
        hiddenActions: [
            Action
            {
                text: qsTr("Report spam")
            },
            Action
            {
                text: qsTr("Report missused")
            }
        ]

        actions: [
            Action
            {
                text: qsTr("Favorite")
                icon.name: "love"
            },

            Action
            {
                text: qsTr("Pling")
                icon.name: "headphones"
                onTriggered: Qt.openUrlExternally(appInfo.detailpage)
            },

            Action
            {
                text: qsTr("Screenshots")
                icon.name: "image-multiple"
            }

        ]
    }


    Kirigami.ScrollablePage
    {
        anchors.fill: parent
        padding: 0
        leftPadding: padding
        rightPadding: padding
        topPadding: padding
        bottomPadding: padding

        ColumnLayout
        {
            spacing: 0
            Item
            {
                id: _header
                Layout.preferredHeight: 230
                Layout.margins: 0
                Layout.fillWidth: true

                Rectangle
                {
                    id: _banner
                    height: parent.height
                    width: parent.width
                    color: "#333"
                    opacity: 0.2

                    Image
                    {
                        id: _bannerImage
                        anchors.fill: parent
                        source: imagesInfo[0].pic
                        sourceSize.height: parent.height /50
                        sourceSize.width: parent.width /50
                        fillMode: Image.PreserveAspectCrop
                        antialiasing: true
                        smooth: true
                        asynchronous: true
                    }
                }

                FastBlur
                {
                    id: fastBlur
                    anchors.fill: _banner
                    y:1
                    source: _banner
                    radius: 120
                    transparentBorder: false
                    cached: true
                }

                Rectangle
                {
                    anchors.fill: parent
                    color: Kirigami.Theme.viewBackgroundColor
                    opacity: 0.8
                }

                ColumnLayout
                {
                    id: _bannerInfo
                    anchors.centerIn: parent
                    spacing: 0

                    Image
                    {
                        Layout.preferredHeight: Maui.Style.iconSizes.huge
                        Layout.preferredWidth: Maui.Style.iconSizes.huge
                        Layout.alignment: Qt.AlignCenter
                        Layout.margins: Maui.Style.space.big
                        source: _bannerImage.source

                        sourceSize.height: height
                        sourceSize.width: width
                        fillMode: Image.PreserveAspectFit
                        antialiasing: true
                        smooth: true
                        asynchronous: true
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: appInfo.name
                        width: parent.width
                        Layout.alignment: Qt.AlignCenter
                        horizontalAlignment: Qt.AlignHCenter
                        elide: Text.ElideMiddle
                        wrapMode: Text.NoWrap
                        font.weight: Font.Bold
                        font.bold: true
                        font.pointSize: Maui.Style.fontSizes.big
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignCenter
                        horizontalAlignment: Qt.AlignHCenter
                        text: appInfo.version
                        elide: Text.ElideMiddle
                        wrapMode: Text.NoWrap
                        font.weight: Font.Light
                        font.pointSize: Maui.Style.fontSizes.medium
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignCenter
                        horizontalAlignment: Qt.AlignHCenter
                        text: appInfo.personid
                        elide: Text.ElideMiddle
                        wrapMode: Text.NoWrap
                        font.weight: Font.Light
                        font.pointSize: Maui.Style.fontSizes.medium
                    }

                    Row
                    {
                        id: _actionButtons
                        Layout.fillWidth: true
                        Layout.margins: Maui.Style.space.big
                        spacing: Maui.Style.space.medium
                        Layout.preferredHeight: implicitHeight
                    }
                }
            }

            Kirigami.Separator
            {
                Layout.fillWidth: true
            }

            ColumnLayout
            {
                id: _div1

                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight
                Layout.margins: Maui.Style.space.big

                RowLayout
                {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Maui.Style.toolBarHeight
                    Layout.margins: Maui.Style.space.medium
                    spacing:  Maui.Style.space.big

                    Kirigami.Icon
                    {
                        visible: isWide
                        Layout.preferredHeight: Maui.Style.iconSizes.medium
                        Layout.preferredWidth: Maui.Style.iconSizes.medium
                        Layout.alignment: Qt.AlignHCenter
                        source: "view-list-details"
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Description")
                        font.weight: Font.Bold
                        font.bold: true
                    }
                }

                Label
                {
                    Layout.fillWidth: true
                    font.weight: Font.Light
                    elide: Text.ElideRight
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    text: appInfo.description
                }
            }


            Kirigami.Separator
            {
                Layout.fillWidth: true
            }

            ColumnLayout
            {
                id: _div2

                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight
                Layout.margins: Maui.Style.space.big

                RowLayout
                {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Maui.Style.toolBarHeight
                    Layout.margins: Maui.Style.space.medium
                    spacing:  Maui.Style.space.big

                    Kirigami.Icon
                    {
                        visible: isWide
                        Layout.preferredHeight: Maui.Style.iconSizes.medium
                        Layout.preferredWidth: Maui.Style.iconSizes.medium
                        Layout.alignment: Qt.AlignHCenter
                        source: "media-playlist-append"
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Details")
                        font.weight: Font.Bold
                        font.bold: true
                    }
                }

                Column
                {
                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("License")
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                        font.weight: Font.Light
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: appInfo.license || "-"
                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }

                Column
                {
                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Version")
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                        font.weight: Font.Light
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: appInfo.version || "-"
                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }

                Column
                {
                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Updated")
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                        font.weight: Font.Light
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: appInfo.changed || "-"
                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }

                Column
                {
                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Created")
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                        font.weight: Font.Light
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: appInfo.created || "-"
                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }

                Column
                {
                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Author")
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                        font.weight: Font.Light
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: appInfo.personid || "-"
                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }

                Column
                {
                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Language")
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                        font.weight: Font.Light
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: appInfo.language || "-"
                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }

                Column
                {
                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Tags")
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                        font.weight: Font.Light
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: appInfo.tags || "-"
                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }

                Column
                {
                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Score")
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                        font.weight: Font.Light
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: appInfo.score || "-"
                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }

                Column
                {
                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Downloads")
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                        font.weight: Font.Light
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: appInfo.totaldownloads || "-"
                        elide: Text.ElideRight
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }
            }


            Kirigami.Separator
            {
                Layout.fillWidth: true
            }


            ColumnLayout
            {
                id: _div3
                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight
                Layout.margins: Maui.Style.space.big

                RowLayout
                {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Maui.Style.toolBarHeight
                    Layout.margins: Maui.Style.space.medium
                    spacing:  Maui.Style.space.big

                    Kirigami.Icon
                    {
                        visible: isWide
                        Layout.preferredHeight: Maui.Style.iconSizes.medium
                        Layout.preferredWidth: Maui.Style.iconSizes.medium
                        Layout.alignment: Qt.AlignHCenter
                        source: "media-playlist-append"
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Packages")
                        font.weight: Font.Bold
                        font.bold: true
                    }
                }

                Maui.GridView
                {
                    id: _packagesGrid
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: control.downloadsInfo
                    adaptContent: false
                    centerContent: true
                    itemWidth: width * 0.5
                    itemHeight: 100

                    delegate: Maui.ItemDelegate
                    {
                        property var info : modelData
                        Kirigami.Theme.backgroundColor: "grey"
                        Kirigami.Theme.textColor: "white"
                        Kirigami.Theme.highlightColor: "#333"

                        width: _packagesGrid.cellWidth * 0.9
                        height: _packagesGrid.cellHeight * 0.9

                        Maui.ListItemTemplate
                        {
                            anchors.fill: parent
                            label1.text: info.name
                            label1.font.weight: Font.Bold
                            label1.font.bold: true
                            label2.text: info.tags
                            label3.text: info.packageArch
                            label4.text: info.size
                            iconSource: "appimage-store"
                        }

                        onClicked:
                        {
                            control.packageClicked(index)
                        }

                    }
                }
            }

            ListView
            {
                id: _div4

                Layout.fillWidth: true
                Layout.preferredHeight: 500
                clip: true
                model: control.imagesInfo

                orientation: ListView.Horizontal
                snapMode: ListView.SnapOneItem

                delegate:Item
                {
                    height: _div4.height
                    width: _div4.width

                    Maui.ImageViewer
                    {
                        anchors.fill: parent
                        anchors.margins: Maui.Style.space.big
                        source: modelData.pic
                    }
                }
            }


            ColumnLayout
            {
                id: _div5

                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight
                Layout.margins: Maui.Style.space.big

                RowLayout
                {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Maui.Style.toolBarHeight
                    Layout.margins: Maui.Style.space.medium
                    spacing:  Maui.Style.space.big

                    Kirigami.Icon
                    {
                        visible: isWide
                        Layout.preferredHeight: Maui.Style.iconSizes.medium
                        Layout.preferredWidth: Maui.Style.iconSizes.medium
                        Layout.alignment: Qt.AlignHCenter
                        source: "media-playlist-append"
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Changelog")
                        font.weight: Font.Bold
                        font.bold: true
                    }
                }
                Label
                {
                    Layout.fillWidth: true
                    font.weight: Font.Light
                    elide: Text.ElideRight
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    text: appInfo.changelogVersion
                }

                Label
                {
                    Layout.fillWidth: true
                    font.weight: Font.Light
                    elide: Text.ElideRight
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    text: appInfo.changelogInfo
                }
            }


            ColumnLayout
            {
                id: _div6

                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight
                Layout.margins: Maui.Style.space.big

                RowLayout
                {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Maui.Style.toolBarHeight
                    Layout.margins: Maui.Style.space.medium
                    spacing:  Maui.Style.space.big

                    Kirigami.Icon
                    {
                        visible: isWide
                        Layout.preferredHeight: Maui.Style.iconSizes.medium
                        Layout.preferredWidth: Maui.Style.iconSizes.medium
                        Layout.alignment: Qt.AlignHCenter
                        source: "media-playlist-append"
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: qsTr("Comments")
                        font.weight: Font.Bold
                        font.bold: true
                    }
                }

                Column
                {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Repeater
                    {
                        model: control.appInfo.comments.split(",")
                        Label
                        {
                            Layout.fillWidth: true
                            font.weight: Font.Light
                            elide: Text.ElideRight
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            text: modelData
                        }

                    }
                }
            }

        }
    }
}
