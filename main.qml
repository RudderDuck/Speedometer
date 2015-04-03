import QtQuick 2.2
import Ubuntu.Components 1.1
import QtPositioning 5.2
//import QtSensors 5.2
import "content"

/*!
    \brief MainView with a speedometer, some information and quit button.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    automaticOrientation: false // don't know how to get it to rotate properly
    backgroundColor: "#545454"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.rudderduck.speedometer"
    // factor for switching between metric and imperial (metric by default)
    property real factor : 3.6
    property int valid: 0
    Page {
        // Container rectangle
        Rectangle {
            id: rectangle
            anchors.centerIn: parent

            // Dial that gets updated according to the current speed
            Dial {
                id: dial
                anchors.centerIn: parent
                value: geoposition.position.speedValid===false ? 0 : geoposition.position.speed*factor
                metric: factor===3.6 ? 1 : 0
                valid: (new Date()-geoposition.position.timestamp)<=1500 ? 1 : 0
            }
        }
        // Quit button in the top right corner
        QuitButton {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
        }
        // Two toolbar buttons to switch between metric and imperial
        tools: ToolbarItems {
            ToolbarButton {
                action: Action {
                    text: "Metric"
                    // 1 m/s equals 3.6 km/h
                    onTriggered: factor = 3.6
                }
            }
            ToolbarButton {
                action: Action {
                    text: "Imperial"
                    // 1 m/s equals 2.23694 mph
                    onTriggered: factor = 2.23694
                }
            }
        }
        // Information on current version
        Text {
            text: "Version 0.7"
            anchors.left: parent.left
            anchors.top: parent.top
            color: "white"
        }
        // Information on timestamp latest (speed) reading
        Text {
            text: geoposition.position.timestamp ? geoposition.position.timestamp : '—'
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            color: "white"
        }
        // Information whether speed is valid or not
        Text {
            //text: geoposition.position.speedValid ? "Speed valid" : 'Speed invalid'
            text: (new Date()-geoposition.position.timestamp)<=1500 ? "Speed valid" : 'Speed invalid'
            //text: new Date()-geoposition.position.timestamp
            //text: Qt.formatDateTime(new Date(), "yyMMdd")
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: "white"
        }

    }
    // Device's current position
    PositionSource {
        id: geoposition
        active: true
        updateInterval: 1000
    }
}
